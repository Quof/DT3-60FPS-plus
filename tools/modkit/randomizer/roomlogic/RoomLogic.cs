// RoomLogic: the DT3+ Randomizer's logic from the rooms themselves. Reads rooms.txt (roomdata.py: each room's solids,
// platforms, hazards, water, gates, springs, exits and locations), draws each room from its instances' sprite masks,
// finds where the player can stand, runs the game's own 30fps movement (characterStepEvent, pMoveToWrapOrig, moveTo30)
// from there with the moves each ability allows, and joins the rooms by their exits. Writes what each location needs:
// its alternatives, each the abilities, ability set levels and keys that get the player there from the start.
//
// build: csc /nologo /O+ /out:RoomLogic.exe /r:System.Drawing.dll RoomLogic.cs   (roomlogic.py builds and runs it)
// run:   RoomLogic.exe <project folder> <rooms.txt> <roomlogic.txt> [room ...]   (rooms: only those, for checking); the
//        regions' and exits' needs (roomlogic_regions.txt) and the log go next to rooms.txt
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

// ---------------------------------------------------------------- requirements
// what a way needs: counts of the progression items (4 bits each), the locked doors' keys (a bit each, by objectNum),
// and events (a bit each, E0 then E1: Req.EventNames)
public struct Req : IEquatable<Req>
{
    public ulong C, K, E0, E1;
    // (varia: the Varia Suit, Gate 5's lava harmless; cursed: how many of the Trial Master's three cursed equipment pieces)
    public const int DJUMP = 0, ADASH = 1, GDASH = 2, HIJUMP = 3, MARIO = 4, LINK = 5, BELMONT = 6, MEGAMAN = 7, SAMUS = 8,
        GAMEJ = 9, GAMEC = 10, VARIA = 11, CURSED = 12, N = 13;
    public static readonly string[] Names = { "djump", "adash", "gdash", "hijump", "mario", "link", "belmont", "megaman",
        "samus", "gamej", "gamec", "varia", "cursed" };
    public int Get(int i) { return (int)((C >> (i * 4)) & 15); }
    public Req With(int i, int n)
    {
        Req r = this;
        if (n > Get(i)) r.C = (C & ~(15UL << (i * 4))) | ((ulong)n << (i * 4));
        return r;
    }
    public static Req Max(Req a, Req b)
    {
        Req r; r.K = a.K | b.K; r.E0 = a.E0 | b.E0; r.E1 = a.E1 | b.E1; r.C = 0;
        for (int i = 0; i < N; i++) r.C |= (ulong)Math.Max(a.Get(i), b.Get(i)) << (i * 4);
        return r;
    }
    public bool Le(Req b)
    {
        if ((K & ~b.K) != 0 || (E0 & ~b.E0) != 0 || (E1 & ~b.E1) != 0) return false;
        for (int i = 0; i < N; i++) if (Get(i) > b.Get(i)) return false;
        return true;
    }
    // (needing nothing at all; and the whole of it as text, for telling joins apart)
    public bool None { get { return C == 0 && K == 0 && E0 == 0 && E1 == 0; } }
    public string Id { get { return C + ":" + K + ":" + E0 + ":" + E1; } }
    public bool Equals(Req o) { return C == o.C && K == o.K && E0 == o.E0 && E1 == o.E1; }
    public override bool Equals(object o) { return o is Req && Equals((Req)o); }
    public override int GetHashCode() { return (C ^ (K * 0x9E3779B97F4A7C15UL) ^ (E0 * 0xC2B2AE3D27D4EB4FUL) ^ (E1 * 0x165667B19E3779F9UL)).GetHashCode(); }
    public override string ToString()
    {
        var p = new List<string>();
        for (int i = 0; i < N; i++)
        {
            int n = Get(i);
            if (n == 1 && (i == DJUMP || i == ADASH || i == GDASH || i == MARIO || i == VARIA)) p.Add(Names[i]);
            else if (n > 0) p.Add(Names[i] + ":" + n);
        }
        for (int k = 0; k < 64; k++) if ((K & (1UL << k)) != 0) p.Add("key:" + k);
        var ev = new List<string>();
        lock (EventNames)
            for (int k = 0; k < 128; k++) if (((k < 64 ? E0 >> k : E1 >> (k - 64)) & 1) != 0) ev.Add("event:" + EventNames[k]);
        ev.Sort(string.CompareOrdinal);   // (by name, as solve.py writes them)
        p.AddRange(ev);
        return p.Count == 0 ? "-" : string.Join(",", p);
    }
    // events (something the game remembers that opens a way elsewhere: event:<name>, solve.py's events.txt says what
    // makes each happen; a room's spot: <room>/<spot>): a bit each, numbered as they're first read
    public static readonly List<string> EventNames = new List<string>();
    // "a|b": alternatives; each comma-separated item:count (key:N a door's key, event:NAME an event, attack any ability
    // set's attack)
    public static List<Req> ParseAlts(string s)
    {
        var outp = new List<Req>();
        foreach (var alt in s.Split('|'))
        {
            var rs = new List<Req> { new Req() };
            foreach (var tok0 in alt.Split(','))
            {
                var tok = tok0.Trim();
                if (tok == "" || tok == "-") continue;
                if (tok == "attack")
                {
                    var nr = new List<Req>();
                    foreach (var r in rs) foreach (int i in new[] { LINK, BELMONT, MEGAMAN, SAMUS }) nr.Add(r.With(i, 1));
                    rs = nr; continue;
                }
                var kv = tok.Split(':');
                if (kv[0] == "event")
                {
                    int bit;
                    lock (EventNames) { bit = EventNames.IndexOf(kv[1]); if (bit < 0) { EventNames.Add(kv[1]); bit = EventNames.Count - 1; } }
                    if (bit >= 128) throw new Exception("more than 128 events: " + kv[1]);
                    for (int j = 0; j < rs.Count; j++) { var r = rs[j]; if (bit < 64) r.E0 |= 1UL << bit; else r.E1 |= 1UL << (bit - 64); rs[j] = r; }
                    continue;
                }
                int n = kv.Length > 1 ? int.Parse(kv[1]) : 1;
                for (int j = 0; j < rs.Count; j++)
                {
                    var r = rs[j];
                    if (kv[0] == "key") r.K |= 1UL << n;
                    else r = r.With(Array.IndexOf(Names, kv[0]), n);
                    rs[j] = r;
                }
            }
            foreach (var r in rs) Pareto.Add(outp, r);
        }
        return outp;
    }
}

public static class Pareto
{
    // adds r to a set of alternatives none of which needs more than another: false if one already needed no more
    public static bool Add(List<Req> set, Req r)
    {
        for (int i = 0; i < set.Count; i++) if (set[i].Le(r)) return false;
        set.RemoveAll(q => r.Le(q));
        set.Add(r);
        return true;
    }
    public static List<Req> Product(List<Req> a, List<Req> b)
    {
        var o = new List<Req>();
        foreach (var x in a) foreach (var y in b) Add(o, Req.Max(x, y));
        return o;
    }
}

// ---------------------------------------------------------------- sprite masks
class Mask
{
    public int W, H, OX, OY;
    public bool[] P;
    static Dictionary<string, Mask> cache = new Dictionary<string, Mask>();
    public static string Root;

    static Dictionary<string, string> Kv(string p)
    {
        var d = new Dictionary<string, string>();
        if (!File.Exists(p)) return d;
        foreach (var l in File.ReadAllLines(p)) { int i = l.IndexOf('='); if (i > 0) d[l.Substring(0, i).Trim()] = l.Substring(i + 1).Trim(); }
        return d;
    }

    public static Mask Get(string name)
    {
        lock (cache)
        {
            Mask m;
            if (cache.TryGetValue(name, out m)) return m;
            m = Load(name);
            cache[name] = m;
            return m;
        }
    }

    // one frame of a sprite whose frames are each their own mask (per_frame_colliders: a weapon's swing)
    public static Mask GetFrame(string name, int frame)
    {
        lock (cache)
        {
            Mask m;
            string key = name + "#" + frame;
            if (cache.TryGetValue(key, out m)) return m;
            m = Load(name, frame);
            cache[key] = m;
            return m;
        }
    }

    static Mask Load(string name, int frame = 0)
    {
        string dir = Path.Combine(Root, "sprites", name);
        var k = Kv(Path.Combine(dir, "sprite.txt"));
        string png = Path.Combine(dir, frame + ".png");
        if (k.Count == 0 || !File.Exists(png)) return null;
        var m = new Mask();
        int shape = k.ContainsKey("collision_shape") ? int.Parse(k["collision_shape"]) : 0;
        int tol = k.ContainsKey("alpha_tolerance") ? int.Parse(k["alpha_tolerance"]) : 0;
        m.OX = int.Parse(k["origin_x"]); m.OY = int.Parse(k["origin_y"]);
        using (var bmp = new Bitmap(png))
        {
            m.W = bmp.Width; m.H = bmp.Height;
            int bl = k.ContainsKey("bbox_left") ? int.Parse(k["bbox_left"]) : 0, bt = k.ContainsKey("bbox_top") ? int.Parse(k["bbox_top"]) : 0;
            int br = k.ContainsKey("bbox_right") ? int.Parse(k["bbox_right"]) : m.W - 1, bb = k.ContainsKey("bbox_bottom") ? int.Parse(k["bbox_bottom"]) : m.H - 1;
            // the box as the game has it: bbox_type 0 (automatic) is worked out from the frames' pixels, 1 is the whole
            // image; only a manual one (2) is the stored numbers. (Stored automatic boxes can be out of date: the slopes'
            // left out their corner pixels, a 1px dip where two meet, and the fading platform's only its bottom row,
            // 15px under where the game has the player stand on it)
            int btype = k.ContainsKey("bbox_type") ? int.Parse(k["bbox_type"]) : 0;
            if (btype == 1) { bl = 0; bt = 0; br = m.W - 1; bb = m.H - 1; }
            else if (btype == 0) PixelBox(dir, tol, ref bl, ref bt, ref br, ref bb);
            m.P = new bool[m.W * m.H];
            var data = bmp.LockBits(new Rectangle(0, 0, m.W, m.H), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            var raw = new byte[data.Stride * m.H];
            System.Runtime.InteropServices.Marshal.Copy(data.Scan0, raw, 0, raw.Length);
            bmp.UnlockBits(data);
            double cx = (bl + br) / 2.0, cy = (bt + bb) / 2.0, rx = (br - bl + 1) / 2.0, ry = (bb - bt + 1) / 2.0;
            for (int y = Math.Max(0, bt); y <= Math.Min(m.H - 1, bb); y++)
                for (int x = Math.Max(0, bl); x <= Math.Min(m.W - 1, br); x++)
                {
                    bool on;
                    if (shape == 0) on = raw[y * data.Stride + x * 4 + 3] > tol;
                    else if (shape == 1) on = true;
                    else if (shape == 2) { double dx = (x + 0.5 - cx - 0.5) / rx, dy = (y + 0.5 - cy - 0.5) / ry; on = dx * dx + dy * dy <= 1.0; }
                    else { double dx = Math.Abs(x - cx) / rx, dy = Math.Abs(y - cy) / ry; on = dx + dy <= 1.0; }
                    m.P[y * m.W + x] = on;
                }
        }
        return m;
    }

    // an automatic box: around every frame's pixels over the alpha tolerance (the box stays as given if there are none)
    static void PixelBox(string dir, int tol, ref int bl, ref int bt, ref int br, ref int bb)
    {
        int l = int.MaxValue, t = int.MaxValue, r = int.MinValue, b = int.MinValue;
        for (int f = 0; File.Exists(Path.Combine(dir, f + ".png")); f++)
            using (var fb = new Bitmap(Path.Combine(dir, f + ".png")))
            {
                var data = fb.LockBits(new Rectangle(0, 0, fb.Width, fb.Height), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
                var raw = new byte[data.Stride * fb.Height];
                System.Runtime.InteropServices.Marshal.Copy(data.Scan0, raw, 0, raw.Length);
                fb.UnlockBits(data);
                for (int y = 0; y < fb.Height; y++)
                    for (int x = 0; x < fb.Width; x++)
                        if (raw[y * data.Stride + x * 4 + 3] > tol) { l = Math.Min(l, x); t = Math.Min(t, y); r = Math.Max(r, x); b = Math.Max(b, y); }
            }
        if (l <= r) { bl = l; bt = t; br = r; bb = b; }
    }

    // calls set(x, y) for every room pixel the instance covers (its mask at its place, scale and angle); clip: only those
    // in it (left, top, right, bottom)
    public void Stamp(double x, double y, double xs, double ys, double ang, Action<int, int> set, int[] clip = null)
    {
        if (xs == 0 || ys == 0) return;
        double a = ang * Math.PI / 180, ca = Math.Cos(a), sa = Math.Sin(a);
        bool plain = Math.Abs(ang) < 1e-9;
        double minx = double.MaxValue, miny = double.MaxValue, maxx = double.MinValue, maxy = double.MinValue;
        foreach (var c in new[] { new[] { 0.0, 0.0 }, new[] { (double)W, 0.0 }, new[] { 0.0, (double)H }, new[] { (double)W, (double)H } })
        {
            double dx = (c[0] - OX) * xs, dy = (c[1] - OY) * ys;
            double sx = plain ? dx : dx * ca + dy * sa, sy = plain ? dy : -dx * sa + dy * ca;
            minx = Math.Min(minx, x + sx); maxx = Math.Max(maxx, x + sx); miny = Math.Min(miny, y + sy); maxy = Math.Max(maxy, y + sy);
        }
        int x0 = (int)Math.Floor(minx), x1 = (int)Math.Ceiling(maxx), y0 = (int)Math.Floor(miny), y1 = (int)Math.Ceiling(maxy);
        if (clip != null) { x0 = Math.Max(x0, clip[0]); y0 = Math.Max(y0, clip[1]); x1 = Math.Min(x1, clip[2] + 1); y1 = Math.Min(y1, clip[3] + 1); }
        for (int py = y0; py < y1; py++)
            for (int px = x0; px < x1; px++)
            {
                double sx = px + 0.5 - x, sy = py + 0.5 - y;
                double dx = plain ? sx : sx * ca - sy * sa, dy = plain ? sy : sx * sa + sy * ca;
                int u = (int)Math.Floor(OX + dx / xs), v = (int)Math.Floor(OY + dy / ys);
                if (u < 0 || v < 0 || u >= W || v >= H) continue;
                if (P[v * W + u]) set(px, py);
            }
    }
}

// ---------------------------------------------------------------- bit grids (rows and columns, for quick line checks)
class Bits2D
{
    public const int M = 320;   // room pixels outside the room on every side (solids reach past the edges)
    public int GW, GH, RW, CW;
    public ulong[] Rows, Cols;
    public bool Any;
    public Bits2D(int w, int h)
    {
        GW = w + 2 * M; GH = h + 2 * M; RW = (GW + 63) >> 6; CW = (GH + 63) >> 6;
        Rows = new ulong[(long)GH * RW]; Cols = new ulong[(long)GW * CW];
    }
    public void Set(int x, int y)
    {
        int gx = x + M, gy = y + M;
        if (gx < 0 || gy < 0 || gx >= GW || gy >= GH) return;
        Rows[(long)gy * RW + (gx >> 6)] |= 1UL << (gx & 63);
        Cols[(long)gx * CW + (gy >> 6)] |= 1UL << (gy & 63);
        Any = true;
    }
    // (a copy of it, to change)
    public Bits2D Copy() { var b = (Bits2D)MemberwiseClone(); b.Rows = (ulong[])Rows.Clone(); b.Cols = (ulong[])Cols.Clone(); return b; }
    public void Clear(int x, int y)
    {
        int gx = x + M, gy = y + M;
        if (gx < 0 || gy < 0 || gx >= GW || gy >= GH) return;
        Rows[(long)gy * RW + (gx >> 6)] &= ~(1UL << (gx & 63));
        Cols[(long)gx * CW + (gy >> 6)] &= ~(1UL << (gy & 63));
    }
    public bool Get(int x, int y)
    {
        int gx = x + M, gy = y + M;
        if (gx < 0 || gy < 0 || gx >= GW || gy >= GH) return false;
        return (Rows[(long)gy * RW + (gx >> 6)] & (1UL << (gx & 63))) != 0;
    }
    static bool Span(ulong[] a, long b, int s0, int s1)
    {
        int w0 = s0 >> 6, w1 = s1 >> 6;
        if (w0 == w1) return (a[b + w0] & ((~0UL << (s0 & 63)) & (~0UL >> (63 - (s1 & 63))))) != 0;
        if ((a[b + w0] & (~0UL << (s0 & 63))) != 0) return true;
        for (int w = w0 + 1; w < w1; w++) if (a[b + w] != 0) return true;
        return (a[b + w1] & (~0UL >> (63 - (s1 & 63)))) != 0;
    }
    public bool Row(int y, int x0, int x1)
    {
        if (!Any) return false;
        int gy = y + M; if (gy < 0 || gy >= GH) return false;
        int g0 = Math.Max(0, x0 + M), g1 = Math.Min(GW - 1, x1 + M); if (g0 > g1) return false;
        return Span(Rows, (long)gy * RW, g0, g1);
    }
    public bool Col(int x, int y0, int y1)
    {
        if (!Any) return false;
        int gx = x + M; if (gx < 0 || gx >= GW) return false;
        int g0 = Math.Max(0, y0 + M), g1 = Math.Min(GH - 1, y1 + M); if (g0 > g1) return false;
        return Span(Cols, (long)gx * CW, g0, g1);
    }
    public bool Box(int x0, int y0, int x1, int y1)
    {
        if (!Any) return false;
        if (x1 - x0 <= y1 - y0) { for (int x = x0; x <= x1; x++) if (Col(x, y0, y1)) return true; }
        else { for (int y = y0; y <= y1; y++) if (Row(y, x0, x1)) return true; }
        return false;
    }
}

// a thing the player touches (an exit, a location, a spring, a gate): its pixels
class Shape
{
    public int X0, Y0, X1, Y1;
    public HashSet<long> Px = new HashSet<long>();
    public static long Key(int x, int y) { return ((long)x << 32) ^ (uint)y; }
    public Shape(Mask m, double x, double y, double xs, double ys, double a, int[] clip = null)
    {
        X0 = int.MaxValue; Y0 = int.MaxValue; X1 = int.MinValue; Y1 = int.MinValue;
        m.Stamp(x, y, xs, ys, a, (px, py) =>
        {
            Px.Add(Key(px, py));
            if (px < X0) X0 = px; if (px > X1) X1 = px; if (py < Y0) Y0 = py; if (py > Y1) Y1 = py;
        }, clip);
    }
    public bool Empty { get { return Px.Count == 0; } }
    public bool Hits(int x0, int y0, int x1, int y1)
    {
        if (x1 < X0 || x0 > X1 || y1 < Y0 || y0 > Y1) return false;
        int ax = Math.Max(x0, X0), bx = Math.Min(x1, X1), ay = Math.Max(y0, Y0), by = Math.Min(y1, Y1);
        if ((long)(bx - ax + 1) * (by - ay + 1) > Px.Count)
        {
            foreach (var k in Px) { int px = (int)(k >> 32), py = (int)(uint)k; if (px >= x0 && px <= x1 && py >= y0 && py <= y1) return true; }
            return false;
        }
        for (int py = ay; py <= by; py++) for (int px = ax; px <= bx; px++) if (Px.Contains(Key(px, py))) return true;
        return false;
    }
}

// ---------------------------------------------------------------- rooms.txt
class Inst
{
    public char K; public string Spr; public double X, Y, XS, YS, A; public string[] F;
    // (a line there only in one state of a group, rooms.txt's "@group=state" in front of it: CondG the group's number,
    // -1 for every state)
    public int CondG = -1, CondV;
}
class RoomData
{
    public string Name, AreaName = ""; public int W, H, Area; public bool IsMap; public bool Boss;
    // a map the player walks across as an icon (Zelda II's overworld): AnalyzeWalkMap
    public bool WalkMap;
    public List<Inst> I = new List<Inst>();
    // what the room's switches change: its groups (pb the sliding blocks and gears, rb the red and blue blocks, b<GID> a
    // barrier), and the state it starts in (a bit a group: 1 its other state)
    public List<string> Groups = new List<string>();
    public int Initial;
    // a state's solids that stay in every state (the bricks the head can't get to: AnalyzeStates)
    public HashSet<Inst> KeepSolid;
    public int Group(string name) { int i = Groups.IndexOf(name); if (i < 0) { Groups.Add(name); i = Groups.Count - 1; } return i; }
    // the groups worked out (a bit each in a state): 4, or with a way in's groups (WS) 8 (only the states the player can be
    // in are worked out: AnalyzeStates)
    public int MaxG { get { return Math.Min(Groups.Count, WayIn.Count > 0 ? 8 : 4); } }
    // the states the player carries from room to room (rb: the red and blue switches' state; water: the Water Palace's
    // level, as two groups: w1 level 1 (the highest), w3 level 3 (the lowest), neither level 2); what the room sets one to
    // as the player comes in (rb 0 or 1, water 1-3); and whether enemies' shots or traps hit its red/blue switches
    public HashSet<string> Carried = new HashSet<string>();
    public Dictionary<string, int> Resets = new Dictionary<string, int>();
    public bool RbAuto;
    // a party split room's idle partner: where it starts (the player can swap to it)
    public List<int[]> Partner = new List<int[]>();
    // what a way in sets as the player comes in by it (rooms.txt's WS: the room's code makes the room one way or another
    // by where the player comes in, a group's state): its place's key -> (the group's number, its state)
    public Dictionary<long, List<int[]>> WayIn = new Dictionary<long, List<int[]>>();
    public int WayState(long key, int s)
    {
        List<int[]> l;
        if (WayIn.TryGetValue(key, out l)) foreach (var g in l) s = g[1] == 1 ? s | (1 << g[0]) : s & ~(1 << g[0]);
        return s;
    }
    public int Level(int s)
    {
        int a = Groups.IndexOf("w1"), b = Groups.IndexOf("w3");
        if (a >= 0 && a < MaxG && ((s >> a) & 1) == 1) return 1;
        if (b >= 0 && b < MaxG && ((s >> b) & 1) == 1) return 3;
        return 2;
    }
    // (a state that can't be: both levels' groups set)
    public bool BadLevel(int s)
    {
        int a = Groups.IndexOf("w1"), b = Groups.IndexOf("w3");
        return a >= 0 && b >= 0 && a < MaxG && b < MaxG && ((s >> a) & 1) == 1 && ((s >> b) & 1) == 1;
    }
    public int WithLevel(int s, int lv)
    {
        int a = Groups.IndexOf("w1"), b = Groups.IndexOf("w3");
        if (a >= 0) s = lv == 1 ? s | (1 << a) : s & ~(1 << a);
        if (b >= 0) s = lv == 3 ? s | (1 << b) : s & ~(1 << b);
        return s;
    }
    // a carried group's value in a state ("rb 1", "water 2"), and the state with it set
    public int Carry(string g, int s) { return g == "water" ? Level(s) : (s >> Groups.IndexOf(g)) & 1; }
    public int WithCarry(string g, int s, int v) { return g == "water" ? WithLevel(s, v) : (v == 1 ? s | (1 << Groups.IndexOf(g)) : s & ~(1 << Groups.IndexOf(g))); }
}

class Exit
{
    public Shape S; public string To; public int NX, NY, Type; public bool InRoom; public int IX, IY; public string Obj;   // IX,IY: where it's placed
    // an exit whose way goes by a carried group (the Forest Palace's crystals turn its rooms over): the group's number,
    // and where it leads in its state 1 (To, NX, NY: its state 0)
    public int Group = -1; public string To1; public int NX1, NY1;
    // where it leads in a room state (a bit a group)
    public string ToIn(int s) { return Group >= 0 && ((s >> Group) & 1) == 1 ? To1 : To; }
    public int NXIn(int s) { return Group >= 0 && ((s >> Group) & 1) == 1 ? NX1 : NX; }
    public int NYIn(int s) { return Group >= 0 && ((s >> Group) & 1) == 1 ? NY1 : NY; }
}
class Loc { public int Type, Num; public Shape S; public string Label; }
// a spot: somewhere whose reaching opens a way elsewhere (a colored switch the partner holds, a colored key): the room
// file says what reaching it needs, and solve.py makes it the event <room>/<tag> that the barriers it opens need
class Spot { public string Tag; public Shape S; }
class Gate { public Shape S; public List<Req> Need; public string Name; public int Group; public bool Hazard; }   // Group: the room's gates by what opens them; Hazard: a hazard while shut, never solid (Gate 5's lava)
class Spring { public Shape S; public bool Large; public int Ticks; }   // Ticks: how long it keeps the player going up (oLargeJumper: round(7*image_xscale); oSmallJumper: 3)
// a travel cannon (oTravelCannon): pressing up at it (S) gets in; firing it puts the player at X+21*Dir, Y-36 and sets
// their speed to 16 right and 16 up every tick for Ticks ticks (launchDuration), then lets them go
class Cannon { public Shape S; public int X, Y, Dir, Ticks; }

// ---------------------------------------------------------------- the player (characterStepEvent at 30fps)
class In { public bool L, R, J, D, DL, DR, A; }

// a melee attack that bounces the player off a latch crystal in the air (takeDamage's aerial bounce: the sword, the whip,
// the Blade Strike): its sprite, each frame its own mask at the player's x,y turned the player's way; how fast its frames
// go by (the player's attack animation, endAbilUse's speed: 4 frames in about 8 ticks, 8 in 11, 4 in 8); who swings it and
// what it takes; the slow fall the bounce gives (scrSlowFall: Jerry's 3 ticks, Claire's 5); how soon the attack can be
// pressed again
class Weapon
{
    public string Name, Spr; public int Frames, Ch, Need, SlowFall, Cycle; public double Speed;
    // (where its End Step puts it from the player, OffX the way they face; its y scale; its x scale the tick it's made,
    // before an End Step turns it the player's way: 0 the same as after. The Blade Strike's Create has 1.1 and 0.7)
    public int OffX, OffY; public double YScale = 1, MadeXScale;
    Shape[,] shapes;
    public static readonly Weapon[] All = {
        new Weapon { Name = "the sword", Spr = "sLinkSword", Frames = 4, Speed = 4.0 / 8 - 0.02, Ch = 0, Need = Req.LINK, SlowFall = 3, Cycle = 10 },
        new Weapon { Name = "the whip", Spr = "sBelmontWhip", Frames = 8, Speed = 8.0 / 11, Ch = 1, Need = Req.BELMONT, SlowFall = 5, Cycle = 12 },
        new Weapon { Name = "the Blade Strike", Spr = "sJCGameBladeStrike", Frames = 4, Speed = 5.5 / 11, Ch = 1, Need = Req.GAMEC, SlowFall = 5, Cycle = 10,
                     OffX = 32, OffY = -19, YScale = 0.7, MadeXScale = 1.1 } };
    // (frame f's pixels at 0,0: facing right (1), left (0), or as made (2); null where the frame has none)
    public Shape Frame(int f, int facing, bool made = false)
    {
        lock (this)
        {
            if (shapes == null)
            {
                shapes = new Shape[Frames, 3];
                for (int i = 0; i < Frames; i++)
                {
                    var m = Mask.GetFrame(Spr, i);
                    if (m == null) continue;
                    for (int d = 0; d < 3; d++)
                    {
                        double xs = d == 2 ? MadeXScale : d == 1 ? 1 : -1;
                        if (xs == 0) continue;
                        var s = new Shape(m, 0, 0, xs, YScale, 0);
                        if (!s.Empty) shapes[i, d] = s;
                    }
                }
            }
            if (made && MadeXScale != 0) return shapes[f, 2];
            return shapes[f, facing > 0 ? 1 : 0];
        }
    }
}

class Prog
{
    public string Name; public Req Label; public int Ch;   // 0 Jerry, 1 Claire
    public int Dir = 1; public bool RunStart;
    public int JumpAt = -1, JumpHold = 21;
    public int H1 = 1, H2 = 1, HDelay = 0;                  // horizontal input (in Dir's terms) before/after HDelay ticks
    public int DjAt = -1, DjHold = 21, AdAt = -1, GdAt = -1, AdDir = 0;
    public bool AdClear;                                     // the air dash at AdAt or later, once there's room ahead for it
    public int WallMode = -1;                                // wall jumps: 0 keep to one wall, 1 between two
    public bool DropDown; public int HiJump; public bool Morph; public bool NoInputTillAir;
    public bool Fade;                                        // waits on a fading platform till it fades, and falls through it
    public int Weapon = -1, AtkAt = -1, AtkEvery;            // a melee attack (Weapons) at this tick, and again every AtkEvery
    public bool AfterBounce;                                 // H1 till a spring bounces the player, then H2
    public int Cannon = -1;                                  // fired from this travel cannon (R.Cannons): H2 and the rest once it lets go (AfterBounce)
    public int FromCrystal = -1;                             // starts just bounced off a latch crystal (R.CrystalNode's key: CrystalStart)
    public int FromFlyer = -1;                               // starts just after stomping a flying enemy (R.FlyerNode's key: FlyerStart)
    public bool LowBounce;                                   // (FromFlyer) stomped with neither the jump nor up held: oEMarioBase's -6.5
    public bool Stomp;                                    // lands on Mario enemies on the ground (R.Stompers) and bounces off them: H2 after (AfterBounce)
    public bool FromHang;                                    // starts hanging from a Strike Chain point (jumping off it if JumpAt is 0)
    public bool HangDrop;                                    // (FromHang) letting go of the point: down and jump
    public bool Entering;                                    // coming into the room (where the last one's exit puts the player)
    public bool FromWall;                                    // starts beside a wall in the air (Dir: towards it), kicking off it if JumpAt is 0
    public double Dt = 1;                                    // the frame rate: the game's gDeltaTime (1 at 30fps, 0.5 at 60, 0.25 at 120)
    public int Dither;                                       // above 30fps: the player's ditherCounter as the move starts (Sim.dither)
    public int MorphAt = -1;                                 // turns into the Morph Ball at this tick (in the air too)
    // turns into the Morph Ball in the air once the body meets a wall it's moving into, or a ceiling it's about to hit
    // going up: the ball goes on where the body can't (into a tunnel in a wall, or up under the ceiling)
    public bool AutoMorph;
    // (starting as the Morph Ball) turns back in the air once the body has had room for a tick: its air speed, double
    // jump and air dash back (rolling out of a tunnel into the open)
    public bool AutoUnmorph;
    public int BounceAt = -1;                                // bounces off a flying enemy at this tick (the Mario Ability Set's stomp)
    public bool BombJump;                                    // (Morph Ball) a bomb under it throws it up at the start
    public int MaxT = 100;
    public Prog Copy() { return (Prog)MemberwiseClone(); }
}

class Sim
{
    public const int STANDING = 0, RUNNING = 1, DUCKING = 2, JUMPING = 5, FALLING = 6;
    public static double Slack = 0.95;
    public Room R; public Bits2D S; public bool Open;
    public int x, y, top = 40, t30;
    public double xVel, yVel, xAcc, yAcc, gi, jumpTime, jtt = 21, ija = -7.1, djAcc = -6.1, grav = 1.2, runAcc = 6.6;
    public int state = FALLING, facing = 1, ch;
    public bool jbr = true, wallGrab, morph;
    public int canAirDash = 1, djc = 1;
    public double adr, gdr, bdr, cbdr, dmt, wjt, sft, sfe, yVelLimit = 12, dashEnergy = 10000, bounce, bounceVel;
    public bool hasDJ, hasAD, hasGD, wallArea;
    public bool kL, kR, kJ, kD, kDL, kDR, kLP, kRP, kJP, kDP, kDLP, kDRP, kLRel, kRRel;
    public double kLSteps, kRSteps;
    public int lastXI, lastYI;
    public bool dead;
    // in a travel cannon's flight (characterStepEvent's ACT_IN_CANNON): no friction (xFric 1) and no gravity (gi 0), the
    // keys not read; the cannon sets the speed every tick (RunOne)
    public bool inCannon;
    // above 30fps (dt: the game's gDeltaTime, 0.5 at 60fps and 0.25 at 120): the game runs characterStepEvent every frame
    // with its 60fps code (StepHi, MoveHi: pMoveToWrapNew, MoveToHi: pMoveTo). The pixel rounding goes by the player's
    // ditherCounter (dither: oPlayer1's Step adds 1 before each frame; a jump or double jump sets it to 15). The jumps'
    // corrections (jumpBodge60, jumpGravComp60, doubleJumpBodge60: characterCreateEvent's, Gate 5's upgrades their own).
    // The rest are the 60fps code's own: a velocity set this frame (xVelSetTick: the 30fps formula, then held half a tick),
    // the rest of a dash's first tick (dashTickTime), a landing's (landTickHold), the air dash's kick and a double jump
    // during it (airDashKick, airDashDJKick), what the run code added (xAccInputWalk: pMoveToWrapNew's friction bodge)
    public double dt = 1;
    public int dither;
    public static bool OldExe;   // (a test: the game before the 2026-10-21 movement changes, without tRelNow and Gate 5's own corrections)
    public double lastRoundX, lastRoundY;   // (MoveToHi's last distances before rounding down, for the --move trace)
    public double jb60 = 1.07, jgc60 = 0.5, djb60 = 0.98;
    double landTickHold, dashTickTime, dashTickXAcc, xVelHold, yVelHold, airDashKick, airDashDJKick, xAccInputWalk;
    int airDashDJTick;
    bool xVelSetTick, yVelSetTick, xVelSetPrev, yVelSetPrev;
    public bool pendYSet;   // (a one-off push set before the first frame, as letting go of a Strike Chain point is: yVelSetTick then)
    // an elevator under the player (a solid box only it makes)
    public bool ex; public int ex0, ey0, ex1, ey1;

    public bool OnGround { get { return state == STANDING || state == RUNNING || state == DUCKING; } }
    public bool InAir { get { return state == JUMPING || state == FALLING; } }
    static bool AZ(double v) { return v > -0.1 && v < 0.1; }

    bool ExRow(int yy, int a, int b) { return ex && yy >= ey0 && yy <= ey1 && b >= ex0 && a <= ex1; }
    bool ExCol(int xx, int a, int b) { return ex && xx >= ex0 && xx <= ex1 && b >= ey0 && a <= ey1; }
    public bool ColBottom() { return S.Row(y - 1, x - 7, x + 6) || ExRow(y - 1, x - 7, x + 6); }
    public bool ColTop() { return S.Row(y - top - 1, x - 7, x + 6) || ExRow(y - top - 1, x - 7, x + 6); }
    public bool ColLeft(int n) { return S.Col(x - 7 - n, y - top, y - 2) || ExCol(x - 7 - n, y - top, y - 2); }
    public bool ColRight(int n) { return S.Col(x + 6 + n, y - top, y - 2) || ExCol(x + 6 + n, y - top, y - 2); }
    // (a fading platform faded away under the player (Prog.Fade): its box isn't a platform for this move)
    public int[] Faded;
    bool PlatRow(int yy, int a, int b)
    {
        if (Faded == null || yy < Faded[1] || yy > Faded[3]) return R.Plat.Row(yy, a, b);
        return (a < Faded[0] && R.Plat.Row(yy, a, Math.Min(b, Faded[0] - 1))) || (b > Faded[2] && R.Plat.Row(yy, Math.Max(a, Faded[2] + 1), b));
    }
    public bool PlatBottom() { return PlatRow(y - 1, x - 7, x + 6); }
    public bool PlatBody()
    {
        if (Faded == null) return R.Plat.Box(x - 7, y - top, x + 6, y - 2);
        for (int yy = y - top; yy <= y - 2; yy++) if (PlatRow(yy, x - 7, x + 6)) return true;
        return false;
    }
    // on a jump-through platform (and not in one), or on a moving platform's path (those never get in the way of landing)
    public bool PlatLand() { return (R.Plat.Any && PlatBottom() && !PlatBody()) || R.GhostB.Row(y - 1, x - 7, x + 6); }

    int VelInt(double v)
    {
        double av = Math.Abs(v), f = av - Math.Floor(av);
        int vi = 0;
        if (f != 0) { int r = (int)Math.Round(1.0 / f); if (r != 0) vi = (t30 % r == 0) ? 1 : 0; }
        vi += (int)Math.Floor(av);
        return v < 0 ? -vi : vi;
    }

    void MoveTo(double dx, double dy)
    {
        int xi = VelInt(dx), yi = VelInt(dy); lastXI = xi; lastYI = yi;
        int x0 = x, y0 = y;
        if (xi > 0) { while (x < x0 + xi) { if (ColRight(1)) break; x++; } }
        else if (xi < 0) { while (x > x0 + xi) { if (ColLeft(1)) break; x--; } }
        if (yi > 0) { while (y < y0 + yi) { if (ColBottom()) break; if (!kD && PlatLand()) break; y++; } }
        else if (yi < 0) { while (y > y0 + yi) { if (ColTop()) break; y--; } }
    }

    void Move(double xFric, double yFric)
    {
        xAcc = Math.Max(-10, Math.Min(10, xAcc)); yAcc = Math.Max(-10, Math.Min(10, yAcc));
        xVel += xAcc; yVel += yAcc; xAcc = 0; yAcc = 0;
        xVel *= xFric; yVel *= yFric;
        if (xVel > 16) xVel = 16; else if (xVel < -16) xVel = -16;
        if (yVel > yVelLimit) yVel = yVelLimit; else if (yVel < -16) yVel = -16;
        if (AZ(xVel)) xVel = 0;
        if (AZ(yVel)) yVel = 0;
        bool og = OnGround;
        int slopeYPrev = y, slopeChange = 0;
        if (og && xVel != 0)
        {
            for (; y >= slopeYPrev - 4; y--) if (ColTop()) break;
            slopeChange = slopeYPrev - y;
        }
        if (og && xVel != 0)
        {
            int xPrev = x, yPrev = slopeYPrev, yPrevHigh = y;
            MoveTo(xVel, yVel + slopeChange);
            double dist = Math.Sqrt((double)(x - xPrev) * (x - xPrev) + (double)(y - yPrev) * (y - yPrev));
            if (dist > Math.Abs(lastXI))
            {
                int xi1 = lastXI, yi1 = lastYI;
                x = xPrev; y = yPrevHigh;
                MoveTo(Math.Round(xi1 * 1.075), Math.Round(yi1 * 1.075 + slopeChange));
            }
        }
        else MoveTo(xVel, yVel);
        int maxDown = (gdr > 0 || bdr > 0) ? 14 : 8;
        if (!ColBottom() && lastXI != 0 && OnGround)
        {
            int up = y;
            for (int yy = y; yy <= up + maxDown; yy++) { y = yy; if (ColBottom()) { up = yy; break; } }
            y = up;
        }
    }

    // (above 30fps the jumps go straight into the velocity with their corrections, and set the pixel rounding: pMoveJump,
    // pMoveDoubleJump; the air dash's kick comes during its first tick, pMoveAirDash; a dash's first tick goes on as it
    // started, pMoveDashForward)
    public void Jump()
    {
        if (dt == 1) yAcc += ija;
        else { yVel += ija * jb60 + grav * jgc60; dither = 15; }
        state = FALLING; jbr = false; jumpTime = 0;
    }
    void DoubleJump()
    {
        yVel = 0;
        if (dt == 1) yAcc += djAcc;
        else
        {
            yVel += djAcc * djb60 + gi * 0.5;
            if (adr > 0) { airDashDJKick = djAcc; airDashDJTick = (int)Math.Ceiling(adr); }
            dither = 15;
        }
        jumpTime = 3; jbr = false; djc = 0; bounce = 0;
    }
    void AirDash()
    {
        canAirDash = 0; dmt = ch == 0 ? 22 : 15; dashEnergy -= 2000;
        if (dt == 1) yAcc += ija / 2;
        else { airDashKick = ija / 2; airDashDJKick = 0; }
        if (adr < 7) adr = 6;
        bounce = 0;
        if (dt < 1) { dashTickTime = 1; dashTickXAcc = xAcc; }
    }
    void DashForward()
    {
        if (ch == 0) { dmt = 13; gdr = 8; bdr = 0; }
        else
        {
            dmt = 25;
            if (dt == 1) yAcc += ija / 2;
            else yVel = ija / 2 - grav * (0.5 - dt) * 0.5;
            state = FALLING;
        }
        dashEnergy -= 2000;
        xAcc += xVel; xVel = facing * 14;
        jbr = false; jumpTime = 0;
        if (dt < 1) { xVelSetTick = true; dashTickTime = 1; dashTickXAcc = xAcc; }
    }
    // stomping a Mario enemy in the air with the jump or up held (oEMarioBase's collision): up at -13.5 (-6.5 with neither
    // held), the gravity nearly back, a moment's slow fall, and the double jump and air dash back
    public void Stomp(bool high = true)
    {
        //yVel = -13.5 * Slack; if (jumpTime < jtt - 5) jumpTime = jtt - 5;
        yVel = (high ? -13.5 : -6.5) * Slack; if (jumpTime < jtt - 5) jumpTime = jtt - 5;
        // (above 30fps the game adds half the gravity to it, as to the player's own jumps: its 60fps change)
        if (dt < 1) yVel += gi * 0.5;
        if (sft < 5) { sft = 5; sfe = 0.4; }
        canAirDash = 1; djc = 1; state = JUMPING;
    }
    void WallJump(int right)
    {
        jumpTime = 0; jbr = false; kR = false; kRRel = true; kL = false; kLRel = true;
        xAcc = xVel / 4; yAcc += ija; yVel = -0.05; wjt = 3;
        sft = 5; sfe = 0.5; canAirDash = 1; djc = 1;
        xVel = right == 0 ? -6 : 6;
        if (dt < 1) { xVelSetTick = true; yVelSetTick = true; }   // (pMoveWallJump: the 30fps kick at every frame rate)
    }

    // Begonia's fans (oBegoniaFan's Step): the body in one's stream, nothing solid between the fan and the body's middle,
    // the player's speed its way is set to 8 (going up off the ground, a pixel up first)
    void Blow()
    {
        int hb = morph ? 14 : 46;
        foreach (var fn in R.Fans)
        {
            if (x + 6 < fn[0] || x - 7 > fn[2] || y - 1 < fn[1] || y - hb > fn[3]) continue;
            int lx = fn[5], ly = fn[6], tx = x, ty = y - 26, n = Math.Max(Math.Abs(tx - lx), Math.Abs(ty - ly));
            bool seen = true;
            for (int i = 0; i <= n && seen; i++) if (S.Get(lx + (n == 0 ? 0 : (tx - lx) * i / n), ly + (n == 0 ? 0 : (ty - ly) * i / n))) seen = false;
            if (!seen) continue;
            if (fn[4] == 0) xVel = 8;
            else if (fn[4] == 180) xVel = -8;
            else if (fn[4] == 90) { if (state == RUNNING) y -= 1; yVel = -8; }
            else yVel = 8;
            // (above 30fps a velocity set from outside: xVelSetExt, the 30fps formula, as xVelSetTick)
            if (dt < 1) { if (fn[4] == 0 || fn[4] == 180) xVelSetTick = true; else yVelSetTick = true; }
        }
    }

    public void Step(In inp)
    {
        // keys
        if (wjt == 0)
        {
            kLRel = false;
            if (kL) { kL = inp.L; kLSteps++; kLP = false; if (!kL) kLRel = true; } else { kL = inp.L; if (kL) kLP = true; kLSteps = 0; }
            kRRel = false;
            if (kR) { kR = inp.R; kRSteps++; kRP = false; if (!kR) kRRel = true; } else { kR = inp.R; if (kR) kRP = true; kRSteps = 0; }
        }
        if (kD) { kD = inp.D; kDP = false; } else { kD = inp.D; kDP = kD; }
        if (kJ) { kJ = inp.J; kJP = false; } else { kJ = inp.J; kJP = kJ; }
        if (kDL) { kDL = inp.DL; kDLP = false; } else { kDL = inp.DL; kDLP = kDL; }
        if (kDR) { kDR = inp.DR; kDRP = false; } else { kDR = inp.DR; kDRP = kDR; }
        // springs keep the player going up while they bounce
        if (bounce > 0) { yVel = bounceVel; bounce--; }
        // the Morph Ball's own acceleration, on the ground and in the air (playerTechStart sets it at the end of each tick)
        if (morph) runAcc = OnGround ? 7.6 : 5.3;
        // running
        if (state != DUCKING)
        {
            if (kLRel && AZ(xVel)) xAcc -= 0.5;
            if (kRRel && AZ(xVel)) xAcc += 0.5;
            if (kL)
            {
                if (kLSteps < 3) { bdr = 0; if (ch == 1 && cbdr > 0) { dmt = 0; cbdr = 0; } }
                if (facing == 1) { gdr = 0; adr = 0; if (dmt < 25) dmt = 0; }
                if (kLSteps > 1 && (facing == -1 || AZ(xVel)))
                {
                    xAcc -= runAcc;
                    if (ch == 0) { if (InAir && dmt > 0) { xAcc -= (xVel / 2.1 + dmt / 2); xVel = -(14 / 2.1 + dmt / 2); } }
                    else if (dmt >= 1)
                    {
                        if (InAir) { xAcc -= (xVel / 2.1 + dmt / 1.95); xVel = -(14 / 2.1 + dmt / 1.95); }
                        if (kLSteps <= 1) dmt = 0;
                    }
                }
                if (adr == 0) facing = -1;
            }
            if (kR)
            {
                if (kRSteps < 3) { bdr = 0; if (ch == 1 && cbdr > 0) { dmt = 0; cbdr = 0; } }
                if (facing == -1) { gdr = 0; adr = 0; if (dmt < 25) dmt = 0; }
                if (kRSteps > 1 && (facing == 1 || AZ(xVel)))
                {
                    xAcc += runAcc;
                    if (ch == 0) { if (InAir && dmt > 0) { xAcc += xVel / 2.1 + dmt / 2; xVel = 14 / 2.1 + dmt / 2; } }
                    else if (dmt >= 1)
                    {
                        if (InAir) { xAcc += xVel / 2.1 + dmt / 1.95; xVel = 14 / 2.1 + dmt / 1.95; }
                        if (kRSteps <= 1) dmt = 0;
                    }
                }
                if (adr == 0) facing = 1;
            }
        }
        if (InAir) yAcc += gi;
        if ((ColBottom() || PlatLand()) && InAir && yVel >= 0)
        {
            yVel = 0; yAcc = 0; state = RUNNING; canAirDash = 1; djc = 1;
        }
        if (OnGround && yVel > 0.25) yVel = 0;
        if (!ColBottom() && !PlatLand() && OnGround) { state = FALLING; yAcc += grav; }
        if (ColTop() && state == JUMPING) yVel = Math.Abs(yVel * 0.3);
        if (wallArea && !morph)
        {
            if (ColRight(3) && InAir && facing == 1)
            {
                canAirDash = 1; djc = 1;
                if (kJP) WallJump(0);
            }
            else if (ColLeft(3) && InAir && facing == -1)
            {
                canAirDash = 1; djc = 1;
                if (kJP) WallJump(1);
            }
            if (wjt > 0) wjt--;
        }
        if (OnGround)
        {
            if (((kDRP && facing == 1) || (kDLP && facing == -1)) && dashEnergy >= 2000 && hasGD && gdr == 0 && !morph) DashForward();
            else if (kJP && !morph) Jump();
        }
        else if (InAir && !wallGrab && !morph)
        {
            if ((kDLP || kDRP) && dashEnergy >= 2000 && adr == 0 && canAirDash == 1 && hasAD) AirDash();
            else if (kJP && hasDJ && djc == 1) DoubleJump();
        }
        if (gdr > 0) { gdr--; xVel = facing * 15; }
        if (bdr > 0) { bdr--; xVel = -facing * 15; }
        if (cbdr > 0) cbdr--;
        if (adr > 0) { adr--; yVel = (ch == 0 ? -2.9 : -3.3) * Slack; xVel = facing * 13; }
        if (dmt > 0) dmt--;
        if (jumpTime < jtt) jumpTime++;
        if (!kJ && !kDL && !kDR) jbr = true;
        if (jbr) jumpTime = jtt;
        gi = jumpTime / jtt * grav;
        if (kD && OnGround)
        {
            if ((R.Plat.Any && PlatBottom()) || R.GhostB.Row(y - 1, x - 7, x + 6)) { if (!ColBottom()) { y += 1; state = FALLING; yAcc += grav; } else state = RUNNING; }
            else state = DUCKING;
        }
        if (!kD && state == DUCKING) { state = STANDING; xAcc = 0; }
        if (xVel == 0 && xAcc == 0 && state == RUNNING) state = STANDING;
        if (xAcc != 0 && state == STANDING) state = RUNNING;
        if (yVel < 0 && InAir) state = JUMPING;
        if (yVel > 0 && InAir) state = FALLING;
        if (sft > 0) { if (sfe < jumpTime / jtt * grav) gi = sfe; if (sfe < 1) sfe += 0.008; sft--; }
        double xFric, yFric = 1;
        if (state == DUCKING) xFric = (xVel < 2 && xVel > -2) ? 0.2 : (ch == 0 ? 0.87 : 0.9);
        else if (InAir && !kL && !kR) xFric = dmt > 0 ? (ch == 0 ? 0.965 : 0.96) : 0.82;
        else if (ch == 0) xFric = dmt > 19 ? 0.965 : ((gdr > 0 || bdr > 0) ? 0.9 : 0.5);
        else xFric = dmt > 20 ? 0.96 : 0.5;
        if (R.Data.Area != 49 && R.Water.Any && R.Water.Row(y - 14, x - 7, x + 6))
        {
            if (yVel > 8) yVel = 8;
            xFric = state == DUCKING ? 0.62 : 0.41;
            yFric = (state == FALLING && yVel > 0) ? 0.78 : 0.93;
        }
        if (wallArea && !morph)
        {
            if ((ColLeft(3) && facing == -1) || (ColRight(3) && facing == 1 && InAir)) { wallGrab = true; yVelLimit = 4; }
            else { wallGrab = false; yVelLimit = 12; }
        }
        if (R.Fans.Count > 0) Blow();
        if (inCannon) { xFric = 1; yFric = 1; }
        Move(xFric, yFric);
        if (y > R.Data.H + 64) dead = true;
        else if (y < -32) yVel = 4;
        if (x < 0) { xVel = 0; x = 0; } else if (x > R.Data.W) { xVel = 0; x = R.Data.W; }
        t30++;
    }

    // ------------------------------------------------ above 30fps
    // a frame of characterStepEvent at gDeltaTime dt (0.5: 60fps, 0.25: 120fps): the 30fps Step's order and moves, with the
    // game's 60fps changes (its comments say why each is there): the buttons' pushed steps in fractions of a tick, the run
    // skipped for the rest of a dash's first tick, a landing with dash momentum keeping the air's ways for the rest of its
    // tick, velocities set this frame marked (xVelSetTick), the air dash's kick over its first tick, the timers counting
    // down by dt, the jump let go noticed a frame late at 120fps; then pMoveToWrapNew (MoveHi)
    static double Frac(double v) { return v - Math.Floor(v); }
    // floor() as the game gets it: a value a rounding error under a whole number is that number
    static int FloorX(double v) { return (int)Math.Floor(v + 1e-9); }

    // pCheckLandBelow: solid ground, or a jump-through platform (not while holding down)
    bool LandBelow() { return ColBottom() || (!kD && PlatLand()); }

    public void StepHi(In inp)
    {
        dither++;
        xVelSetTick = false; yVelSetTick = false;
        if (pendYSet) { yVelSetTick = true; pendYSet = false; }
        // keys
        if (wjt == 0)
        {
            kLRel = false;
            if (kL) { kL = inp.L; kLSteps += dt; kLP = false; if (!kL) kLRel = true; } else { kL = inp.L; if (kL) kLP = true; kLSteps = 0; }
            kRRel = false;
            if (kR) { kR = inp.R; kRSteps += dt; kRP = false; if (!kR) kRRel = true; } else { kR = inp.R; if (kR) kRP = true; kRSteps = 0; }
        }
        if (kD) { kD = inp.D; kDP = false; } else { kD = inp.D; kDP = kD; }
        if (kJ) { kJ = inp.J; kJP = false; } else { kJ = inp.J; kJP = kJ; }
        if (kDL) { kDL = inp.DL; kDLP = false; } else { kDL = inp.DL; kDLP = kDL; }
        if (kDR) { kDR = inp.DR; kDRP = false; } else { kDR = inp.DR; kDRP = kDR; }
        // springs keep the player going up while they bounce
        if (bounce > 0) { yVel = bounceVel; bounce -= dt; yVelSetTick = true; }
        if (morph) runAcc = OnGround ? 7.6 : 5.3;
        // running (not for the rest of a dash's first tick)
        if (state != DUCKING && dashTickTime <= 0)
        {
            bool air = InAir || landTickHold > 0;
            if (kLRel && AZ(xVel)) { xAcc -= 0.5; xVelSetTick = true; }
            if (kRRel && AZ(xVel)) { xAcc += 0.5; xVelSetTick = true; }
            if (kL)
            {
                if (kLSteps < 3) { bdr = 0; if (ch == 1 && cbdr > 0) { dmt = 0; cbdr = 0; } }
                if (facing == 1) { gdr = 0; adr = 0; if (dmt < 25) dmt = 0; }
                if (kLSteps >= 1.5 && (facing == -1 || AZ(xVel)))
                {
                    xAcc -= runAcc;
                    double cm = Math.Ceiling(dmt);
                    if (ch == 0) { if (air && dmt > 0) { xAcc -= (xVel / 2.1 + cm / 2); xVel = -(14 / 2.1 + cm / 2); xVelSetTick = true; } }
                    else if (dmt > 0)
                    {
                        if (air) { xAcc -= (xVel / 2.1 + cm / 1.95); xVel = -(14 / 2.1 + cm / 1.95); xVelSetTick = true; }
                        if (kLSteps < 1.5) dmt = 0;
                    }
                }
                if (adr == 0) facing = -1;
            }
            if (kR)
            {
                if (kRSteps < 3) { bdr = 0; if (ch == 1 && cbdr > 0) { dmt = 0; cbdr = 0; } }
                if (facing == -1) { gdr = 0; adr = 0; if (dmt < 25) dmt = 0; }
                if (kRSteps >= 1.5 && (facing == 1 || AZ(xVel)))
                {
                    xAcc += runAcc;
                    double cm = Math.Ceiling(dmt);
                    if (ch == 0) { if (air && dmt > 0) { xAcc += xVel / 2.1 + cm / 2; xVel = 14 / 2.1 + cm / 2; xVelSetTick = true; } }
                    else if (dmt > 0)
                    {
                        if (air) { xAcc += xVel / 2.1 + cm / 1.95; xVel = 14 / 2.1 + cm / 1.95; xVelSetTick = true; }
                        if (kRSteps < 1.5) dmt = 0;
                    }
                }
                if (adr == 0) facing = 1;
            }
        }
        xAccInputWalk = xAcc;
        if (InAir) yAcc += gi;
        if ((ColBottom() || PlatLand()) && InAir && yVel >= 0)
        {
            yVel = 0; yAcc = 0; state = RUNNING; canAirDash = 1; djc = 1;
            if (dmt > 0) landTickHold = Frac(dmt);
        }
        if (OnGround && yVel > 0.25) yVel = 0;
        if (!ColBottom() && !PlatLand() && OnGround) { state = FALLING; yAcc += grav; yVelSetTick = true; }
        if (ColTop() && state == JUMPING) yVel = Math.Abs(yVel * 0.3);
        if (wallArea && !morph)
        {
            if (ColRight(3) && InAir && facing == 1)
            {
                canAirDash = 1; djc = 1;
                if (kJP) WallJump(0);
            }
            else if (ColLeft(3) && InAir && facing == -1)
            {
                canAirDash = 1; djc = 1;
                if (kJP) WallJump(1);
            }
            if (wjt > 0) wjt -= dt;
        }
        if (OnGround)
        {
            if (((kDRP && facing == 1) || (kDLP && facing == -1)) && dashEnergy >= 2000 && hasGD && gdr == 0 && !morph) DashForward();
            else if (kJP && !morph) Jump();
        }
        else if (InAir && !wallGrab && !morph)
        {
            if ((kDLP || kDRP) && dashEnergy >= 2000 && adr == 0 && canAirDash == 1 && hasAD) AirDash();
            else if (kJP && hasDJ && djc == 1) DoubleJump();
        }
        maxDownHi = (gdr > 0 || bdr > 0) ? 14 : 8;
        if (gdr > 0) { if (dashTickTime > 0) xAcc = dashTickXAcc; gdr -= dt; xVel = facing * 15; xVelSetTick = true; }
        if (bdr > 0) { if (dashTickTime > 0) xAcc = dashTickXAcc; bdr -= dt; xVel = -facing * 15; xVelSetTick = true; }
        if (cbdr > 0) cbdr -= dt;
        if (adr > 0)
        {
            bool first = adr > 5;
            int tick = (int)Math.Ceiling(adr);
            adr -= dt;
            yVel = (ch == 0 ? -2.9 : -3.3) * Slack; yVelSetTick = true;
            if (first) yVel += airDashKick;
            if (airDashDJKick != 0) { if (tick == airDashDJTick) yVel += airDashDJKick; else airDashDJKick = 0; }
            if (dashTickTime > 0) xAcc = dashTickXAcc;
            xVel = facing * 13; xVelSetTick = true;
        }
        if (dmt > 0) dmt -= dt;
        if (dashTickTime > 0) dashTickTime -= dt;
        if (jumpTime < jtt) jumpTime += dt;
        bool relNow = false;
        if (!kJ && !kDL && !kDR) { if (!jbr) relNow = true; jbr = true; }
        if (jbr && !(relNow && dt < 0.5 && !OldExe)) jumpTime = jtt;
        gi = jumpTime / jtt * grav;
        if (kD && OnGround)
        {
            if ((R.Plat.Any && PlatBottom()) || R.GhostB.Row(y - 1, x - 7, x + 6)) { if (!ColBottom()) { y += 1; state = FALLING; yAcc += grav; yVelSetTick = true; } else state = RUNNING; }
            else { if (state != DUCKING) xVelSetTick = true; state = DUCKING; }
        }
        if (!kD && state == DUCKING) { state = STANDING; xAcc = 0; }
        if (xVel == 0 && xAcc == 0 && state == RUNNING) state = STANDING;
        if (xAcc != 0 && state == STANDING) state = RUNNING;
        if (yVel < 0 && InAir) state = JUMPING;
        if (yVel > 0 && InAir) state = FALLING;
        if (sft > 0) { if (sfe < jumpTime / jtt * grav) gi = sfe; if (sfe < 1) sfe += 0.008 * dt; sft -= dt; }
        double xFric, yFric = 1;
        bool airF = InAir || landTickHold > 0;
        if (state == DUCKING) xFric = (xVel < 2 && xVel > -2) ? 0.2 : (ch == 0 ? 0.87 : 0.9);
        else if (airF && !kL && !kR) xFric = dmt >= 1 ? (ch == 0 ? 0.965 : 0.96) : 0.82;
        else if (ch == 0) xFric = dmt >= 20 ? 0.965 : ((gdr >= 1 || bdr >= 1) ? 0.9 : 0.5);
        else xFric = dmt >= 21 ? 0.96 : 0.5;
        if (R.Data.Area != 49 && R.Water.Any && R.Water.Row(y - 14, x - 7, x + 6))
        {
            if (yVel > 8) yVel = 8;
            xFric = state == DUCKING ? 0.62 : 0.41;
            yFric = (state == FALLING && yVel > 0) ? 0.78 : 0.93;
        }
        if (wallArea && !morph)
        {
            if ((ColLeft(3) && facing == -1) || (ColRight(3) && facing == 1 && InAir)) { wallGrab = true; yVelLimit = 4; }
            else { wallGrab = false; yVelLimit = 12; }
        }
        if (R.Fans.Count > 0) Blow();
        if (inCannon) { xFric = 1; yFric = 1; }
        MoveHi(xFric, yFric);
        if (landTickHold > 0) landTickHold -= dt;
        if (y > R.Data.H + 64) dead = true;
        else if (y < -32) yVel = 4;
        if (x < 0) { xVel = 0; x = 0; } else if (x > R.Data.W) { xVel = 0; x = R.Data.W; }
    }

    // pMoveToWrapNew: the tick's acceleration and friction spread over the frame (half before the move, half after), a
    // velocity set this frame moved by the 30fps formula and held for half a tick, the slow-down on slopes, the move (with
    // pMoveTo's rounding: MoveToHi), then moving down a slope (not while going up)
    void MoveHi(double xFric, double yFric)
    {
        xAcc = Math.Max(-10, Math.Min(10, xAcc)); yAcc = Math.Max(-10, Math.Min(10, yAcc));
        double xAccIn = xAcc, yAccIn = yAcc;
        double xFa = xFric, yFa = yFric, xAa = 0, yAa = 0;
        if (xFric > 0 && xFric < 1) { xFa = Math.Exp(Math.Log(xFric + 0.000001) * dt); xAa = xAcc * xFric * (xFa - 1.0) / (xFric - 1.0 - 0.000001); }
        else if (xFric == 1) xAa = xAcc * dt;
        if (yFric > 0 && yFric < 1) { yFa = Math.Exp(Math.Log(yFric + 0.000001) * dt); yAa = yAcc * yFric * (yFa - 1.0) / (yFric - 1.0 - 0.000001); }
        else if (yFric == 1) yAa = yAcc * dt;
        xAa -= xVel * (1.0 - xFa);
        yAa -= yVel * (1.0 - yFa);
        if (xVelSetTick) { xVel = (xVel + xAcc) * xFric; xAa = 0; xVelHold = xVelSetPrev ? 0 : 0.5 - dt; xVelSetPrev = true; }
        else { xVelSetPrev = false; if (xVelHold > 0.0001) { xAa = 0; xVelHold -= dt; } }
        if (yVelSetTick) { yVel = (yVel + yAcc) * yFric; yAa = 0; yVelHold = yVelSetPrev ? 0 : 0.5 - dt; yVelSetPrev = true; }
        else { yVelSetPrev = false; if (yVelHold > 0.0001) { yAa = 0; yVelHold -= dt; } }
        xAa *= 0.5; yAa *= 0.5;
        xVel += xAa; yVel += yAa;
        // (the friction bodge for small adjustments: not while running)
        if (xAccInputWalk == 0 && xFric > 0.2 && xFric < 0.8 && Math.Abs(xVel) < 3.0)
        {
            int sg = Math.Sign(xVel);
            xVel -= sg * 2.0 * dt * (1.0 - xFric);
            if (Math.Sign(xVel) != sg) xVel = 0;
        }
        xAcc = 0; yAcc = 0;
        if (xVel > 16) xVel = 16; else if (xVel < -16) xVel = -16;
        if (yVel > yVelLimit) yVel = yVelLimit; else if (yVel < -16) yVel = -16;
        if (AZ(xVel) && xAccIn == 0) xVel = 0;
        if (AZ(yVel) && yAccIn == 0) yVel = 0;
        int ems = FloorX(4 * dt + Frac(dither * 0.618));
        // (the slope under the player, 2px to either side: going up it slows them)
        double speedmod = 1;
        if (OnGround && Math.Abs(xVel) > 0)
        {
            int x0 = x, y0 = y;
            int dl = SlopeAt(x0 - 2, y0), dc = SlopeAt(x0, y0), dr = SlopeAt(x0 + 2, y0);
            double ds = 0;
            if (dl != 0 && dl != 6 && dr != 0 && dr != 6) ds = (dr - dl) / 4.0;
            else if (dc != 0 && dc != 6 && dr != 0 && dr != 6) ds = (dr - dc) / 2.0;
            else if (dl != 0 && dl != 6 && dc != 0 && dc != 6) ds = (dc - dl) / 2.0;
            if (Math.Sign(ds) != Math.Sign(xVel)) speedmod = 1.0 / (1.0 + Math.Max(0.0, Math.Abs(ds) * 0.8 - 0.4));
            x = x0; y = y0;
        }
        bool og = OnGround;
        int slopeYPrev = y, slopeChange = 0;
        if (ems > 0 && og && xVel != 0)
        {
            for (; y >= slopeYPrev - ems; y--) if (ColTop()) break;
            slopeChange = slopeYPrev - y;
        }
        if (ems * Math.Abs(xVel) > 0 && og)
        {
            int xPrev = x, yPrev = slopeYPrev, yPrevHigh = y;
            MoveToHi(xVel * dt * speedmod, yVel * dt * speedmod + slopeChange);
            double dist = Math.Sqrt((double)(x - xPrev) * (x - xPrev) + (double)(y - yPrev) * (y - yPrev));
            if (dist > Math.Abs(lastXI))
            {
                x = xPrev; y = yPrevHigh;
                MoveToHi(xVel * dt * 1.075 * speedmod, yVel * dt * 1.075 * speedmod + slopeChange);
            }
        }
        else MoveToHi(xVel * dt, yVel * dt);
        xVel += xAa; yVel += yAa;
        if (xVel > 16) xVel = 16; else if (xVel < -16) xVel = -16;
        if (yVel > yVelLimit) yVel = yVelLimit; else if (yVel < -16) yVel = -16;
        if (AZ(xVel) && xAccIn == 0) xVel = 0;
        if (AZ(yVel) && yAccIn == 0) yVel = 0;
        // moving down a slope (characterStepEvent, after the move; maxDownSlope as it was set before the dashes counted down)
        if (!ColBottom() && lastXI != 0 && OnGround && yVel >= 0)
        {
            int up = y;
            for (int yy = y; yy <= up + maxDownHi; yy++) { y = yy; if (ColBottom()) { up = yy; break; } }
            y = up;
        }
    }
    int maxDownHi = 8;

    // (pMoveToWrapNew's slope check: how far down from 3px above the feet ground is found, 0-6, 7 for none)
    int SlopeAt(int xx, int yy)
    {
        int keepX = x;
        x = xx;
        int found = 7;
        for (int k = 0; k <= 6; k++) { y = yy - 3 + k; if (LandBelow()) { found = k; break; } }
        x = keepX;
        return found;
    }

    // fptoif: the fraction rounded to 1/n
    static double FpToIf(double v)
    {
        double s = Math.Sign(v), m = Math.Abs(v), f = m - Math.Floor(m), i = m - f;
        if (f == 0) return v;
        f = 1.0 / Math.Round(1.0 / f);
        return s * (i + f);
    }

    // pMoveTo above 30fps: the distance rounded by the dither (frac(ditherCounter*0.618)), then moved a pixel at a time
    void MoveToHi(double dx, double dy)
    {
        double ax = FpToIf(dx / dt) * dt, ay = FpToIf(dy / dt) * dt;
        double fd = Frac(dither * 0.618);
        // (a sum that's a whole number comes out just under it here, 2.9999999999999991, where the game gets the whole
        // number: GameMaker's arithmetic is more precise. FloorX rounds down with that allowance)
        int xi = Math.Sign(ax) * FloorX(Math.Abs(ax) + fd), yi = Math.Sign(ay) * FloorX(Math.Abs(ay) + fd);
        lastRoundX = Math.Abs(ax) + fd; lastRoundY = Math.Abs(ay) + fd;
        lastXI = xi; lastYI = yi;
        int x0 = x, y0 = y;
        if (xi > 0) { while (x < x0 + xi) { if (ColRight(1)) break; x++; } }
        else if (xi < 0) { while (x > x0 + xi) { if (ColLeft(1)) break; x--; } }
        if (yi > 0) { while (y < y0 + yi) { if (ColBottom()) break; if (!kD && PlatLand()) break; y++; } }
        else if (yi < 0) { while (y > y0 + yi) { if (ColTop()) break; y--; } }
    }
}

// ---------------------------------------------------------------- one room
// a join between two of a room's nodes (places the player stands, ways in, Strike Chain points...), what it needs and,
// in words, how it's done (the room files' "how": RoomLogic writes them, solve.py doesn't need them)
// (Pill: the falling pillars the move goes through, fallen; PTouch: the ones it touches, standing)
// (the falling pillars of a move: PillarStates. Pill, the ones it goes through (with the gates open); PTouch, the ones
// it touches with them standing (on, beside or under one); PStart, the ones it starts on; PStood, the ones it stands on
// on the way (from the start to the landing); PLand, the ones it lands on. SX,SY: where it starts, LX,LY: where it lands
// or clings (int.MinValue: not known))
class Edge { public int From, To; public Req L; public string How; public int Pill, PTouch, PStart, PStood, PLand; public bool Sim; public int SX = int.MinValue, SY, LX = int.MinValue, LY; }
// a push rock: where it rests to begin with (its box's top left, width and height less one), where it came from in the
// room, and every place it can be pushed to (its box's top left)
class Rock { public int X, Y, W, H; public string From; public List<int[]> Places; }
class Touch { public int From; public int Kind; public int Index; public Req L; public string How; public int Pill, PTouch, PStart; public bool Sim; public int SX = int.MinValue, SY; }   // Kind 0 location, 1 exit
// a falling pillar: its top, its column, its gate group
class Pillar { public Shape Top, Col; public int Group; }
// (a move's outcome with some falling pillars fallen, PillarStates: Kind 0 lands in region To, 1 clings to its wall, 2
// touches location/exit/spot (TKind 0/1/2) Index; its pillars as an Edge's)
class PillarOut { public int Kind, To, TKind, Index, SX, SY, LX = int.MinValue, LY, PStart, PStood, PLand, PTouch; public Req L; public string How; }

class Room
{
    public RoomData Data;
    public Bits2D SolidC, SolidO, Plat, Haz, Water, GhostB;
    // hazards something makes harmless (Gate 5's lava, with the Varia Suit): each also a gate (R.Gates) needing it, so a
    // move with the gates open goes through it, one with them shut never touches it
    public Bits2D HazV;
    public List<Gate> Gates = new List<Gate>();
    public Dictionary<string, int> GateGroupOf = new Dictionary<string, int>();
    public List<List<Req>> GroupNeed = new List<List<Req>>();
    public List<Spring> Springs = new List<Spring>();
    public List<Cannon> Cannons = new List<Cannon>();
    public List<Exit> Exits = new List<Exit>();          // this room's exits (global index in Exit.Room... see Global)
    public List<int> ExitIds = new List<int>();
    public List<Loc> Locs = new List<Loc>();
    public List<int> LocIds = new List<int>();
    public List<Spot> Spots = new List<Spot>();
    public List<int[]> Elevators = new List<int[]>();     // oUseElevator: its x, y (the top row of its lower bar); and
                                                          // a wider one's half width, cabin height and floors' y
    // moving platforms: the top of each along its path, as jump-through floor (the player waits for it and rides it); which
    // platform each such pixel is
    public Dictionary<long, int> Ghost = new Dictionary<long, int>();
    public int Movers;
    public List<Rock> Rocks = new List<Rock>();
    // Strike Chain points (Mega Man's grapple: the player hangs under one, then jumps or drops), and each one's node
    public List<int[]> Points = new List<int[]>();
    public int[] HangNode = new int[0];
    public int[] CrystalNode = new int[0];   // (just bounced off a latch crystal: by Result.Bounces' keys)
    // flying enemies the Mario Ability Set stomps, each as it is where it starts (its own sprite there: F lines; a Bill
    // Blaster's Bullet Bills where they're fired), and each one's nodes (just stomped it, by character: Result.Stomps'
    // keys, flyer*2 + the character)
    public List<Shape> Flyers = new List<Shape>();
    public List<string> FlyerNames = new List<string>();
    public int[] FlyerNode = new int[0];
    public List<int[]> GroundFoes = new List<int[]>();   // (the Mario enemies on the ground, as placed: FG lines)
    public List<int[]> Stompers = new List<int[]>();     // (where each is landed on: x0, x1 and the feet's y: MakeStompers)
    // fading platforms (oPlatTempFade: there a while, gone a while): what falls through one when it fades
    public List<Shape> Fades = new List<Shape>();
    // latch crystals: a melee hit on one in the air bounces the player up (Weapon)
    public List<Shape> Crystals = new List<Shape>();
    // falling pillars (Castlevania's): each a gate group of its own that needs nothing, its top and column solid while it
    // stands; the groups' bits (Edge.Pill, PTouch: PillarStates)
    public List<Pillar> Pillars = new List<Pillar>();
    public int PillarMask;
    // fans (Begonia's): each one's stream (left, top, right, bottom), the way it blows (0 right, 90 up, 180 left, 270
    // down), and where its line of sight to the player starts
    public List<int[]> Fans = new List<int[]>();
    // where the player can stand: per x, the y's; and each one's region
    public Dictionary<long, int> PosRegion = new Dictionary<long, int>();
    public Dictionary<long, int> MPosRegion = new Dictionary<long, int>();
    public int NRegions;
    public List<Edge> Edges = new List<Edge>();
    public List<Touch> Touches = new List<Touch>();
    public List<int[]> Entries = new List<int[]>();       // x, y (in this room)
    public Dictionary<long, int> EntryNode = new Dictionary<long, int>();   // entry (x,y) -> node (region numbers past NRegions)
    public int NNodes;
    public List<string> Log = new List<string>();
    public List<string> FpsRejects = new List<string>();   // (Analyzer.LogRejects)
    public int Sims;
    // a room with switch states (AnalyzeStates): each state's first node and how many regions it has
    public int[] StateOff, StateRegions;
    public int StateInit;
    // each node in words ("standing at x 590-790, y 593", "hanging from the Strike Chain point at 544,112"...)
    public Dictionary<int, string> NodeName = new Dictionary<int, string>();
    // the ways in that can't be come in at (inside a solid), for the room file
    public List<string> BadEntries = new List<string>();
    // a room with switch states: the states the player can come in in (its carried ones as they come in), and each way
    // in's node in each of them
    public List<int> EntryStates = new List<int>();
    public Dictionary<long, Dictionary<int, int>> EntryByState = new Dictionary<long, Dictionary<int, int>>();

    public Room(RoomData d) { Data = d; }
}

class Analyzer
{
    Room R;
    HashSet<string> edgeSeen = new HashSet<string>();
    HashSet<string> touchSeen = new HashSet<string>();
    // (falling pillars: the regions partly on a pillar's top and partly not, whose joins are kept for each place they
    // start or end at (the region splits where the pillar falls); and the pillars each region's moves touch or go through)
    HashSet<int> mixedReg = new HashSet<int>();
    Dictionary<int, int> runPills = new Dictionary<int, int>();

    public Analyzer(Room r) { R = r; }

    // where the game has wall jumps (oPlayer1's Alarm 0: bCanWallJump)
    bool wallArea { get { return R.Data.Area == 29 || R.Data.Area == 91 || R.Data.Area == 104; } }

    bool traceOn;
    public void TraceMove(int x, int y, string name, int dir)
    {
        Build();
        int nN, nM;
        normal = Standable(40);
        normalReg = MakeRegions(normal, R.PosRegion, 0, out nN, out normalGates);
        morphPs = Standable(13);
        morphReg = MakeRegions(morphPs, R.MPosRegion, nN, out nM, out morphGates);
        morphOnly = morphPs.Any(p => !R.PosRegion.ContainsKey(Shape.Key(p.X, p.Y)));
        traceOn = true;
        // (a move off a Strike Chain point: x,y the point; the player hangs 40px under it)
        if (name.StartsWith("hang"))
        {
            foreach (var p in HangPrograms())
            {
                if (p.Name != name || p.Dir != dir) continue;
                Console.WriteLine("== {0} dir {1} ch {2} ({3}) from the point {4},{5}", p.Name, p.Dir, p.Ch, p.Label, x, y);
                var res = Run(p, x, y + 40, false, false, true, false);
                Console.WriteLine("landed {0},{1} region {2} safe {3}; locations {4}; exits {5}; points {6}", res.LandX, res.LandY,
                    res.LandX == int.MinValue ? -1 : RegionAt(res.LandX, res.LandY, false),
                    res.LandX != int.MinValue && SafeLanding(res.LandX, res.LandY, false, false), string.Join(",", res.Locs), string.Join(",", res.Exits),
                    string.Join(",", res.Hangs.Select(k => R.Points[k][0] + "/" + R.Points[k][1])));
            }
            return;
        }
        // (a move off a wall, where the game has wall jumps: x,y beside it in the air, dir the wall's side)
        if (name.StartsWith("kick") || name == "letgo")
        {
            foreach (var p in WallPrograms(dir))
            {
                if (p.Name != name) continue;
                Console.WriteLine("== {0} wall side {1} ch {2} ({3}) from {4},{5}", p.Name, dir, p.Ch, p.Label, x, y);
                var res = Run(p, x, y, false, false, true, false);
                Console.WriteLine("landed {0},{1} region {2} safe {3}; locations {4}; exits {5}; clings {6}", res.LandX, res.LandY,
                    res.LandX == int.MinValue ? -1 : RegionAt(res.LandX, res.LandY, false),
                    res.LandX != int.MinValue && SafeLanding(res.LandX, res.LandY, false, false), string.Join(",", res.Locs), string.Join(",", res.Exits),
                    string.Join(",", res.Clings.Select(k => (k >> 32) + "/" + (int)(uint)k)));
            }
            return;
        }
        // (the standing place nearest below the given point)
        for (int dy = 0; dy < 64; dy++) if (R.PosRegion.ContainsKey(Shape.Key(x, y + dy))) { y += dy; break; }
        Console.WriteLine("standing at {0},{1}: region {2}", x, y, RegionAt(x, y, false));
        // (search: every jump hold, double jump and air dash timing, either character, running or not: where they land)
        if (name == "search")
        {
            traceOn = false;
            var found = new Dictionary<int, string>();
            foreach (int d in new[] { -1, 1 })
                foreach (bool run in new[] { false, true })
                    foreach (int ch in new[] { 0, 1 })
                        for (int hold = 2; hold <= 21; hold += 1)
                            foreach (int dj in new[] { -1, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24 })
                                foreach (int ad in new[] { -1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26 })
                                    foreach (int h2 in new[] { 1, 0, -1 })
                                        foreach (int hd in new[] { 0, 6, 12 })
                                        {
                                            if (h2 != 1 && hd == 0) continue;
                                            var lab = new Req();
                                            if (dj >= 0) lab = lab.With(Req.DJUMP, 1);
                                            if (ad >= 0) lab = lab.With(Req.ADASH, 1);
                                            var p = new Prog { Name = "s", Ch = ch, Dir = d, RunStart = run, JumpAt = 0, JumpHold = hold, DjAt = dj, AdAt = ad, H1 = hd == 0 ? 1 : 0, H2 = h2, HDelay = hd, Label = lab, MaxT = 120 };
                                            var res = Run(p, x, y, false, false, false, false);
                                            if (res.LandX == int.MinValue) continue;
                                            int rg = RegionAt(res.LandX, res.LandY, false);
                                            bool safe = SafeLanding(res.LandX, res.LandY, false, false);
                                            string desc = string.Format("dir {0} run {1} ch {2} hold {3} dj {4} ad {5} h {6}/{7}@{8} -> {9},{10}{11}", d, run ? 1 : 0, ch, hold, dj, ad, p.H1, h2, hd, res.LandX, res.LandY, safe ? "" : " (edge)");
                                            string old;
                                            if (!found.TryGetValue(rg, out old) || (old.EndsWith("(edge)") && safe)) found[rg] = desc;
                                        }
            foreach (var kv in found.OrderBy(k => k.Key)) Console.WriteLine("region {0}: {1}", kv.Key, kv.Value);
            return;
        }
        foreach (var p in Programs(false, true, true, true, true))
        {
            if (p.Name != name || p.Dir != dir) continue;
            Console.WriteLine("== {0} dir {1} ch {2} ({3})", p.Name, p.Dir, p.Ch, p.Label);
            var res = Run(p, x, y, false, false, false, false);
            Console.WriteLine("landed {0},{1}{6} region {2} safe {3}; locations {4}; exits {5}; points {7}", res.LandX, res.LandY,
                res.LandX == int.MinValue ? -1 : RegionAt(res.LandX, res.LandY, res.Morph),
                res.LandX != int.MinValue && SafeLanding(res.LandX, res.LandY, res.Morph, false), string.Join(",", res.Locs), string.Join(",", res.Exits),
                res.Morph ? " (Morph Ball)" : "", string.Join(",", res.Hangs.Select(k => R.Points[k][0] + "/" + R.Points[k][1])));
        }
    }

    // RoomLogic.exe --move: one move given field by field (a Prog), from x,y (standing there, or falling with airStart),
    // tick by tick in lines a program reads: "T tick x y xVel yVel state keys morph" (keys: the input that tick, KeysOf;
    // morph 1 while the Morph Ball), then
    // "LAND x y tick" or "NOLAND" (for comparing the movement with the game's: tools\modkit\logictest\calib.py)
    bool machineTrace;
    public void MoveSpec(int x, int y, Prog p, bool airStart, bool morphStart, bool open = false)
    {
        Build();
        int nN, nM;
        normal = Standable(40);
        normalReg = MakeRegions(normal, R.PosRegion, 0, out nN, out normalGates);
        morphPs = Standable(13);
        morphReg = MakeRegions(morphPs, R.MPosRegion, nN, out nM, out morphGates);
        morphOnly = morphPs.Any(q => !R.PosRegion.ContainsKey(Shape.Key(q.X, q.Y)));
        if (R.GroundFoes.Count > 0 && R.Stompers.Count == 0) MakeStompers();
        // (off a Strike Chain point: x,y the point, the player hanging 40px under it, in the air; off a wall: beside it in
        // the air, as TraceMove has them)
        if (p.FromHang) { y += 40; airStart = true; }
        if (p.FromWall) airStart = true;
        // (standing: on the standing place nearest below the given point, as a way in's player lands)
        if (!airStart)
            for (int dy = 0; dy < 64; dy++)
                if ((morphStart ? R.MPosRegion : R.PosRegion).ContainsKey(Shape.Key(x, y + dy))) { y += dy; break; }
        Console.WriteLine("START {0} {1}", x, y);
        machineTrace = true;
        var res = Run(p, x, y, open, morphStart, airStart, false);
        machineTrace = false;
        if (res.LandX == int.MinValue) Console.WriteLine("NOLAND");
        else Console.WriteLine("LAND {0} {1} {2}", res.LandX, res.LandY, res.LandT);
    }

    static string KeysOf(In i)
    {
        var k = new List<string>();
        if (i.L) k.Add("L"); if (i.R) k.Add("R"); if (i.J) k.Add("J"); if (i.D) k.Add("D"); if (i.DL) k.Add("DL"); if (i.DR) k.Add("DR"); if (i.A) k.Add("A");
        return k.Count == 0 ? "-" : string.Join("+", k);
    }

    public void Build()
    {
        var d = R.Data;
        R.SolidC = new Bits2D(d.W, d.H); R.SolidO = new Bits2D(d.W, d.H); R.Plat = new Bits2D(d.W, d.H);
        R.Haz = new Bits2D(d.W, d.H); R.Water = new Bits2D(d.W, d.H); R.GhostB = new Bits2D(d.W, d.H);
        R.HazV = new Bits2D(d.W, d.H);
        // (the grids' extent: the room and Bits2D.M around it)
        var grid = new[] { -Bits2D.M, -Bits2D.M, d.W + Bits2D.M - 1, d.H + Bits2D.M - 1 };
        var falling = new List<Loc>();
        var rippers = new List<int[]>();
        var rocks = new List<Shape>();
        var floats = new List<Tuple<Mask, Inst>>();
        foreach (var it in d.I)
        {
            if (it.K == 'M' || it.K == 'B' || it.K == 'Q') continue;
            if (it.K == 'F')
            {
                if (it.Spr == "sNull") continue;
                var fs = new Shape(Mask.Get(it.Spr), it.X, it.Y, it.XS, it.YS, it.A);
                if (!fs.Empty) { R.Flyers.Add(fs); R.FlyerNames.Add(it.F.Length > 0 ? it.F[0] : it.Spr); }
                continue;
            }
            if (it.K == 'e') { R.GroundFoes.Add(new[] { (int)Math.Round(it.X), (int)Math.Round(it.Y) }); continue; }
            if (it.K == 'k') { rippers.Add(new[] { (int)Math.Round(it.X), (int)Math.Round(it.Y) }); continue; }
            if (it.K == 'n')
            {
                // (a fan a switch turns on and off is there only in its state: StateData)
                if (it.F.Length >= 3 && ((d.Initial >> int.Parse(it.F[1])) & 1) != int.Parse(it.F[2])) continue;
                // (oBegoniaFan's Step: the stream 224px its way and 16px times its yscale to either side; the line of
                // sight from 2px out of it)
                int fx = (int)Math.Round(it.X), fy = (int)Math.Round(it.Y), half = (int)Math.Round(16 * it.YS), way = int.Parse(it.F[0]);
                if (way == 0) R.Fans.Add(new[] { fx, fy - half, fx + 224, fy + half, 0, fx + 2, fy });
                else if (way == 90) R.Fans.Add(new[] { fx - half, fy - 224, fx + half, fy, 90, fx, fy - 2 });
                else if (way == 180) R.Fans.Add(new[] { fx - 224, fy - half, fx, fy + half, 180, fx - 2, fy });
                else R.Fans.Add(new[] { fx - half, fy, fx + half, fy + 224, 270, fx, fy + 2 });
                continue;
            }
            var m = Mask.Get(it.Spr);
            if (m == null) { R.Log.Add("no mask: " + it.Spr); continue; }
            switch (it.K)
            {
                case 'S': m.Stamp(it.X, it.Y, it.XS, it.YS, it.A, (x, y) => { R.SolidC.Set(x, y); R.SolidO.Set(x, y); }); break;
                case 'P':
                    m.Stamp(it.X, it.Y, it.XS, it.YS, it.A, (x, y) => R.Plat.Set(x, y));
                    if (it.Spr == "sPlatTempFade") R.Fades.Add(new Shape(m, it.X, it.Y, it.XS, it.YS, it.A));
                    break;
                case 'H': m.Stamp(it.X, it.Y, it.XS, it.YS, it.A, (x, y) => R.Haz.Set(x, y), grid); break;
                case 'W': m.Stamp(it.X, it.Y, it.XS, it.YS, it.A, (x, y) => R.Water.Set(x, y)); break;
                case 'G':
                    {
                        var g = new Gate { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), Need = Req.ParseAlts(it.F[0]), Name = it.F.Length > 1 ? it.F[1] : "" };
                        if (g.S.Empty) break;
                        bool free = g.Need.Count == 1 && g.Need[0].None;
                        if (free) break;   // opens with nothing: not there
                        string key = string.Join("|", g.Need.Select(q => q.ToString()));
                        int grp;
                        if (!R.GateGroupOf.TryGetValue(key, out grp)) { grp = R.GroupNeed.Count; R.GateGroupOf[key] = grp; R.GroupNeed.Add(g.Need); }
                        if (grp >= 31) { R.Log.Add("more than 31 kinds of gate: " + g.Name + " is left solid"); foreach (var k2 in g.S.Px) R.SolidO.Set((int)(k2 >> 32), (int)(uint)k2); }
                        g.Group = grp;
                        R.Gates.Add(g);
                        foreach (var k in g.S.Px) R.SolidC.Set((int)(k >> 32), (int)(uint)k);
                        break;
                    }
                case 'v':
                    {
                        // (a hazard its requirement makes harmless: a gate that's never solid, a hazard while it's shut;
                        // past 31 kinds of gate, a hazard for good. Only its part in the room's grid: Gate 5's heated
                        // rooms are an invisible lava 16 times the room's size)
                        var g = new Gate { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A, grid), Need = Req.ParseAlts(it.F[0]), Name = it.F.Length > 1 ? it.F[1] : "", Hazard = true };
                        if (g.S.Empty) break;
                        string key = string.Join("|", g.Need.Select(q => q.ToString()));
                        int grp;
                        if (!R.GateGroupOf.TryGetValue(key, out grp)) { grp = R.GroupNeed.Count; R.GateGroupOf[key] = grp; R.GroupNeed.Add(g.Need); }
                        if (grp >= 31) { R.Log.Add("more than 31 kinds of gate: " + g.Name + " is left a hazard"); foreach (var k2 in g.S.Px) R.Haz.Set((int)(k2 >> 32), (int)(uint)k2); break; }
                        g.Group = grp;
                        R.Gates.Add(g);
                        foreach (var k in g.S.Px) R.HazV.Set((int)(k >> 32), (int)(uint)k);
                        break;
                    }
                //case 'J': R.Springs.Add(new Spring { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), Large = it.F[0] == "L" }); break;
                case 'J': R.Springs.Add(new Spring { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), Large = it.F[0] == "L", Ticks = it.F[0] == "L" ? (int)Math.Round(7 * it.XS) : 3 }); break;
                case 'o': R.Cannons.Add(new Cannon { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), X = (int)Math.Round(it.X), Y = (int)Math.Round(it.Y), Dir = it.XS < 0 ? -1 : 1, Ticks = (int)Math.Round(double.Parse(it.F[0], CultureInfo.InvariantCulture)) }); break;
                case 'X':
                    {
                        int ix = (int)Math.Round(it.X), iy = (int)Math.Round(it.Y);
                        int nx = (int)Math.Round(double.Parse(it.F[1], CultureInfo.InvariantCulture)), ny = (int)Math.Round(double.Parse(it.F[2], CultureInfo.InvariantCulture));
                        // (one whose way goes by a carried group: a line for each of its states, one exit)
                        if (it.F.Length >= 7)
                        {
                            int gi = int.Parse(it.F[5]); bool one = it.F[6] == "1";
                            var same = R.Exits.FirstOrDefault(e => e.Group == gi && e.IX == ix && e.IY == iy);
                            if (same == null)
                            {
                                same = new Exit { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), Type = int.Parse(it.F[3]), IX = ix, IY = iy, Obj = it.F[4], Group = gi,
                                    To = it.F[0], NX = nx, NY = ny, To1 = it.F[0], NX1 = nx, NY1 = ny };
                                R.Exits.Add(same);
                            }
                            if (one) { same.To1 = it.F[0]; same.NX1 = nx; same.NY1 = ny; } else { same.To = it.F[0]; same.NX = nx; same.NY = ny; }
                            break;
                        }
                        R.Exits.Add(new Exit { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), To = it.F[0], NX = nx, NY = ny, Type = int.Parse(it.F[3]),
                            IX = ix, IY = iy, Obj = it.F.Length > 4 ? it.F[4] : "" });
                        break;
                    }
                case 'D':
                    R.Exits.Add(new Exit { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), To = d.Name, NX = (int)Math.Round(double.Parse(it.F[0], CultureInfo.InvariantCulture)), NY = (int)Math.Round(double.Parse(it.F[1], CultureInfo.InvariantCulture)), Type = int.Parse(it.F[2]), InRoom = true,
                        IX = (int)Math.Round(it.X), IY = (int)Math.Round(it.Y), Obj = "oMapDoor" });
                    break;
                case 'L':
                    {
                        var sh = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A);
                        R.Locs.Add(new Loc { Type = int.Parse(it.F[0]), Num = int.Parse(it.F[1]), S = sh, Label = it.F.Length > 3 ? it.F[3] : "" });
                        if (it.F.Length > 2 && it.F[2] == "1") falling.Add(R.Locs[R.Locs.Count - 1]);
                        break;
                    }
                case 'V': R.Elevators.Add(new[] { (int)Math.Round(it.X), (int)Math.Round(it.Y) }.Concat(it.F.Select(v => (int)Math.Round(double.Parse(v, CultureInfo.InvariantCulture)))).ToArray()); break;
                case 'r': rocks.Add(new Shape(m, it.X, it.Y, it.XS, it.YS, it.A)); break;
                case 'f': floats.Add(Tuple.Create(m, it)); break;
                case 's': R.Spots.Add(new Spot { Tag = it.F[0], S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A) }); break;
                case 'K': R.Points.Add(new[] { (int)Math.Round(it.X), (int)Math.Round(it.Y) }); break;
                case 'c': R.Crystals.Add(new Shape(m, it.X, it.Y, it.XS, it.YS, it.A)); break;
                case 'z':
                    {
                        // a solid there only part of the time (Nightmare Gate D's platforms, while a sweeping zone shows
                        // them): a gate that needs nothing, stood on while it's there and gone through while it isn't
                        // (the player waits for it)
                        var ts = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A);
                        if (ts.Empty) break;
                        int grp;
                        if (!R.GateGroupOf.TryGetValue("(there part of the time)", out grp)) { grp = R.GroupNeed.Count; R.GateGroupOf["(there part of the time)"] = grp; R.GroupNeed.Add(new List<Req> { new Req() }); }
                        if (grp >= 31) { R.Log.Add("more than 31 kinds of gate: a platform there part of the time is left out"); break; }
                        R.Gates.Add(new Gate { S = ts, Need = new List<Req> { new Req() }, Name = "Nightmare platform (while hidden)", Group = grp });
                        foreach (var k in ts.Px) R.SolidC.Set((int)(k >> 32), (int)(uint)k);
                        break;
                    }
                case 'q':
                    {
                        // a falling pillar: its top and its column a gate of their own that needs nothing, shut while it
                        // stands (PillarStates: which have fallen is the room's state as the player goes)
                        var top = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A);
                        var col = new Shape(m, double.Parse(it.F[0], CultureInfo.InvariantCulture), double.Parse(it.F[1], CultureInfo.InvariantCulture),
                                            double.Parse(it.F[2], CultureInfo.InvariantCulture), double.Parse(it.F[3], CultureInfo.InvariantCulture), 0);
                        int grp = R.GroupNeed.Count;
                        if (grp >= 31)
                        {
                            R.Log.Add("more than 31 kinds of gate: a falling pillar is left standing");
                            foreach (var k in top.Px.Concat(col.Px)) { R.SolidC.Set((int)(k >> 32), (int)(uint)k); R.SolidO.Set((int)(k >> 32), (int)(uint)k); }
                            break;
                        }
                        R.GroupNeed.Add(new List<Req> { new Req() });
                        R.PillarMask |= 1 << grp;
                        R.Pillars.Add(new Pillar { Top = top, Col = col, Group = grp });
                        foreach (var ps in new[] { top, col })
                        {
                            if (ps.Empty) continue;
                            R.Gates.Add(new Gate { S = ps, Need = new List<Req> { new Req() }, Name = "falling pillar", Group = grp });
                            foreach (var k in ps.Px) R.SolidC.Set((int)(k >> 32), (int)(uint)k);
                        }
                        break;
                    }
                case 'N':
                    {
                        int group = R.Movers++;
                        var pts = new List<double[]>();
                        Func<int, double> f = k => double.Parse(it.F[k], CultureInfo.InvariantCulture);
                        if (it.F[0] == "line")
                        {
                            double x1 = f(1), y1 = f(2), x2 = f(3), y2 = f(4);
                            int n = Math.Max(1, (int)Math.Ceiling(Math.Sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)) / 16));
                            for (int k = 0; k <= n; k++) pts.Add(new[] { x1 + (x2 - x1) * k / n, y1 + (y2 - y1) * k / n });
                        }
                        else if (it.F[0] == "legs")
                        {
                            // (a rail's: along each of its legs, corner to corner: x1 y1 x2 y2 a leg)
                            for (int c = 1; c + 3 < it.F.Length; c += 4)
                            {
                                double x1 = f(c), y1 = f(c + 1), x2 = f(c + 2), y2 = f(c + 3);
                                int n = Math.Max(1, (int)Math.Ceiling(Math.Sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)) / 16));
                                for (int k = 0; k <= n; k++) pts.Add(new[] { x1 + (x2 - x1) * k / n, y1 + (y2 - y1) * k / n });
                            }
                        }
                        else
                        {
                            double cx = f(1), cy = f(2), rr = f(3);
                            int n = Math.Max(8, (int)Math.Ceiling(2 * Math.PI * rr / 16));
                            for (int k = 0; k < n; k++) { double a = 2 * Math.PI * k / n; pts.Add(new[] { cx + rr * Math.Cos(a), cy + rr * Math.Sin(a) }); }
                        }
                        foreach (var p in pts)
                        {
                            var top = new Dictionary<int, int>();
                            m.Stamp(p[0], p[1], it.XS, it.YS, it.A, (x, y) => { int t; if (!top.TryGetValue(x, out t) || y < t) top[x] = y; });
                            foreach (var kv in top)
                                for (int dy = 0; dy < 3; dy++) { R.GhostB.Set(kv.Key, kv.Value + dy); R.Ghost[Shape.Key(kv.Key, kv.Value + dy)] = group; }
                        }
                        // the part of it that's there wherever it is along a line (a block that moves less than its own
                        // size): a solid, a wall to cling to where the game has wall jumps
                        if (it.F[0] == "line")
                        {
                            var first = new HashSet<long>();
                            m.Stamp(pts[0][0], pts[0][1], it.XS, it.YS, it.A, (x, y) => first.Add(Shape.Key(x, y)));
                            var last = pts[pts.Count - 1];
                            m.Stamp(last[0], last[1], it.XS, it.YS, it.A, (x, y) => { if (first.Contains(Shape.Key(x, y))) { R.SolidC.Set(x, y); R.SolidO.Set(x, y); } });
                        }
                        break;
                    }
            }
        }
        // pickups that fall (keys) lie on the ground, and springs sit on it (they fall to it as the room starts)
        foreach (var l in falling) DropShape(l);
        foreach (var s in R.Springs)
        {
            int drop = 0;
            while (drop < 2000 && !R.SolidC.Row(s.S.Y1 + drop + 1, s.S.X0, s.S.X1) && !R.Plat.Row(s.S.Y1 + drop + 1, s.S.X0, s.S.X1) && s.S.Y1 + drop < d.H + 64) drop++;
            if (drop > 0 && drop < 2000) Shift(s.S, 0, drop);
        }
        // a Ripper's Strike Chain point flies left and right along its row (the Ripper's box: 10px to either side, 5px
        // up and down), turning at walls: points along its way, every 24px (the player waits for it to come by)
        foreach (var rp in rippers)
        {
            int a = rp[0], b = rp[0], ry = rp[1];
            while (a > -32 && !R.SolidC.Box(a - 11, ry - 5, a + 9, ry + 4)) a--;
            while (b < d.W + 32 && !R.SolidC.Box(b - 9, ry - 5, b + 11, ry + 4)) b++;
            for (int x = a; x <= b; x += 24) R.Points.Add(new[] { x, ry });
            if ((b - a) % 24 != 0) R.Points.Add(new[] { b, ry });
        }
        // a floating platform (the Water Palace's): in water it rises till its bottom is 4px under the water's top, out of it
        // it falls, stopping at solids: where it ends up at this state's water, a solid there
        foreach (var fl in floats)
        {
            var fs = new Shape(fl.Item1, fl.Item2.X, fl.Item2.Y, fl.Item2.XS, fl.Item2.YS, fl.Item2.A);
            if (fs.Empty) continue;
            int fw = fs.X1 - fs.X0, fh = fs.Y1 - fs.Y0, fx = fs.X0;
            Func<int, bool> freeAt = ay => !R.SolidC.Box(fx, ay, fx + fw, ay + fh);
            int top = int.MaxValue;
            for (int yy = -64; yy < d.H + 64 && top == int.MaxValue; yy++) if (R.Water.Row(yy, fx, fx + fw)) top = yy;
            int target = top == int.MaxValue ? d.H + 64 : top + 4 - fh;
            int fy = fs.Y0;
            if (target < fy) while (fy > target && freeAt(fy - 1)) fy--;
            else while (fy < target && fy < d.H + 64 && freeAt(fy + 1)) fy++;
            fl.Item1.Stamp(fl.Item2.X, fl.Item2.Y + (fy - fs.Y0), fl.Item2.XS, fl.Item2.YS, fl.Item2.A, (x, y) => { R.SolidC.Set(x, y); R.SolidO.Set(x, y); });
        }
        // a push rock: walked into, it slides (if nothing's in its way), and with nothing under it, it falls. Where it can
        // be pushed to, left and right from where it comes to rest (falling off edges, onto what's below): RockMoves. It
        // isn't a wall (it can be pushed out of the way)
        foreach (var rk in rocks)
        {
            if (rk.Empty) continue;
            int w = rk.X1 - rk.X0, h = rk.Y1 - rk.Y0;
            Func<int, int, bool> free = (ax, ay) => !R.SolidC.Box(ax, ay, ax + w, ay + h);
            int sx = rk.X0, sy = rk.Y0;
            while (sy < d.H + 64 && free(sx, sy + 1)) sy++;
            if (sy >= d.H + 64) continue;
            var seenP = new HashSet<long> { Shape.Key(sx, sy) };
            var q = new Queue<int[]>(); q.Enqueue(new[] { sx, sy });
            var places = new List<int[]>();
            while (q.Count > 0 && places.Count < 20000)
            {
                var c = q.Dequeue();
                places.Add(c);
                foreach (int dx in new[] { -1, 1 })
                {
                    int nx = c[0] + dx, ny = c[1];
                    if (!free(nx, ny)) continue;
                    while (ny < d.H + 64 && free(nx, ny + 1)) ny++;
                    if (ny >= d.H + 64) continue;
                    if (seenP.Add(Shape.Key(nx, ny))) q.Enqueue(new[] { nx, ny });
                }
            }
            R.Rocks.Add(new Rock { X = sx, Y = sy, W = w, H = h, From = rk.X0 + "," + rk.Y0, Places = places });
        }
    }

    void DropShape(Loc l)
    {
        int drop = 0;
        while (drop < 3000 && !R.SolidC.Row(l.S.Y1 + drop + 1, l.S.X0, l.S.X1) && !R.Plat.Row(l.S.Y1 + drop + 1, l.S.X0, l.S.X1) && l.S.Y1 + drop < R.Data.H + 64) drop++;
        if (drop > 0 && drop < 3000) Shift(l.S, 0, drop);
    }

    static void Shift(Shape s, int dx, int dy)
    {
        var n = new HashSet<long>();
        foreach (var k in s.Px) n.Add(Shape.Key((int)(k >> 32) + dx, (int)(uint)k + dy));
        s.Px = n; s.X0 += dx; s.X1 += dx; s.Y0 += dy; s.Y1 += dy;
    }

    // ---------------------------------------------------------------- where the player can stand
    // standing at (x,y): the body (x-7..x+6, y-top..y-2) clear, something to stand on in row y-1, no hazard touched
    bool Clear(Bits2D s, int x, int y, int top) { for (int cx = x - 7; cx <= x + 6; cx++) if (s.Col(cx, y - top, y - 2)) return false; return true; }
    // where the player can stand (not beside walls), as x,y: for the bricks (BricksKept), with the room built
    public List<int[]> StandingPlaces() { return Standable(40).Where(p => p.Cling == 0).Select(p => new[] { p.X, p.Y }).ToList(); }
    bool Floor(Bits2D s, int x, int y, int top)
    {
        if (s.Row(y - 1, x - 7, x + 6)) return true;
        return (R.Plat.Any && R.Plat.Row(y - 1, x - 7, x + 6) && !R.Plat.Box(x - 7, y - top, x + 6, y - 2)) || R.GhostB.Row(y - 1, x - 7, x + 6);
    }
    // (the game's hurt box is the sprite's mask: standing, from 46px above the feet; the Morph Ball's, 14px)
    // (open: with the gates open, so a hazard that's also a gate, Gate 5's lava, isn't one)
    public bool HazardAt(int x, int y, int top, bool open = false)
    {
        int y0 = y - (top < 40 ? 14 : Math.Max(top, 46));
        return (R.Haz.Any && R.Haz.Box(x - 7, y0, x + 6, y - 2)) || (!open && R.HazV.Any && R.HazV.Box(x - 7, y0, x + 6, y - 2));
    }

    // Gates: bit set of the gates the body is in (open-only places). Cling: beside a wall in the air, where the game has
    // wall jumps (the player climbs any wall there by kicking off it): the side it's on (1 right, -1 left), else 0
    class Pos { public int X, Y; public int Gates; public int Cling; }

    // the gates the player standing at x,y is in: a solid one in the body's box, a hazard one in the hurt box (HazardAt's)
    // the falling pillars a body at x,y touches, a pixel round it: standing on one, against or under its column
    // the falling pillars whose tops the feet at x,y are on (oPlatform_CVFall's isCollisionCharacterTop: it shakes, and
    // falls 25 ticks later)
    int PillarsUnder(int x, int y)
    {
        int b = 0;
        foreach (var pl in R.Pillars) if (pl.Top.Hits(x - 7, y - 1, x + 6, y - 1)) b |= 1 << pl.Group;
        return b;
    }
    // (standing at x,y on something besides the falling pillars: a floor, a platform)
    bool OffPillar(int x, int y) { return R.SolidO.Row(y - 1, x - 7, x + 6) || (R.Plat.Any && R.Plat.Row(y - 1, x - 7, x + 6)) || R.GhostB.Row(y - 1, x - 7, x + 6); }

    int PillarsTouched(int x, int y, int top)
    {
        int b = 0;
        foreach (var pl in R.Pillars)
            if (pl.Top.Hits(x - 8, y - top - 1, x + 7, y - 1) || pl.Col.Hits(x - 8, y - top - 1, x + 7, y - 1)) b |= 1 << pl.Group;
        return b;
    }

    int GatesAt(int x, int y, int top)
    {
        int gs = 0, h0 = y - (top < 40 ? 14 : Math.Max(top, 46));
        foreach (var gt in R.Gates)
            if (gt.Group < 31 && (gt.Hazard ? gt.S.Hits(x - 7, h0, x + 6, y - 2) : gt.S.Hits(x - 7, y - top, x + 6, y - 2))) gs |= 1 << gt.Group;
        return gs;
    }

    List<Pos> Standable(int top)
    {
        var outp = new List<Pos>();
        var d = R.Data;
        int y0 = -64, y1 = d.H + 64;
        for (int x = 0; x <= d.W; x++)
        {
            // rows where the body's columns have a solid (closed: gates too) and where they have one with gates open
            int n = y1 - y0 + 1;
            var occC = new bool[n]; var occO = new bool[n];
            for (int i = 0; i < n; i++) { int yy = y0 + i; occC[i] = R.SolidC.Row(yy, x - 7, x + 6); occO[i] = R.Gates.Count > 0 ? R.SolidO.Row(yy, x - 7, x + 6) : occC[i]; }
            int runC = 0, runO = 0;   // clear rows in a row above (ending at the row before y-1)
            for (int i = 0; i < n; i++)
            {
                int yy = y0 + i;   // the row being looked at is y-1 = yy, body rows yy-top+1 .. yy-1 (y = yy+1)
                int y = yy + 1;
                if (runC >= top - 1 && (occC[i] || (R.Plat.Any && R.Plat.Row(yy, x - 7, x + 6) && !R.Plat.Box(x - 7, y - top, x + 6, y - 2)) || R.GhostB.Row(yy, x - 7, x + 6)))
                {
                    if (!HazardAt(x, y, top)) outp.Add(new Pos { X = x, Y = y });
                    else if (R.HazV.Any && !HazardAt(x, y, top, true))
                    {
                        // (in a hazard its gate makes harmless: a place with that gate open)
                        int gs = GatesAt(x, y, top);
                        if (gs != 0) outp.Add(new Pos { X = x, Y = y, Gates = gs });
                    }
                }
                else if (wallArea && top == 40 && runC >= top - 1)
                {
                    int side = R.SolidC.Col(x + 7, y - top, y - 2) ? 1 : (R.SolidC.Col(x - 8, y - top, y - 2) ? -1 : 0);
                    if (side != 0 && !HazardAt(x, y, top)) outp.Add(new Pos { X = x, Y = y, Cling = side });
                }
                else if (R.Gates.Count > 0 && runO >= top - 1 && (occO[i] || (R.Plat.Any && R.Plat.Row(yy, x - 7, x + 6) && !R.Plat.Box(x - 7, y - top, x + 6, y - 2)) || R.GhostB.Row(yy, x - 7, x + 6)))
                {
                    if (!HazardAt(x, y, top, true))
                    {
                        int gs = GatesAt(x, y, top);
                        if (gs != 0) outp.Add(new Pos { X = x, Y = y, Gates = gs });
                    }
                }
                runC = occC[i] ? 0 : runC + 1;
                runO = occO[i] ? 0 : runO + 1;
            }
        }
        return outp;
    }

    int[] parent;
    int Find(int a) { while (parent[a] != a) { parent[a] = parent[parent[a]]; a = parent[a]; } return a; }

    // regions: places joined by walking (a step of up to 4px), with the same gates in the way; returns region per place
    List<int> MakeRegions(List<Pos> ps, Dictionary<long, int> map, int baseRegion, out int count, out Dictionary<int, int> regGates)
    {
        var idx = new Dictionary<long, int>();
        for (int i = 0; i < ps.Count; i++) idx[Shape.Key(ps[i].X, ps[i].Y)] = i;
        parent = new int[ps.Count];
        for (int i = 0; i < ps.Count; i++) parent[i] = i;
        var cross = new List<int[]>();
        for (int i = 0; i < ps.Count; i++)
        {
            var p = ps[i];
            for (int dy = -4; dy <= 4; dy++)
            {
                int j;
                if (!idx.TryGetValue(Shape.Key(p.X + 1, p.Y + dy), out j)) continue;
                if (ps[j].Gates == p.Gates) { int a = Find(i), b = Find(j); if (a != b) parent[a] = b; }
                else cross.Add(new[] { i, j });
            }
            // up and down a wall (where the game has wall jumps)
            if (p.Cling != 0)
                foreach (int dy in new[] { -1, 1 })
                {
                    int j;
                    if (!idx.TryGetValue(Shape.Key(p.X, p.Y + dy), out j) || ps[j].Gates != p.Gates) continue;
                    int a = Find(i), b = Find(j); if (a != b) parent[a] = b;
                }
        }
        var rid = new Dictionary<int, int>();
        var res = new List<int>();
        regGates = new Dictionary<int, int>();
        for (int i = 0; i < ps.Count; i++)
        {
            int r = Find(i), id;
            if (!rid.TryGetValue(r, out id)) { id = baseRegion + rid.Count; rid[r] = id; regGates[id] = ps[i].Gates; }
            res.Add(id);
            map[Shape.Key(ps[i].X, ps[i].Y)] = id;
        }
        count = rid.Count;
        // walking into a gate's place needs the gate open
        foreach (var c in cross)
        {
            int a = res[c[0]], b = res[c[1]];
            var pa = ps[c[0]]; var pb = ps[c[1]];
            //AddEdge(a, b, GatesNeed(pb.Gates), "walk from " + pa.X + "," + pa.Y + " to " + pb.X + "," + pb.Y + (pb.Gates != 0 ? " into " + GatesWords(pb.Gates, pb.X, pb.Y) : ""));
            //AddEdge(b, a, GatesNeed(pa.Gates), "walk from " + pb.X + "," + pb.Y + " to " + pa.X + "," + pa.Y + (pa.Gates != 0 ? " into " + GatesWords(pa.Gates, pa.X, pa.Y) : ""));
            // (where a falling pillar's gone: its gate)
            AddEdgeAt(a, b, GatesNeed(pb.Gates), "walk from " + pa.X + "," + pa.Y + " to " + pb.X + "," + pb.Y + (pb.Gates != 0 ? " into " + GatesWords(pb.Gates, pb.X, pb.Y) : ""), pa.X, pa.Y, pb.X, pb.Y, pb.Gates & R.PillarMask);
            AddEdgeAt(b, a, GatesNeed(pa.Gates), "walk from " + pb.X + "," + pb.Y + " to " + pa.X + "," + pa.Y + (pa.Gates != 0 ? " into " + GatesWords(pa.Gates, pa.X, pa.Y) : ""), pb.X, pb.Y, pa.X, pa.Y, pa.Gates & R.PillarMask);
        }
        return res;
    }

    // the gates of a set (bits: gate groups) in words, the ones the body at x,y is in (any of them if x is int.MinValue):
    // "the locked door at 1200,288"...
    string GatesWords(int gs, int x, int y)
    {
        var w = new List<string>();
        foreach (var gt in R.Gates)
        {
            if (gt.Group >= 31 || (gs & (1 << gt.Group)) == 0) continue;
            if (x != int.MinValue && !gt.S.Hits(x - 7, y - 40, x + 6, y - 2)) continue;
            string what;
            switch (gt.Name)
            {
                case "oLockedDoor": what = "the locked door"; break;
                case "oBreakableMetroidWall": what = "the Metroid block"; break;
                case "oMetroidDoorHolder": what = "the Metroid door"; break;
                case "oBreakableW_Coded": case "oBustBlock": case "oBreakableWall": what = "the breakable wall"; break;
                case "oCh18BustBlock": what = "the breakable block"; break;
                case "oBreakableExplodeWall": case "oBreakableWExp_Coded": case "oBreakRock": what = "the bombable wall"; break;
                case "oEventBarrier": what = "the barrier"; break;
                case "oMetLava": what = "the lava"; break;
                default: what = "the " + gt.Name; break;
            }
            string s = what + " at " + gt.S.X0 + "," + gt.S.Y0;
            if (!w.Contains(s)) w.Add(s);
            if (w.Count >= 3) { w.Add("..."); break; }
        }
        return string.Join(", ", w);
    }

    List<Req> GatesNeed(int gs)
    {
        var r = new List<Req> { new Req() };
        for (int g = 0; g < R.GroupNeed.Count && g < 31; g++) if ((gs & (1 << g)) != 0) r = Pareto.Product(r, R.GroupNeed[g]);
        return r;
    }

    void AddEdge(int a, int b, List<Req> ls, string how) { foreach (var l in ls) AddEdge(a, b, l, how); }
    void AddEdge(int a, int b, Req l, string how)
    {
        if (a == b) return;
        string k = a + ">" + b + ":" + l.Id;
        if (!edgeSeen.Add(k)) return;
        R.Edges.Add(new Edge { From = a, To = b, L = l, How = how });
    }
    // a move's join (its words are only made for a join that's new): from sx,sy, then (end) 0 lands at ex,ey, 1 clings to
    // the wall at ex,ey, 2 fires the Strike Chain at the point at ex,ey, 3 hits the latch crystal at ex,ey, 4 comes down on
    // the flying enemy at ex,ey
    void AddEdge(int a, int b, Req l, Prog p, int sx, int sy, int end, int ex, int ey, int gates = 0, int ptouch = 0, int pstart = 0, int pstood = 0, int pland = 0)
    {
        if (a == b) return;
        int pill = gates & R.PillarMask;
        string k = a + ">" + b + ":" + l.Id + (pill != 0 || ptouch != 0 || pstood != 0 ? ":" + pill + ":" + ptouch + ":" + pstart + ":" + pstood + ":" + pland : "")
                   + (mixedReg.Contains(a) ? ":" + sx + "," + sy : "") + (mixedReg.Contains(b) ? ":" + ex + "," + ey : "");
        if (!edgeSeen.Add(k)) return;
        string e = end == 0 ? "lands at " + ex + "," + ey : end == 1 ? "clings to the wall at " + ex + "," + ey : end == 3 ? "hits the latch crystal at " + ex + "," + ey
                   : end == 4 ? "comes down on the flying enemy at " + ex + "," + ey + " and stomps it (the Mario Ability Set)" : "fires the Strike Chain at the point at " + ex + "," + ey;
        R.Edges.Add(new Edge { From = a, To = b, L = l, How = Describe(p) + ", from " + sx + "," + sy + (gates != 0 ? ", through " + GatesWords(gates, int.MinValue, 0) : "") + "; " + e + " {move " + Spec(p) + "}", Pill = pill, PTouch = ptouch, PStart = pstart, PStood = pstood, PLand = pland, Sim = true, SX = sx, SY = sy, LX = end < 2 ? ex : int.MinValue, LY = ey });
    }
    // (in a room with falling pillars, a join where it starts and ends known: a walk between regions, turning into the
    // Morph Ball and back; pill: the pillars it goes into)
    void AddEdgeAt(int a, int b, List<Req> ls, string how, int sx, int sy, int lx, int ly, int pill = 0)
    {
        if (R.Pillars.Count == 0) { AddEdge(a, b, ls, how); return; }
        if (a == b) return;
        int us = PillarsUnder(sx, sy), ul = PillarsUnder(lx, ly);
        foreach (var l in ls)
        {
            string k = a + ">" + b + ":" + l.Id + ":" + pill + ":" + us + ":" + ul + (mixedReg.Contains(a) || mixedReg.Contains(b) ? ":" + sx + "," + sy + ":" + lx + "," + ly : "");
            if (!edgeSeen.Add(k)) continue;
            R.Edges.Add(new Edge { From = a, To = b, L = l, How = how, Pill = pill, PTouch = us | ul, PStart = us, PStood = us | ul, PLand = ul, SX = sx, SY = sy, LX = lx, LY = ly });
        }
    }
    void AddTouch(int from, int kind, int index, Req l, string how)
    {
        string k = from + ">" + kind + ":" + index + ":" + l.Id;
        if (!touchSeen.Add(k)) return;
        R.Touches.Add(new Touch { From = from, Kind = kind, Index = index, L = l, How = how });
    }
    // (in a room with falling pillars: standing at x,y touches it)
    void AddTouchAt(int from, int kind, int index, Req l, string how, int x, int y, int pill)
    {
        if (R.Pillars.Count == 0) { AddTouch(from, kind, index, l, how); return; }
        int us = PillarsUnder(x, y);
        string k = from + ">" + kind + ":" + index + ":" + l.Id + ":" + pill + ":" + us + (mixedReg.Contains(from) ? ":" + x + "," + y : "");
        if (!touchSeen.Add(k)) return;
        R.Touches.Add(new Touch { From = from, Kind = kind, Index = index, L = l, How = how, Pill = pill, PTouch = us, PStart = us, SX = x, SY = y });
    }
    void AddTouch(int from, int kind, int index, Req l, Prog p, int sx, int sy, int gates = 0, int ptouch = 0, int pstart = 0)
    {
        int pill = gates & R.PillarMask;
        string k = from + ">" + kind + ":" + index + ":" + l.Id + (pill != 0 || ptouch != 0 ? ":" + pill + ":" + ptouch + ":" + pstart : "") + (mixedReg.Contains(from) ? ":" + sx + "," + sy : "");
        if (!touchSeen.Add(k)) return;
        R.Touches.Add(new Touch { From = from, Kind = kind, Index = index, L = l, How = Describe(p) + ", from " + sx + "," + sy + (gates != 0 ? ", through " + GatesWords(gates, int.MinValue, 0) : "") + "; touches it on the way {move " + Spec(p) + "}", Pill = pill, PTouch = ptouch, PStart = pstart, Sim = true, SX = sx, SY = sy });
    }

    // a move in words: what's pressed and when, as a player would do it (a tick is a 30th of a second)
    public static string Describe(Prog p)
    {
        // (where it starts, then what's done, in order: "off the Strike Chain point: jump (held 21 ticks), holding left,
        // double jump at tick 12")
        var pre = new List<string>();
        var s = new List<string>();
        string fwd = p.Dir < 0 ? "left" : "right", back = p.Dir < 0 ? "right" : "left";
        Func<int, string> way = h => h == 0 ? "nothing" : (h > 0 ? fwd : back);
        string who = p.Ch == 0 ? "Jerry" : "Claire";
        if (p.Entering) pre.Add("coming in:");
        if (p.FromHang) pre.Add("off the Strike Chain point:");
        if (p.FromCrystal >= 0) pre.Add("just bounced off the latch crystal:");
        if (p.FromFlyer >= 0) pre.Add(p.LowBounce ? "just stomped the flying enemy, neither the jump nor up held:" : "just stomped the flying enemy, the jump or up held:");
        if (p.FromWall) pre.Add("on the wall to the " + fwd + ":");
        if (p.Morph) pre.Add("as the Morph Ball:");
        if (p.BombJump) s.Add("a bomb jump (a morph bomb under the ball)");
        if (p.DropDown) s.Add("drop down through the platform");
        if (p.Fade) s.Add("wait for the fading platform to fade, and fall through it");
        if (p.RunStart) s.Add("running " + fwd);
        if (p.GdAt >= 0) s.Add(p.Ch == 0 ? "dash " + fwd + " (Jerry)" : "dash-hop " + fwd + " (Claire)");
        if (p.FromWall && p.JumpAt >= 0) s.Add("kick off it (wall jump)");
        else if (p.JumpAt >= 0) s.Add((p.HiJump > 0 ? "jump with High Jump Boots " + p.HiJump : "jump") + " (held " + p.JumpHold + " ticks)");
        else if (!p.FromHang && !p.FromWall && !p.DropDown && !p.Fade && !p.BombJump && p.GdAt < 0 && !p.Entering && p.Cannon < 0 && p.FromCrystal < 0 && p.FromFlyer < 0) s.Add(p.Morph ? "roll off the edge" : "walk off the edge");
        if (p.WallMode == 0) s.Add("wall-jump up the same wall");
        if (p.WallMode == 1) s.Add("wall-jump between the walls");
        if (p.Cannon >= 0) s.Add("get into the travel cannon and fire it, holding " + way(p.H2) + " once it lets go");
        else if (p.Stomp) s.Add("onto a Mario enemy on the ground, holding " + way(p.H1) + " and jump, bounced off it (the Mario Ability Set), then holding " + way(p.H2));
        else if (p.AfterBounce) s.Add("onto the spring, holding " + way(p.H1) + " till it bounces, then " + way(p.H2) + (p.HDelay > 0 ? " " + p.HDelay + " ticks after" : ""));
        else if (p.WallMode < 0)
        {
            string air = p.NoInputTillAir ? " once in the air" : "";
            if (p.H1 == p.H2 || p.HDelay == 0) s.Add("holding " + way(p.H2) + (p.H2 != 0 ? air : ""));
            else s.Add("holding " + way(p.H1) + ", then " + (p.H2 == 0 ? "nothing" : way(p.H2)) + " after " + p.HDelay + " ticks" + (air != "" ? " in the air" : ""));
        }
        if (p.MorphAt >= 0) s.Add("turn into the Morph Ball at tick " + p.MorphAt);
        if (p.AutoMorph) s.Add("turn into the Morph Ball where the body meets a wall or ceiling");
        if (p.AutoUnmorph) s.Add("turn back once there's room");
        if (p.BounceAt >= 0) s.Add("bounce off a flying enemy at tick " + p.BounceAt + " (Mario Ability Set)");
        if (p.Weapon >= 0) s.Add("attack with " + Weapon.All[p.Weapon].Name + " at tick " + p.AtkAt + (p.AtkEvery > 0 ? " and every " + p.AtkEvery + " ticks after" : "") + ", bouncing off latch crystals");
        if (p.DjAt >= 0) s.Add("double jump at tick " + p.DjAt);
        if (p.AdAt >= 0) s.Add("air dash" + (p.AdDir != 0 && p.AdDir != p.Dir ? " back " + back : "") + " (" + who + ") at tick " + p.AdAt + (p.AdClear ? " or once there's room ahead" : ""));
        return (pre.Count > 0 ? string.Join(" ", pre) + " " : "") + string.Join(", ", s);
    }

    // a move as --move's fields (name=value, the ones not at their default), for a program that plays it again
    // (..\..\logictest\verify.py); the starts --move can't make (a fading platform, a travel cannon, just off a latch
    // crystal or a flying enemy, coming in) are named too, so it can tell
    public static string Spec(Prog p)
    {
        var d = new Prog();
        var f = new List<string> { "ch=" + p.Ch, "dir=" + p.Dir };
        Action<string, int, int> I = (k, v, def) => { if (v != def) f.Add(k + "=" + v); };
        Action<string, bool> B = (k, v) => { if (v) f.Add(k + "=1"); };
        B("run", p.RunStart); I("jumpAt", p.JumpAt, d.JumpAt); I("jumpHold", p.JumpHold, d.JumpHold);
        I("h1", p.H1, d.H1); I("h2", p.H2, d.H2); I("hDelay", p.HDelay, d.HDelay);
        I("djAt", p.DjAt, d.DjAt); I("djHold", p.DjHold, d.DjHold); I("adAt", p.AdAt, d.AdAt); I("adDir", p.AdDir, d.AdDir); I("gdAt", p.GdAt, d.GdAt);
        I("hiJump", p.HiJump, d.HiJump); I("maxT", p.MaxT, d.MaxT); B("noInputTillAir", p.NoInputTillAir); B("dropDown", p.DropDown);
        I("morphAt", p.MorphAt, d.MorphAt); I("weapon", p.Weapon, d.Weapon); I("atkAt", p.AtkAt, d.AtkAt); I("atkEvery", p.AtkEvery, d.AtkEvery);
        I("bounceAt", p.BounceAt, d.BounceAt); I("wallMode", p.WallMode, d.WallMode); B("fromHang", p.FromHang); B("hangDrop", p.HangDrop);
        B("afterBounce", p.AfterBounce); B("stomp", p.Stomp); B("fromWall", p.FromWall); B("autoMorph", p.AutoMorph); B("autoUnmorph", p.AutoUnmorph);
        B("bombJump", p.BombJump); B("morph", p.Morph);
        // (not --move's)
        B("fade", p.Fade); I("cannon", p.Cannon, d.Cannon); I("fromCrystal", p.FromCrystal, d.FromCrystal); I("fromFlyer", p.FromFlyer, d.FromFlyer);
        B("lowBounce", p.LowBounce); B("entering", p.Entering); B("adClear", p.AdClear);
        return string.Join(" ", f);
    }

    // the touch boxes: sJerryIdle's and sJerryJump's bounding boxes, a few pixels in (nothing counts that the player has
    // to brush with the edge of their sprite)
    static void StandBox(int x, int y, out int x0, out int y0, out int x1, out int y1) { x0 = x - 3; x1 = x + 2; y0 = y - 42; y1 = y - 7; }
    static void AirBox(int x, int y, out int x0, out int y0, out int x1, out int y1) { x0 = x - 2; x1 = x + 2; y0 = y - 36; y1 = y - 13; }

    // a landing the logic counts: with floor (or a wall) 4px to either side, not on the very edge of a ledge
    bool SafeLanding(int lx, int ly, bool morph, bool open)
    {
        var map = morph ? R.MPosRegion : R.PosRegion;
        var solid = SolidOverride ?? (open ? R.SolidO : R.SolidC);
        foreach (int s in new[] { -4, 4 })
        {
            bool ok = false;
            for (int dy = -4; dy <= 4 && !ok; dy++) if (map.ContainsKey(Shape.Key(lx + s, ly + dy))) ok = true;
            if (!ok && solid.Box(lx + s - 7, ly - (morph ? 13 : 40), lx + s + 6, ly - 2)) ok = true;
            if (!ok) return false;
        }
        return true;
    }

    List<Pos> normal, morphPs;
    // (the solids a move is made with, when not the room's own: some falling pillars fallen, PillarStates)
    Bits2D SolidOverride;
    bool morphOnly;   // the room has places only the Morph Ball fits
    List<int> normalReg, morphReg;
    Dictionary<int, int> normalGates, morphGates;
    int morphBase;

    // a map the player walks across as an icon (Zelda II's overworld, oPlayerZeldaIcon): no platforming, 16px steps up,
    // down, left or right, each one blocked when its point is in a solid (rivers, mountains). The icon touching an exit
    // (its box x-4..x+3, y-8..y+7) goes through it, so the walk doesn't go on past one. A way in reaches the exits its
    // walk gets to, and the encounters (an enemy touching the icon: the fight rooms) from anywhere
    void AnalyzeWalkMap()
    {
        R.NRegions = 0;
        int node = 0;
        var steps = new[] { new[] { 16, 0 }, new[] { -16, 0 }, new[] { 0, 16 }, new[] { 0, -16 } };
        foreach (var e in R.Entries)
        {
            long k = Shape.Key(e[0], e[1]);
            if (R.EntryNode.ContainsKey(k)) continue;
            R.EntryNode[k] = node;
            R.NodeName[node] = "coming in at " + e[0] + "," + e[1] + " (the icon on the map)";
            var seen = new HashSet<long> { k };
            var q = new Queue<int[]>();
            q.Enqueue(new[] { e[0], e[1] });
            while (q.Count > 0)
            {
                var p = q.Dequeue();
                bool onExit = false;
                for (int i = 0; i < R.Exits.Count; i++)
                {
                    var ex = R.Exits[i];
                    if (ex.Obj == "encounter" || ex.Obj == "menu" || !ex.S.Hits(p[0] - 4, p[1] - 8, p[0] + 3, p[1] + 7)) continue;
                    onExit = true;
                    AddTouch(node, 1, i, new Req(), "walk the icon from " + e[0] + "," + e[1] + " to " + p[0] + "," + p[1] + ", onto the exit");
                }
                // (the icon going onto an exit goes through it: no further from there, but from where it came in)
                if (onExit && (p[0] != e[0] || p[1] != e[1])) continue;
                foreach (var st in steps)
                {
                    int nx = p[0] + st[0], ny = p[1] + st[1];
                    if (nx < 0 || ny < 0 || nx >= R.Data.W || ny >= R.Data.H || R.SolidC.Get(nx, ny)) continue;
                    if (seen.Add(Shape.Key(nx, ny))) q.Enqueue(new[] { nx, ny });
                }
            }
            for (int i = 0; i < R.Exits.Count; i++)
                if (R.Exits[i].Obj == "encounter") AddTouch(node, 1, i, new Req(), "wait on the map for an encounter enemy (on grass, desert or forest; walking onto a road with one following for the road's fight)");
            node++;
        }
        R.NNodes = node;
    }

    public void Analyze()
    {
        Build();
        var d = R.Data;
        if (d.WalkMap) { AnalyzeWalkMap(); return; }
        int nN, nM;
        normal = Standable(40);
        normalReg = MakeRegions(normal, R.PosRegion, 0, out nN, out normalGates);
        morphBase = nN;
        bool anyMorph = true;
        morphPs = anyMorph ? Standable(13) : new List<Pos>();
        morphReg = MakeRegions(morphPs, R.MPosRegion, morphBase, out nM, out morphGates);
        R.NRegions = nN + nM;
        NameRegions(normal, normalReg, "standing");
        NameRegions(morphPs, morphReg, "as the Morph Ball");
        morphOnly = morphPs.Any(p => !R.PosRegion.ContainsKey(Shape.Key(p.X, p.Y)));
        // (falling pillars: the regions partly on one's top)
        if (R.Pillars.Count > 0)
            foreach (var map in new[] { R.PosRegion, R.MPosRegion })
            {
                var onP = new HashSet<int>(); var offP = new HashSet<int>();
                foreach (var kv in map)
                {
                    int px = (int)(kv.Key >> 32), py = (int)(uint)kv.Key, u = PillarsUnder(px, py);
                    if (u != 0) onP.Add(kv.Value);
                    if (u == 0 || OffPillar(px, py)) offP.Add(kv.Value);
                }
                foreach (int r in onP) if (offP.Contains(r)) mixedReg.Add(r);
            }
        // normal <-> morph: morphing needs the Morph Ball (Samus 2); unmorphing needs room for the body
        var samus2 = new Req().With(Req.SAMUS, 2);
        var linked = new HashSet<long>();
        for (int i = 0; i < morphPs.Count; i++)
        {
            int nr;
            if (!R.PosRegion.TryGetValue(Shape.Key(morphPs[i].X, morphPs[i].Y), out nr)) continue;
            int mr = morphReg[i];
            //if (!linked.Add(((long)nr << 32) | (uint)mr)) continue;
            // (with falling pillars: one for each pillar top, and, in a region partly on one, every 16px)
            long lk = ((long)nr << 32) | (uint)mr;
            if (R.Pillars.Count > 0) lk = lk * 31 + PillarsUnder(morphPs[i].X, morphPs[i].Y) * 7919L + (mixedReg.Contains(nr) || mixedReg.Contains(mr) ? (morphPs[i].X / 16) * 104729L + morphPs[i].Y : 0);
            if (!linked.Add(lk)) continue;
            //AddEdge(nr, mr, samus2, "turn into the Morph Ball at " + morphPs[i].X + "," + morphPs[i].Y);
            //AddEdge(mr, nr, new Req(), "turn back from the Morph Ball at " + morphPs[i].X + "," + morphPs[i].Y);
            int mx = morphPs[i].X, my = morphPs[i].Y;
            //AddEdgeAt(nr, mr, new List<Req> { samus2 }, "turn into the Morph Ball at " + mx + "," + my, mx, my, mx, my);
            //AddEdgeAt(mr, nr, new List<Req> { new Req() }, "turn back from the Morph Ball at " + mx + "," + my, mx, my, mx, my);
            // (into a gate's place, as walking into one: the standing body in a gate the ball isn't in (a bomb block over
            // a tunnel), or the ball in one the body isn't, takes the gate open)
            int ng, mg;
            normalGates.TryGetValue(nr, out ng); morphGates.TryGetValue(mr, out mg);
            int toBall = mg & ~ng, toBody = ng & ~mg;
            AddEdgeAt(nr, mr, Pareto.Product(new List<Req> { samus2 }, GatesNeed(toBall)), "turn into the Morph Ball at " + mx + "," + my
                      + (toBall != 0 ? " into " + GatesWords(toBall, mx, my) : ""), mx, my, mx, my, mg & R.PillarMask);
            AddEdgeAt(mr, nr, GatesNeed(toBody), "turn back from the Morph Ball at " + mx + "," + my
                      + (toBody != 0 ? " into " + GatesWords(toBody, mx, my) : ""), mx, my, mx, my, ng & R.PillarMask);
        }
        // what each standing place touches (locations, exits)
        TouchesFromStanding(normal, normalReg, 40);
        TouchesFromStanding(morphPs, morphReg, 13);
        // entries: where the player comes in (from other rooms' exits and this room's doors)
        int node = R.NRegions;
        foreach (var e in R.Entries)
        {
            long k = Shape.Key(e[0], e[1]);
            if (R.EntryNode.ContainsKey(k)) continue;
            R.EntryNode[k] = node;
            R.NodeName[node] = "coming in at " + e[0] + "," + e[1];
            EntrySims(node, e[0], e[1]);
            node++;
        }
        // a party split room: the player can swap to the idle partner, where it starts (which can hang on where the player
        // came in: oPlayerIdle's xThres). Swapping freezes the one left where it is, in the air too: it can hold a switch
        // it was jumping over (the switch spots count any touch on the way)
        var partnerNode = new Dictionary<long, int>();
        foreach (var pp in R.Data.Partner)
            foreach (var kv in R.EntryNode)
            {
                int ex = (int)(kv.Key >> 32);
                bool moved = pp[5] == 1 ? ex < pp[2] : ex > pp[2];
                int px = moved ? pp[3] : pp[0], py = moved ? pp[4] : pp[1];
                long pk = Shape.Key(px, py);
                int pn;
                if (!partnerNode.TryGetValue(pk, out pn))
                {
                    pn = node++; partnerNode[pk] = pn;
                    R.NodeName[pn] = "as the partner (party split), where it starts: " + px + "," + py;
                    EntrySims(pn, px, py);
                }
                AddEdge(kv.Value, pn, new Req(), "swap to the partner (party split), at " + px + "," + py);
            }
        R.NNodes = node;
        // a moving platform joins every place along its path: on it anywhere, off it anywhere
        if (R.Movers > 0)
        {
            var hub = new Dictionary<int, int>();
            var linkedM = new HashSet<long>();
            for (int i = 0; i < normal.Count; i++)
            {
                var p = normal[i];
                if (!R.GhostB.Row(p.Y - 1, p.X - 7, p.X + 6) || R.SolidC.Row(p.Y - 1, p.X - 7, p.X + 6)) continue;
                for (int cx = p.X - 7; cx <= p.X + 6; cx++)
                {
                    int g;
                    if (!R.Ghost.TryGetValue(Shape.Key(cx, p.Y - 1), out g)) continue;
                    int h;
                    if (!hub.TryGetValue(g, out h)) { h = R.NNodes++; hub[g] = h; R.NodeName[h] = "riding moving platform " + (g + 1) + " (waiting for it where it goes)"; }
                    if (!linkedM.Add(((long)normalReg[i] << 32) | (uint)h)) continue;
                    AddEdge(normalReg[i], h, new Req(), "step onto moving platform " + (g + 1) + " at " + p.X + "," + p.Y);
                    AddEdge(h, normalReg[i], new Req(), "ride moving platform " + (g + 1) + " and step off at " + p.X + "," + p.Y);
                }
            }
        }
        // Strike Chain points: reached from standing places (and from moves, see Run); from one, the next in reach, and
        // the moves off it
        if (R.Points.Count > 0)
        {
            var mm4 = new Req().With(Req.MEGAMAN, 4);
            R.HangNode = new int[R.Points.Count];
            for (int k = 0; k < R.Points.Count; k++) { R.HangNode[k] = R.NNodes++; R.NodeName[R.HangNode[k]] = "hanging from the Strike Chain point at " + R.Points[k][0] + "," + R.Points[k][1]; }
            var seenH = new HashSet<long>();
            for (int i = 0; i < normal.Count; i++)
            {
                var p = normal[i];
                bool near = false;
                foreach (var pt in R.Points) if (Math.Abs(pt[0] - p.X) <= 94 && Math.Abs(pt[1] - (p.Y - 32)) <= 14) { near = true; break; }
                if (!near) continue;
                foreach (int k in ChainReach(p.X, p.Y))
                    if (seenH.Add(((long)normalReg[i] << 32) | (uint)k))
                        AddEdge(normalReg[i], R.HangNode[k], mm4, "standing at " + p.X + "," + p.Y + ", fire the Strike Chain at the point at " + R.Points[k][0] + "," + R.Points[k][1]);
            }
            for (int k = 0; k < R.Points.Count; k++)
            {
                int hx = R.Points[k][0], hy = R.Points[k][1] + 40;
                foreach (int j in ChainReach(hx, hy))
                    if (j != k) AddEdge(R.HangNode[k], R.HangNode[j], mm4, "hanging there, fire the Strike Chain at the point at " + R.Points[j][0] + "," + R.Points[j][1]);
                foreach (var prog in HangPrograms())
                {
                    var res = Run(prog, hx, hy, false, false, true, false);
                    R.Sims++;
                    Record(R.HangNode[k], prog, res, false, hx, hy);
                }
            }
        }
        // latch crystals: a hit in the air bounces the player and gives the double jump and air dash back, so a way goes on
        // from there (a node for each crystal, hit from either side by either character: Result.Bounces), as from a
        // Strike Chain point: to the next crystal, a ledge, a place
        if (R.Crystals.Count > 0)
        {
            R.CrystalNode = new int[R.Crystals.Count * 4];
            for (int k = 0; k < R.CrystalNode.Length; k++)
            {
                var c = R.Crystals[k / 4];
                R.CrystalNode[k] = R.NNodes++;
                R.NodeName[R.CrystalNode[k]] = "just bounced off the latch crystal at " + ((c.X0 + c.X1) / 2) + "," + ((c.Y0 + c.Y1) / 2) + " from its "
                    + ((k / 2) % 2 == 1 ? "left" : "right") + " (" + (k % 2 == 0 ? "Jerry" : "Claire") + ")";
            }
            for (int k = 0; k < R.CrystalNode.Length; k++)
            {
                // (where a hit leaves the player isn't one place: the crystal at the body's middle or 8px higher up it,
                // and a move off it counts only for what it does from both, as a move at every frame rate does: Both)
                int bx, by, lx, ly;
                if (!CrystalStart(k, 20, out bx, out by)) continue;
                bool low = CrystalStart(k, 28, out lx, out ly);
                foreach (var prog in CrystalPrograms(k))
                {
                    var res = Run(prog, bx, by, false, false, true, false);
                    R.Sims++;
                    if (low)
                    {
                        var r2 = Run(prog, lx, ly, false, false, true, false);
                        R.Sims++;
                        Both(res, r2);
                        if (r2.Pogos == 0) res.Pogos = 0;
                    }
                    if (prog.Weapon >= 0 && res.Pogos == 0) continue;
                    Record(R.CrystalNode[k], prog, res, false, bx, by);
                }
            }
        }
        // flying enemies, each where it starts (R.Flyers): one stomped with the Mario Ability Set bounces the player up and
        // gives the double jump and air dash back, so a way goes on from there (a node for each, by character:
        // Result.Stomps), as from a latch crystal: to the next one, a ledge, a place
        if (R.Flyers.Count > 0)
        {
            R.FlyerNode = new int[R.Flyers.Count * 2];
            for (int k = 0; k < R.FlyerNode.Length; k++)
            {
                var fl = R.Flyers[k / 2];
                R.FlyerNode[k] = R.NNodes++;
                R.NodeName[R.FlyerNode[k]] = "just stomped the " + R.FlyerNames[k / 2] + " at " + ((fl.X0 + fl.X1) / 2) + "," + fl.Y0 + " (" + (k % 2 == 0 ? "Jerry" : "Claire") + ")";
            }
            for (int k = 0; k < R.FlyerNode.Length; k++)
            {
                // (where the stomp leaves the player isn't one place: the feet at its top or 8px into it, as a fall's
                // tick brings them, and a move off it counts only for what it does from both: Both)
                int bx, by, lx, ly;
                if (!FlyerStart(k, 1, out bx, out by)) continue;
                bool low = FlyerStart(k, 9, out lx, out ly);
                foreach (var prog in FlyerPrograms(k))
                {
                    var res = Run(prog, bx, by, false, false, true, false);
                    R.Sims++;
                    if (low)
                    {
                        var r2 = Run(prog, lx, ly, false, false, true, false);
                        R.Sims++;
                        Both(res, r2);
                    }
                    Record(R.FlyerNode[k], prog, res, false, bx, by);
                }
            }
        }
        // moves from each region
        if (R.GroundFoes.Count > 0 && R.Stompers.Count == 0) MakeStompers();
        Launches(normal, normalReg, false);
        Launches(morphPs, morphReg, true);
        Elevators();
        RockMoves();
        GapSearch();
        FlyerSearch();
        if (R.Pillars.Count > 0 && !NoPillarStates) PillarStates();
    }
    public static bool NoPillarStates;   // (--draw: the regions alone)

    // falling pillars (oPlatform_CVFall): which have fallen is the room's state as the player goes. One stood on shakes
    // and falls 25 ticks later, its column with it (its Step); on its top the player goes down with it (gameStepEvent: a
    // viscid top carries them down, till a floor under the feet stops them), and can step or jump off on the way. The
    // room's moves are made with them all standing (with the gates open, they're gone), each with its pillars (Edge):
    // the ones it starts on, stands on, lands on, touches and goes through. A node here is a region with a set of
    // pillars fallen (a region partly on one's top splits where it's fallen: each part a node of its own), and the ones
    // the player's just landed on, shaking under them (from there only the moves off its top, or riding it down). A move
    // goes from a node if it touches none of the fallen pillars and goes only through fallen ones or the one it starts
    // on (down with it); the ones it stood on and left have fallen after it. A region's moves with some of the pillars
    // its moves touch fallen are made again with those gone (and, near the room's other gates, with them open and the
    // pillars standing), once for each set of them
    void PillarStates()
    {
        int N = R.NNodes;
        foreach (var e in R.Edges) N = Math.Max(N, Math.Max(e.From, e.To) + 1);
        foreach (var t in R.Touches) N = Math.Max(N, t.From + 1);
        // (each region's places, and the pillars whose tops they stand on: pure, every place on a pillar's top alone)
        var topOf = new int[N]; var pure = new bool[N]; var off = new bool[N];
        var places = new Dictionary<int, List<int[]>>();
        foreach (var map in new[] { R.PosRegion, R.MPosRegion })
            foreach (var kv in map)
            {
                int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key, r = kv.Value;
                if (r < 0 || r >= N) continue;
                List<int[]> pl0;
                if (!places.TryGetValue(r, out pl0)) { pl0 = new List<int[]>(); places[r] = pl0; }
                pl0.Add(new[] { x, y, map == R.MPosRegion ? 1 : 0 });
                int on = PillarsUnder(x, y);
                topOf[r] |= on;
                if (on == 0 || OffPillar(x, y)) off[r] = true;
            }
        for (int r = 0; r < N; r++) pure[r] = topOf[r] != 0 && !off[r];
        var regGates = new Dictionary<int, int>();
        foreach (var kv in normalGates) regGates[kv.Key] = kv.Value;
        foreach (var kv in morphGates) regGates[kv.Key] = kv.Value;
        var adj = new List<Edge>[N]; var tat = new List<Touch>[N];
        for (int i = 0; i < N; i++) { adj[i] = new List<Edge>(); tat[i] = new List<Touch>(); }
        foreach (var e in R.Edges) if (e.From < N && e.To < N) adj[e.From].Add(e);
        foreach (var t in R.Touches) if (t.From < N) tat[t.From].Add(t);
        // (the pillars each region's moves touch or go through with them all standing, and its own: its moves change
        // with those; and whether one of the room's other gates is near it)
        var near = new int[N];
        for (int r = 0; r < N; r++) { int v; near[r] = topOf[r] | (runPills.TryGetValue(r, out v) ? v : 0); }
        foreach (var e in R.Edges) if (e.From < N) near[e.From] |= e.PTouch | e.Pill;
        foreach (var t in R.Touches) if (t.From < N) near[t.From] |= t.PTouch | t.Pill;
        var others = R.Gates.Where(g => (R.PillarMask & (1 << g.Group)) == 0).ToList();
        var gateNear = new bool[N];
        foreach (var kv in places)
        {
            var q0 = kv.Value;
            int x0 = q0.Min(q => q[0]) - 400, x1 = q0.Max(q => q[0]) + 400, y0 = q0.Min(q => q[1]) - 300, y1 = q0.Max(q => q[1]) + 300;
            gateNear[kv.Key] = others.Any(g => g.S.Hits(x0, y0, x1, y1));
        }
        // (a region partly on pillars' tops with some of them fallen (mf): its places' parts, joined by walking as in
        // MakeRegions, -1 for a place gone with its pillar; and how many parts)
        var parts = new Dictionary<long, int[]>();
        var partCount = new Dictionary<long, int>();
        var placeIx = new Dictionary<int, Dictionary<long, int>>();
        Func<int, Dictionary<long, int>> ixOf = n =>
        {
            Dictionary<long, int> ix;
            if (placeIx.TryGetValue(n, out ix)) return ix;
            ix = new Dictionary<long, int>();
            var ps = places[n];
            for (int i = 0; i < ps.Count; i++) ix[Shape.Key(ps[i][0], ps[i][1])] = i;
            placeIx[n] = ix;
            return ix;
        };
        Func<int, int, int[]> partsOf = (n, mf) =>
        {
            long k = ((long)mf << 32) | (uint)n;
            int[] pc;
            if (parts.TryGetValue(k, out pc)) return pc;
            var ps = places[n];
            var ix = ixOf(n);
            var par = new int[ps.Count];
            var gone = new bool[ps.Count];
            for (int i = 0; i < ps.Count; i++) { par[i] = i; gone[i] = (PillarsUnder(ps[i][0], ps[i][1]) & mf) != 0 && !OffPillar(ps[i][0], ps[i][1]); }
            Func<int, int> find = a => { while (par[a] != a) { par[a] = par[par[a]]; a = par[a]; } return a; };
            for (int i = 0; i < ps.Count; i++)
            {
                if (gone[i]) continue;
                for (int dy = -4; dy <= 4; dy++)
                {
                    int j;
                    if (!ix.TryGetValue(Shape.Key(ps[i][0] + 1, ps[i][1] + dy), out j) || gone[j]) continue;
                    int a = find(i), b = find(j);
                    if (a != b) par[a] = b;
                }
            }
            pc = new int[ps.Count];
            var num = new Dictionary<int, int>();
            for (int i = 0; i < ps.Count; i++)
            {
                if (gone[i]) { pc[i] = -1; continue; }
                int r = find(i), c;
                if (!num.TryGetValue(r, out c)) { c = num.Count; num[r] = c; }
                pc[i] = c;
            }
            parts[k] = pc;
            partCount[k] = num.Count;
            return pc;
        };
        // (the part of region n a place is in, with the pillars of m fallen: 0 where it's whole, -1 if the place has gone
        // with its pillar, or isn't known (x int.MinValue) and the region's in parts)
        Func<int, int, int, int, int> partOf = (n, m, x, y) =>
        {
            if (n < 0 || n >= N || pure[n] || !places.ContainsKey(n)) return 0;
            int mf = m & topOf[n];
            if (mf == 0) return 0;
            var pc = partsOf(n, mf);
            if (x == int.MinValue) return partCount[((long)mf << 32) | (uint)n] == 1 ? 0 : -1;
            var ix = ixOf(n);
            for (int dy = 0; dy <= 3; dy++)
                foreach (int sy in new[] { y - dy, y + dy })
                    for (int dx = 0; dx <= 2; dx++)
                        foreach (int sx in new[] { x - dx, x + dx })
                        {
                            int i;
                            if (ix.TryGetValue(Shape.Key(sx, sy), out i)) return pc[i];
                        }
            return -1;
        };
        // (node: region n with the pillars of m fallen, the ones of t shaking under the player (in a region partly on
        // them), its part c; n itself with none fallen or shaking)
        var id = new Dictionary<string, int>();
        var todo = new Queue<int[]>();
        int next = N;
        Func<int, int, int, int, int> nodeOf = (n, m, t, c) =>
        {
            t &= ~m;
            if (pure[n] || topOf[n] == 0) t = 0; else t &= topOf[n];
            if (m == 0 && t == 0) return n;
            string k = n + ":" + m + ":" + t + ":" + c;
            int v;
            if (!id.TryGetValue(k, out v)) { v = next++; id[k] = v; todo.Enqueue(new[] { n, m, t, c, v }); }
            return v;
        };
        var edges = new List<Edge>(); var touches = new List<Touch>();
        var eSeen = new HashSet<string>(); var tSeen = new HashSet<string>();
        Action<Edge> addE = e => { if (e.From != e.To && eSeen.Add(e.From + ">" + e.To + ":" + e.L.Id)) edges.Add(e); };
        Action<Touch> addT = t => { if (tSeen.Add(t.From + ">" + t.Kind + ":" + t.Index + ":" + t.L.Id)) touches.Add(t); };
        // (the solids with the pillars of m fallen: shut, the room's gates too; open, its other gates open)
        var solids = new Dictionary<int, Bits2D[]>();
        Func<int, Bits2D[]> solidsOf = m =>
        {
            Bits2D[] sb;
            if (solids.TryGetValue(m, out sb)) return sb;
            var c = R.SolidC.Copy(); var o = R.SolidO.Copy();
            foreach (var pl in R.Pillars)
                foreach (var k in pl.Top.Px.Concat(pl.Col.Px))
                {
                    int x = (int)(k >> 32), y = (int)(uint)k;
                    if ((m & (1 << pl.Group)) != 0) c.Clear(x, y); else o.Set(x, y);
                }
            sb = new[] { c, o };
            solids[m] = sb;
            return sb;
        };
        // a move from node at to region to (lx,ly: where it lands, int.MinValue if not known), with the pillars of m
        // fallen after it, landing on the ones of land (shaking under the player)
        Action<int, int, int, int, int, int, Req, string> go = (at, to, m, land, lx, ly, l, how) =>
        {
            if (to < 0 || to >= N) return;
            land &= ~m;
            int rg;
            if (regGates.TryGetValue(to, out rg) && (rg & R.PillarMask & ~m) != 0) return;
            if (pure[to] && (topOf[to] & m) != 0) return;
            int c = partOf(to, m, lx, ly);
            if (c < 0) return;
            addE(new Edge { From = at, To = nodeOf(to, m, land, c), L = l, How = how });
        };
        Action<int, PillarOut, int> apply = (at, o, m) =>
        {
            if (o.Kind == 2) { addT(new Touch { From = at, Kind = o.TKind, Index = o.Index, L = o.L, How = o.How }); return; }
            go(at, o.To, m | (o.PStood & ~o.PLand), o.PLand, o.LX, o.LY, o.L, o.How);
        };
        // (the moves from some of a region's places with the pillars of mf gone, made once for each: as Record's. ride:
        // from the pillar pl's top as it falls with the player on it, carried down to the floor under it or stepping or
        // jumping off on the way (every 32px down); with none gone, mf 0: with the room's other gates open alone)
        var made = new Dictionary<string, List<PillarOut>>();
        int remade = 0, rides = 0;
        Func<int, int, Pillar, List<int[]>, List<PillarOut>> Outcomes = (n, mf, pl, ps) =>
        {
            string key = n + ":" + mf + (pl != null ? ":r" + pl.Group : "");
            List<PillarOut> outs;
            if (made.TryGetValue(key, out outs)) return outs;
            outs = new List<PillarOut>();
            made[key] = outs;
            if (pl != null) rides++; else remade++;
            var sb = solidsOf(mf);
            bool morph = ps[0][2] == 1;
            int top = morph ? 13 : 40;
            Action<Prog, int, int, bool, Bits2D, string> run = (prog, x, y, open, geo, pre) =>
            {
                SolidOverride = geo;
                var res = Run(prog, x, y, open, morph, false, false);
                R.Sims++;
                int gates = open ? res.Gates & ~R.PillarMask : 0;
                bool skip = ((prog.AutoMorph || prog.AutoUnmorph) && !res.Morphed) || (prog.Weapon >= 0 && res.Pogos == 0) || (open && gates == 0);
                bool landOk = !skip && res.LandX != int.MinValue && SafeLanding(res.LandX, res.LandY, res.Morph, open);
                SolidOverride = null;
                if (skip) return;
                int pstart = pl != null ? 0 : PillarsUnder(x, y) & ~mf;
                int pstood = (res.PillStood | pstart) & ~mf, ptouch = res.PillTouch & ~mf;
                var need = Pareto.Product(new List<Req> { prog.Label }, GatesNeed(gates));
                string how = pre + Describe(prog) + ", from " + x + "," + y + (gates != 0 ? ", through " + GatesWords(gates, int.MinValue, 0) : "") + " {move " + Spec(prog) + "}";
                foreach (var l in need)
                {
                    foreach (int k in res.Locs) outs.Add(new PillarOut { Kind = 2, TKind = 0, Index = k, L = l, How = how + "; touches it on the way", SX = x, SY = y, PStart = pstart, PTouch = ptouch });
                    foreach (int k in res.Exits) outs.Add(new PillarOut { Kind = 2, TKind = 1, Index = k, L = l, How = how + "; touches it on the way", SX = x, SY = y, PStart = pstart, PTouch = ptouch });
                    foreach (int k in res.Spots) outs.Add(new PillarOut { Kind = 2, TKind = 2, Index = k, L = l, How = how + "; touches it on the way", SX = x, SY = y, PStart = pstart, PTouch = ptouch });
                    foreach (long ck in res.Clings)
                        outs.Add(new PillarOut { Kind = 1, To = R.PosRegion[ck], L = l, How = how + "; clings to the wall at " + (int)(ck >> 32) + "," + (int)(uint)ck, SX = x, SY = y, LX = (int)(ck >> 32), LY = (int)(uint)ck, PStart = pstart, PStood = pstood, PTouch = ptouch });
                    if (landOk)
                    {
                        int to = RegionAt(res.LandX, res.LandY, res.Morph);
                        if (to >= 0) outs.Add(new PillarOut { Kind = 0, To = to, L = l, How = how + "; lands at " + res.LandX + "," + res.LandY, SX = x, SY = y, LX = res.LandX, LY = res.LandY, PStart = pstart, PStood = pstood, PLand = PillarsUnder(res.LandX, res.LandY) & ~mf, PTouch = ptouch });
                    }
                }
            };
            Func<int, int, List<int[]>, bool> runAt = (x, y, row) =>
            {
                bool runL = row.Any(o => o[0] == x + 24), runR = row.Any(o => o[0] == x - 24);
                bool onPlat = !morph && (R.Plat.Row(y - 1, x - 7, x + 6) || R.GhostB.Row(y - 1, x - 7, x + 6)) && !sb[0].Row(y - 1, x - 7, x + 6);
                bool nearSpring = !morph && R.Springs.Any(sp => x + 2 >= sp.S.X0 && x - 2 <= sp.S.X1 && Math.Abs(sp.S.Y1 + 1 - y) <= 8);
                bool onFade = R.Fades.Count > 0 && R.Fades.Any(f => f.Hits(x - 7, y - 1, x + 6, y - 1));
                bool nearCrystal = !morph && R.Crystals.Any(c => Math.Abs((c.X0 + c.X1) / 2 - x) <= 240 && Math.Abs((c.Y0 + c.Y1) / 2 - y) <= 240);
                foreach (bool open in new[] { false, true })
                {
                    if (open ? !(others.Count > 0 && gateNear[n]) : mf == 0) continue;
                    var geo = open ? sb[1] : sb[0];
                    if (!Clear(geo, x, y, top) || !Floor(geo, x, y, top) || HazardAt(x, y, top, open)) continue;
                    foreach (var prog in Programs(morph, onPlat, runL, runR, nearSpring, onFade, nearCrystal)) run(prog, x, y, open, geo, "");
                }
                return true;
            };
            if (pl == null)
            {
                // from its places as Launches picks them: every 16px, and every 4px near each run of them's ends
                foreach (var row in ps.GroupBy(q => q[1]))
                {
                    var xs = row.Select(q => q[0]).OrderBy(v => v).ToList();
                    var rowL = row.ToList();
                    int a = 0;
                    for (int i = 1; i <= xs.Count; i++)
                    {
                        if (i < xs.Count && xs[i] == xs[i - 1] + 1) continue;
                        int minx = xs[a], maxx = xs[i - 1];
                        for (int j = a; j < i; j++)
                        {
                            int x = xs[j];
                            bool end = x - minx <= 8 || maxx - x <= 8;
                            if (x % 16 == 0 || (end && (x - minx) % 4 == 0) || (end && (maxx - x) % 4 == 0)) runAt(x, row.Key, rowL);
                        }
                        a = i;
                    }
                }
                return outs;
            }
            // riding it: from its top's ends and middle (the places on it alone: on a floor too, the player stays there;
            // the ones with the feet wholly on it, where there are such)
            var onIt = ps.Where(q => !OffPillar(q[0], q[1])).Select(q => q[0]).OrderBy(v => v).ToList();
            var whole = onIt.Where(v => v - 7 >= pl.Top.X0 && v + 6 <= pl.Top.X1).ToList();
            if (whole.Count > 0) onIt = whole;
            if (onIt.Count == 0) return outs;
            int ty = ps[0][1];
            foreach (int x in new[] { onIt[0], onIt[onIt.Count / 2], onIt[onIt.Count - 1] }.Distinct())
            {
                string at0 = "stay on the falling pillar at " + pl.Top.X0 + "," + pl.Top.Y0 + " as it falls";
                for (int d = 1, dd = 32; ty + d < R.Data.H + 40; d++)
                {
                    // (carried down till the feet meet a floor: the body clear of walls, and no hazard on the way)
                    if (!Clear(sb[0], x, ty + d, top) || HazardAt(x, ty + d, top)) break;
                    if (Floor(sb[0], x, ty + d, top))
                    {
                        int to = RegionAt(x, ty + d, morph);
                        if (to >= 0) outs.Add(new PillarOut { Kind = 0, To = to, L = new Req(), How = at0 + ", from " + x + "," + ty + ", carried down to " + x + "," + (ty + d), SX = x, SY = ty, LX = x, LY = ty + d, PLand = PillarsUnder(x, ty + d) & ~mf });
                        break;
                    }
                    if (d < dd) continue;
                    // (dd px down: off it there, with it as a solid where it's got to)
                    var geo = sb[0].Copy();
                    foreach (var k in pl.Top.Px.Concat(pl.Col.Px)) geo.Set((int)(k >> 32), (int)(uint)k + dd);
                    var row = onIt.Select(v => new[] { v, ty + dd }).ToList();
                    bool runL = row.Any(o => o[0] == x + 24), runR = row.Any(o => o[0] == x - 24);
                    foreach (var prog in Programs(morph, false, runL, runR)) run(prog, x, ty + dd, false, geo, at0 + ", carried down " + dd + "px, then ");
                    dd += 32;
                }
            }
            return outs;
        };
        Action<int[]> expand = q =>
        {
            int n = q[0], m = q[1], t = q[2], c = q[3], at = q[4];
            bool split = (m & topOf[n]) != 0 && !pure[n] && places.ContainsKey(n);
            // the moves made with them all standing that touch none of the fallen ones, from this part (from a pillar
            // shaking under the player: from its top)
            foreach (var e in adj[n])
            {
                if (t != 0 && (e.PStart & t) == 0) continue;
                if ((e.PTouch & m) != 0 || (e.Pill & ~(m | e.PStart)) != 0) continue;
                if (split && partOf(n, m, e.SX, e.SY) != c) continue;
                go(at, e.To, m | e.Pill | (e.PStood & ~e.PLand), e.PLand, e.LX, e.LY, e.L, e.How);
            }
            foreach (var tc in tat[n])
            {
                if (t != 0 && (tc.PStart & t) == 0) continue;
                if ((tc.PTouch & m) != 0 || (tc.Pill & ~(m | tc.PStart)) != 0) continue;
                if (split && partOf(n, m, tc.SX, tc.SY) != c) continue;
                addT(new Touch { From = at, Kind = tc.Kind, Index = tc.Index, L = tc.L, How = tc.How });
            }
            List<int[]> ps;
            if (!places.TryGetValue(n, out ps)) return;
            int free = topOf[n] & ~m;
            if (t != 0) free &= t;
            foreach (var pl in R.Pillars)
            {
                int b = 1 << pl.Group;
                if ((free & b) == 0) continue;
                // (its top's places, in this part)
                var onTop = ps.Where(p => (PillarsUnder(p[0], p[1]) & b) != 0 && (!split || partOf(n, m, p[0], p[1]) == c)).ToList();
                if (onTop.Count == 0) continue;
                // onto it and off it onto the rest of the region (a region partly on it): it falls behind the player
                if (!pure[n])
                {
                    var pc2 = partsOf(n, (m | b) & topOf[n]);
                    var seenC = new HashSet<int>();
                    for (int i = 0; i < ps.Count; i++)
                    {
                        if (pc2[i] < 0 || seenC.Contains(pc2[i]) || (split && partOf(n, m, ps[i][0], ps[i][1]) != c)) continue;
                        seenC.Add(pc2[i]);
                        addE(new Edge { From = at, To = nodeOf(n, m | b, 0, pc2[i]), L = new Req(), How = (t != 0 ? "off the falling pillar at " : "onto the falling pillar at ") + pl.Top.X0 + "," + pl.Top.Y0 + (t != 0 ? "" : " and off it") + ", to " + ps[i][0] + "," + ps[i][1] + ": it falls" });
                    }
                }
                // riding it down
                foreach (var o in Outcomes(n, (m | b) & near[n], pl, onTop))
                    if ((o.PTouch & m) == 0) apply(at, o, m | b);
            }
            // its moves with fallen pillars its moves touch made again with them gone (with none, near the room's other
            // gates: with them open and the pillars standing)
            int mn = m & near[n];
            if (mn != 0 || (others.Count > 0 && gateNear[n] && near[n] != 0))
                foreach (var o in Outcomes(n, mn, null, ps))
                {
                    if (t != 0 && (o.PStart & t) == 0) continue;
                    if ((o.PTouch & m) != 0) continue;
                    if (split && partOf(n, m, o.SX, o.SY) != c) continue;
                    apply(at, o, m);
                }
        };
        for (int n = 0; n < N; n++) expand(new[] { n, 0, 0, 0, n });
        int shaking = 0, inParts = 0;
        while (todo.Count > 0)
        {
            var q = todo.Dequeue();
            int n = q[0], m = q[1], t = q[2], c = q[3];
            string nm;
            int mf = m & topOf[n], pcn;
            bool many = mf != 0 && !pure[n] && places.ContainsKey(n) && partsOf(n, mf) != null && partCount.TryGetValue(((long)mf << 32) | (uint)n, out pcn) && pcn > 1;
            if (t != 0) shaking++;
            if (many) inParts++;
            var w = new List<string>();
            if (m != 0) w.Add(PillarWords(m));
            if (t != 0) w.Add("on " + PillarWords(t).Replace(" fallen", "") + ", shaking");
            R.NodeName[q[4]] = "[" + string.Join("; ", w) + "] " + (R.NodeName.TryGetValue(n, out nm) ? nm : "node " + n) + (many ? " (part " + (c + 1) + ")" : "");
            expand(q);
        }
        R.Edges.Clear(); R.Edges.AddRange(edges);
        R.Touches.Clear(); R.Touches.AddRange(touches);
        R.NNodes = next;
        var sets = new HashSet<int>(id.Keys.Select(k => int.Parse(k.Split(':')[1])));
        R.Log.Add("falling pillars: " + R.Pillars.Count + ", " + id.Count + " nodes with some fallen (" + sets.Count + " sets of them) or shaking (" + shaking + "), " + inParts + " in parts; moves made again for " + remade + " sets and " + rides + " rides");
    }

    // the falling pillars of a set, in words
    string PillarWords(int m)
    {
        var w = R.Pillars.Where(pl => (m & (1 << pl.Group)) != 0).Select(pl => pl.Top.X0 + "," + pl.Top.Y0).ToList();
        return (w.Count == 1 ? "the falling pillar at " : "the falling pillars at ") + string.Join(", ", w) + " fallen";
    }

    // the timings the moves above don't try, where they might matter: from each region to each one near it (up to 200px
    // above it or 100px below, 360px across) it can't get to with nothing yet, every combination of how long the jump is
    // held, when the double jump and the air dash come and when to steer, from its two places nearest the other, trying
    // only moves that need less than what gets there already (a move there with the Strike Chain doesn't stop the search
    // for one with the double jump); and the same to the places (Randomizer locations) near each region, a move counting
    // where it touches one. A move found counts if it lands there (touches it) with all its timings a tick earlier or
    // later too (nothing frame-perfect)
    void GapSearch()
    {
        var byReg = new Dictionary<int, List<Pos>>();
        for (int i = 0; i < normal.Count; i++)
        {
            if (normal[i].Cling != 0 || normal[i].Gates != 0) continue;
            List<Pos> l;
            if (!byReg.TryGetValue(normalReg[i], out l)) { l = new List<Pos>(); byReg[normalReg[i]] = l; }
            l.Add(normal[i]);
        }
        var regs = byReg.Keys.ToList();
        var box = new Dictionary<int, int[]>();
        foreach (int rg in regs)
        {
            var l = byReg[rg];
            box[rg] = new[] { l.Min(p => p.X), l.Min(p => p.Y), l.Max(p => p.X), l.Max(p => p.Y) };
        }
        var has = new HashSet<long>();
        foreach (var e in R.Edges) has.Add(((long)e.From << 32) | (uint)e.To);
        // what each region reaches in the room already, with what (the moves above): the search only looks for moves that
        // need less, and not at all where it reaches the other with nothing
        int nNodes = Math.Max(R.NNodes, regs.Count == 0 ? 0 : regs.Max() + 1);
        foreach (var e in R.Edges) nNodes = Math.Max(nNodes, Math.Max(e.From, e.To) + 1);
        var adj = new List<Edge>[nNodes];
        for (int i = 0; i < nNodes; i++) adj[i] = new List<Edge>();
        foreach (var e in R.Edges) adj[e.From].Add(e);
        foreach (int a in regs)
        {
            var reach = new List<Req>[nNodes];
            reach[a] = new List<Req> { new Req() };
            var queue = new Queue<int>(); var inQ = new bool[nNodes];
            queue.Enqueue(a); inQ[a] = true;
            while (queue.Count > 0)
            {
                int u = queue.Dequeue(); inQ[u] = false;
                foreach (var e in adj[u])
                    foreach (var l in reach[u].ToList())
                    {
                        if (reach[e.To] == null) reach[e.To] = new List<Req>();
                        if (Pareto.Add(reach[e.To], Req.Max(l, e.L)) && !inQ[e.To]) { inQ[e.To] = true; queue.Enqueue(e.To); }
                    }
            }
            foreach (int b in regs)
            {
                //if (a == b || has.Contains(((long)a << 32) | (uint)b)) continue;
                if (a == b) continue;
                if (reach[b] != null && reach[b].Any(q => q.None)) continue;
                var A = box[a]; var B = box[b];
                // (the boxes' gap across, and how far up or down b is)
                int gapX = Math.Max(0, Math.Max(B[0] - A[2], A[0] - B[2]));
                if (gapX > 360 || B[1] < A[1] - 200 - 8 || B[3] > A[3] + 100 + 8) continue;
                // the places in a nearest to b (one at each end of the nearest stretch), and which way b is
                Pos near = null; int best = int.MaxValue;
                foreach (var p in byReg[a])
                {
                    if (p.X % 4 != 0) continue;
                    int dx = p.X < B[0] ? B[0] - p.X : (p.X > B[2] ? p.X - B[2] : 0);
                    int dyUp = p.Y - B[3];
                    if (dyUp > 200 || -dyUp > 100) continue;
                    if (dx < best) { best = dx; near = p; }
                }
                if (near == null) continue;
                var froms = new List<Pos> { near };
                var far = byReg[a].Where(p => p.X % 4 == 0 && Math.Abs(p.Y - near.Y) <= 8 && Math.Abs(p.X - near.X) >= 24 && Math.Abs(p.X - near.X) <= 48).OrderByDescending(p => Math.Abs(p.X - near.X)).FirstOrDefault();
                if (far != null) froms.Add(far);
                int dirTo = (B[0] + B[2]) / 2 >= near.X ? 1 : -1;
                // (what's been found to work, and what reaches it already: a move that needs as much or more isn't tried)
                var found = reach[b] != null ? new List<Req>(reach[b]) : new List<Req>();
                foreach (var from in froms)
                {
                    foreach (var prog in GapPrograms(dirTo, R_has(a, from.X - dirTo * 24, from.Y, false)))
                    {
                        if (found.Any(f => f.Le(prog.Label))) continue;
                        var res = Run(prog, from.X, from.Y, false, false, false, false);
                        R.Sims++;
                        if (res.LandX == int.MinValue || RegionAt(res.LandX, res.LandY, false) != b || !SafeLanding(res.LandX, res.LandY, false, false)) continue;
                        // (and with every timing a tick off, one way or the other)
                        bool robust = false;
                        foreach (int sh in new[] { 1, -1 })
                        {
                            var q = prog.Copy();
                            q.JumpHold = Math.Max(1, q.JumpHold + sh);
                            if (q.DjAt >= 0) q.DjAt = Math.Max(1, q.DjAt + sh);
                            if (q.AdAt >= 0) q.AdAt = Math.Max(1, q.AdAt + sh);
                            if (q.HDelay > 0) q.HDelay = Math.Max(1, q.HDelay + sh);
                            var r2 = Run(q, from.X, from.Y, false, false, false, false);
                            R.Sims++;
                            if (r2.LandX != int.MinValue && RegionAt(r2.LandX, r2.LandY, false) == b) { robust = true; break; }
                        }
                        if (!robust) continue;
                        Record(a, prog, res, false, from.X, from.Y);
                        found.Add(prog.Label);
                    }
                }
            }
            // the places near a (a body's height higher than the regions: a place is touched, not stood on) that it doesn't
            // touch with nothing yet, through the room's moves and touches: the same timings, from its place nearest the
            // place and one beside that, only the moves that need less than what touches it already
            for (int L = 0; L < R.Locs.Count; L++)
            {
                var foundL = new List<Req>();
                foreach (var t in R.Touches)
                    if (t.Kind == 0 && t.Index == L && t.From < nNodes && reach[t.From] != null)
                        foreach (var r in reach[t.From]) Pareto.Add(foundL, Req.Max(r, t.L));
                if (foundL.Any(q => q.None)) continue;
                var S = R.Locs[L].S;
                var A = box[a];
                int gapX = Math.Max(0, Math.Max(S.X0 - A[2], A[0] - S.X1));
                if (gapX > 360 || S.Y0 < A[1] - 240 || S.Y1 > A[3] + 100) continue;
                Pos near = null; int best = int.MaxValue;
                foreach (var p in byReg[a])
                {
                    if (p.X % 4 != 0) continue;
                    int dx = p.X < S.X0 ? S.X0 - p.X : (p.X > S.X1 ? p.X - S.X1 : 0);
                    int dyUp = p.Y - S.Y1;
                    if (dyUp > 240 || -dyUp > 100) continue;
                    if (dx < best) { best = dx; near = p; }
                }
                if (near == null) continue;
                var froms = new List<Pos> { near };
                var far = byReg[a].Where(p => p.X % 4 == 0 && Math.Abs(p.Y - near.Y) <= 8 && Math.Abs(p.X - near.X) >= 24 && Math.Abs(p.X - near.X) <= 48).OrderByDescending(p => Math.Abs(p.X - near.X)).FirstOrDefault();
                if (far != null) froms.Add(far);
                int dirTo = (S.X0 + S.X1) / 2 >= near.X ? 1 : -1;
                foreach (var from in froms)
                    foreach (var prog in GapPrograms(dirTo, R_has(a, from.X - dirTo * 24, from.Y, false)))
                    {
                        if (foundL.Any(f => f.Le(prog.Label))) continue;
                        var res = Run(prog, from.X, from.Y, false, false, false, false);
                        R.Sims++;
                        if (!res.Locs.Contains(L)) continue;
                        bool robust = false;
                        foreach (int sh in new[] { 1, -1 })
                        {
                            var q = prog.Copy();
                            q.JumpHold = Math.Max(1, q.JumpHold + sh);
                            if (q.DjAt >= 0) q.DjAt = Math.Max(1, q.DjAt + sh);
                            if (q.AdAt >= 0) q.AdAt = Math.Max(1, q.AdAt + sh);
                            if (q.HDelay > 0) q.HDelay = Math.Max(1, q.HDelay + sh);
                            var r2 = Run(q, from.X, from.Y, false, false, false, false);
                            R.Sims++;
                            if (r2.Locs.Contains(L)) { robust = true; break; }
                        }
                        if (!robust) continue;
                        Record(a, prog, res, false, from.X, from.Y);
                        Pareto.Add(foundL, prog.Label);
                    }
            }
            // the flying enemies near a (where they start): the same timings, a move counting where it comes down on one
            // (stomped with the Mario Ability Set: R.FlyerNode) with its timings a tick off too, only the moves that need
            // less than what gets there already
            for (int f = 0; f < R.Flyers.Count && R.FlyerNode.Length > 0; f++)
            {
                var S = R.Flyers[f];
                var A = box[a];
                int gapX = Math.Max(0, Math.Max(S.X0 - A[2], A[0] - S.X1));
                if (gapX > 360 || S.Y0 < A[1] - 240 || S.Y0 > A[3] + 100) continue;
                var foundF = new List<Req>[2];
                for (int ch = 0; ch < 2; ch++)
                {
                    int nd = R.FlyerNode[f * 2 + ch];
                    foundF[ch] = nd < nNodes && reach[nd] != null ? new List<Req>(reach[nd]) : new List<Req>();
                }
                Pos near = null; int best = int.MaxValue;
                foreach (var p in byReg[a])
                {
                    if (p.X % 4 != 0) continue;
                    int dx = p.X < S.X0 ? S.X0 - p.X : (p.X > S.X1 ? p.X - S.X1 : 0);
                    int dyUp = p.Y - S.Y0;
                    if (dyUp > 240 || -dyUp > 100) continue;
                    if (dx < best) { best = dx; near = p; }
                }
                if (near == null) continue;
                var froms = new List<Pos> { near };
                var far = byReg[a].Where(p => p.X % 4 == 0 && Math.Abs(p.Y - near.Y) <= 8 && Math.Abs(p.X - near.X) >= 24 && Math.Abs(p.X - near.X) <= 48).OrderByDescending(p => Math.Abs(p.X - near.X)).FirstOrDefault();
                if (far != null) froms.Add(far);
                int dirTo = (S.X0 + S.X1) / 2 >= near.X ? 1 : -1;
                foreach (var from in froms)
                    foreach (var prog in GapPrograms(dirTo, R_has(a, from.X - dirTo * 24, from.Y, false)))
                    {
                        int fk = f * 2 + prog.Ch;
                        var lab = prog.Label.With(Req.MARIO, 1);
                        if (foundF[prog.Ch].Any(q => q.Le(lab))) continue;
                        var res = Run(prog, from.X, from.Y, false, false, false, false);
                        R.Sims++;
                        if (!res.Stomps.Contains(fk)) continue;
                        bool robust = false;
                        foreach (int sh in new[] { 1, -1 })
                        {
                            var q = prog.Copy();
                            q.JumpHold = Math.Max(1, q.JumpHold + sh);
                            if (q.DjAt >= 0) q.DjAt = Math.Max(1, q.DjAt + sh);
                            if (q.AdAt >= 0) q.AdAt = Math.Max(1, q.AdAt + sh);
                            if (q.HDelay > 0) q.HDelay = Math.Max(1, q.HDelay + sh);
                            var r2 = Run(q, from.X, from.Y, false, false, false, false);
                            R.Sims++;
                            if (r2.Stomps.Contains(fk)) { robust = true; break; }
                        }
                        if (!robust) continue;
                        Record(a, prog, res, false, from.X, from.Y);
                        Pareto.Add(foundF[prog.Ch], lab);
                    }
            }
        }
    }

    // GapSearch's timings: the jump held 2 to 21 ticks, a double jump and an air dash (Jerry's, the longer, or Claire's,
    // the higher) at different ticks or not at all, going across from the start, after a while, or back later; the
    // plain jumps from a run too
    Dictionary<int, List<Prog>> gapProgs = new Dictionary<int, List<Prog>>();
    List<Prog> GapPrograms(int dir, bool canRun)
    {
        int key = dir * 2 + (canRun ? 1 : 0);
        List<Prog> cached;
        if (gapProgs.TryGetValue(key, out cached)) return cached;
        var ps = new List<Prog>();
        var adL = new Req().With(Req.ADASH, 1);
        foreach (int hold in new[] { 2, 5, 9, 14, 21 })
            foreach (int dj in new[] { -1, 6, 11, 16, 21 })
                foreach (int ad in new[] { -1, 8, 14, 20, 26 })
                    foreach (int ch in new[] { 0, 1 })
                    {
                        if (ad < 0 && ch == 0) continue;
                        var lab = new Req();
                        if (dj >= 0) lab = lab.With(Req.DJUMP, 1);
                        if (ad >= 0) lab = Req.Max(lab, adL);
                        // (across from the start; straight up first, then across; across, then back)
                        ps.Add(new Prog { Name = "gap", Ch = ch, Dir = dir, JumpAt = 0, JumpHold = hold, DjAt = dj, AdAt = ad, H1 = 1, H2 = 1, Label = lab, MaxT = 120 });
                        ps.Add(new Prog { Name = "gap-late", Ch = ch, Dir = dir, JumpAt = 0, JumpHold = hold, DjAt = dj, AdAt = ad, H1 = 0, H2 = 1, HDelay = 6, Label = lab, MaxT = 120 });
                        ps.Add(new Prog { Name = "gap-later", Ch = ch, Dir = dir, JumpAt = 0, JumpHold = hold, DjAt = dj, AdAt = ad, H1 = 0, H2 = 1, HDelay = 12, Label = lab, MaxT = 120 });
                        ps.Add(new Prog { Name = "gap-back", Ch = ch, Dir = dir, JumpAt = 0, JumpHold = hold, DjAt = dj, AdAt = ad, H1 = 1, H2 = -1, HDelay = 10, Label = lab, MaxT = 120 });
                        if (canRun) ps.Add(new Prog { Name = "gap-run", Ch = ch, Dir = dir, RunStart = true, JumpAt = 0, JumpHold = hold, DjAt = dj, AdAt = ad, H1 = 1, H2 = 1, Label = lab, MaxT = 120 });
                    }
        // (and off a dash: Jerry's dash jump, Claire's dash-hop, the double jump and air dash at the same ticks)
        var gdL = new Req().With(Req.GDASH, 1);
        foreach (int dj in new[] { -1, 6, 11, 16, 21 })
            foreach (int ad in new[] { -1, 8, 14, 20, 26 })
            {
                var lab = gdL;
                if (dj >= 0) lab = lab.With(Req.DJUMP, 1);
                if (ad >= 0) lab = Req.Max(lab, adL);
                foreach (int hold in new[] { 2, 5, 9, 14, 21 })
                    ps.Add(new Prog { Name = "gap-dashjump", Ch = 0, Dir = dir, GdAt = 0, JumpAt = 2, JumpHold = hold, DjAt = dj, AdAt = ad, H1 = 1, H2 = 1, Label = lab, MaxT = 120 });
                ps.Add(new Prog { Name = "gap-dashhop", Ch = 1, Dir = dir, GdAt = 0, DjAt = dj, AdAt = ad, H1 = 1, H2 = 1, Label = lab, MaxT = 120 });
            }
        // (cheapest first: a move that needs less is found before one that needs more)
        cached = ps.OrderBy(p => (p.DjAt >= 0 ? 1 : 0) + (p.AdAt >= 0 ? 1 : 0)).ToList();
        gapProgs[key] = cached;
        return cached;
    }

    void TouchesFromStanding(List<Pos> ps, List<int> reg, int top)
    {
        for (int i = 0; i < ps.Count; i++)
        {
            var p = ps[i];
            int x0, y0, x1, y1;
            StandBox(p.X, p.Y, out x0, out y0, out x1, out y1);
            if (top < 40) y0 = p.Y - 12;
            // (with falling pillars: where it's touched from, the pillars it's on and the ones it's in)
            int pg = p.Gates & R.PillarMask;
            for (int j = 0; j < R.Locs.Count; j++) if (R.Locs[j].S.Hits(x0, y0, x1, y1)) AddTouchAt(reg[i], 0, j, new Req(), (top < 40 ? "as the Morph Ball, " : "") + "standing at " + p.X + "," + p.Y + ", touches it", p.X, p.Y, pg);
            for (int j = 0; j < R.Spots.Count; j++) if (R.Spots[j].S.Hits(x0, y0, x1, y1)) AddTouchAt(reg[i], 2, j, new Req(), (top < 40 ? "as the Morph Ball, " : "") + "standing at " + p.X + "," + p.Y + ", on it", p.X, p.Y, pg);
            for (int j = 0; j < R.Exits.Count; j++)
            {
                var ex = R.Exits[j];
                bool hit = ex.Type == 3 ? ex.S.Hits(p.X - 7, p.Y - 2, p.X + 6, p.Y + 1) : ex.S.Hits(x0, y0, x1, y1);
                if (hit) AddTouchAt(reg[i], 1, j, new Req(), (top < 40 ? "as the Morph Ball, " : "") + "standing at " + p.X + "," + p.Y + ", " + ExitAction(ex), p.X, p.Y, pg);
            }
        }
    }

    // how an exit is gone through, in words
    public static string ExitAction(Exit ex)
    {
        if (ex.Obj == "menu") return "chooses it from the menu";
        if (ex.Obj == "encounter") return "lets an encounter enemy touch the icon on the map (this fight room for the tile under it)";
        if (ex.Obj == "oZeldaMapExit") return "walks the icon onto it on the map";
        switch (ex.Type)
        {
            case 0: return "presses up at it";
            case 2: return "presses down at it";
            case 3: return "stands on it and presses up or down";
            default: return "goes into it";
        }
    }

    // each region in words: where its places are (the player's feet: x the body's middle, y its bottom)
    void NameRegions(List<Pos> ps, List<int> reg, string what)
    {
        var bb = new Dictionary<int, int[]>();
        for (int i = 0; i < ps.Count; i++)
        {
            int[] b;
            if (!bb.TryGetValue(reg[i], out b)) { b = new[] { int.MaxValue, int.MaxValue, int.MinValue, int.MinValue, 0, 0, 0 }; bb[reg[i]] = b; }
            var p = ps[i];
            b[0] = Math.Min(b[0], p.X); b[1] = Math.Min(b[1], p.Y); b[2] = Math.Max(b[2], p.X); b[3] = Math.Max(b[3], p.Y);
            if (p.Cling != 0) b[4]++;
            b[5]++;
            if (p.Gates != 0) b[6]++;
        }
        foreach (var kv in bb)
        {
            var b = kv.Value;
            string s = (b[4] == b[5] ? "on the wall at " : what + " at ") + (b[0] == b[2] ? "x " + b[0] : "x " + b[0] + "-" + b[2])
                + ", " + (b[1] == b[3] ? "y " + b[1] : "y " + b[1] + "-" + b[3]);
            if (b[6] > 0) s += " (where a gate is)";
            R.NodeName[kv.Key] = s;
        }
    }

    // ---------------------------------------------------------------- moves
    // a Mario enemy on the ground walks or hops on the floor under it (64px under it at most): it's landed on its height
    // over that floor (16px, a Goomba's: the Bros are taller), within 48px of where it's placed, where that floor goes on
    void MakeStompers()
    {
        foreach (var g in R.GroundFoes)
        {
            int x = g[0], fy = int.MinValue;
            for (int y = g[1] - 16; y < g[1] + 64; y++) if (R.SolidC.Get(x, y) || R.Plat.Get(x, y)) { fy = y; break; }
            if (fy == int.MinValue) continue;
            Func<int, bool> floor = xx => (R.SolidC.Get(xx, fy) || R.Plat.Get(xx, fy)) && !R.SolidC.Get(xx, fy - 1);
            int x0 = x, x1 = x;
            while (x0 > x - 48 && floor(x0 - 1)) x0--;
            while (x1 < x + 48 && floor(x1 + 1)) x1++;
            R.Stompers.Add(new[] { x0, x1, fy - 16 });
        }
    }

    // near a Mario enemy on the ground: a jump on toward it, or in place (it walks under the player), or a walk off a
    // ledge, landing on it, held jump: bounced up, then holding on, nothing or back, with the double jump or the air dash
    // it gives back
    List<Prog> StompPrograms()
    {
        var ps = new List<Prog>();
        var mario = new Req().With(Req.MARIO, 1);
        var dj = Req.Max(mario, new Req().With(Req.DJUMP, 1));
        var ad = Req.Max(mario, new Req().With(Req.ADASH, 1));
        foreach (int d in new[] { -1, 1 })
            foreach (int h1 in new[] { 1, 0 })
                foreach (int h in new[] { 1, 0, -1 })
                {
                    if (h1 == 0 && h == 0 && d < 0) continue;
                    ps.Add(new Prog { Name = h1 == 1 ? "stomp" : "stomp-up", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 60, H1 = h1, H2 = h, AfterBounce = true, Stomp = true, MaxT = 120, Label = mario });
                    ps.Add(new Prog { Name = h1 == 1 ? "stompdj" : "stomp-updj", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 60, H1 = h1, H2 = h, AfterBounce = true, Stomp = true, DjAt = 12, MaxT = 120, Label = dj });
                    if (h1 == 1) ps.Add(new Prog { Name = "stomp-fall", Ch = 1, Dir = d, H1 = 1, H2 = h, AfterBounce = true, Stomp = true, NoInputTillAir = true, MaxT = 120, Label = mario });
                    if (h == 1) ps.Add(new Prog { Name = h1 == 1 ? "stompad" : "stomp-upad", Ch = 0, Dir = d, JumpAt = 0, JumpHold = 60, H1 = h1, H2 = 1, AfterBounce = true, Stomp = true, AdAt = 10, MaxT = 120, Label = ad });
                }
        return ps;
    }

    // just bounced off a latch crystal (k: R.CrystalNode's key): on the way it faces or back, or holding nothing; with the
    // double jump or the air dash it gave back, soon or later; or mashing the attack for the next crystal, with or without
    List<Prog> CrystalPrograms(int k)
    {
        var ps = new List<Prog>();
        int ch = k % 2, f = (k / 2) % 2 == 1 ? 1 : -1;
        var none = new Req();
        var dj = new Req().With(Req.DJUMP, 1);
        var ad = new Req().With(Req.ADASH, 1);
        int area = R.Data.Area;
        foreach (int d in new[] { f, -f })
            foreach (int h in new[] { 1, 0 })
            {
                if (h == 0 && d != f) continue;
                ps.Add(new Prog { Name = "crystal-off", Ch = ch, Dir = d, FromCrystal = k, H1 = h, H2 = h, Label = none, MaxT = 120 });
                foreach (int t in new[] { 1, 6, 12 }) ps.Add(new Prog { Name = "crystal-dj" + t, Ch = ch, Dir = d, FromCrystal = k, H1 = h, H2 = h, DjAt = t, Label = dj, MaxT = 120 });
                if (ch == 0) foreach (int t in new[] { 1, 6 }) ps.Add(new Prog { Name = "crystal-ad" + t, Ch = ch, Dir = d, FromCrystal = k, H1 = h, H2 = 1, AdAt = t, Label = ad, MaxT = 120 });
                for (int wi = 0; wi < Weapon.All.Length; wi++)
                {
                    var w = Weapon.All[wi];
                    if (w.Ch != ch || (w.Need == Req.GAMEC && area != 58)) continue;
                    var wn = new Req().With(w.Need, 1);
                    foreach (int at in new[] { 2, 6 })
                    {
                        ps.Add(new Prog { Name = "crystal-pogo", Ch = ch, Dir = d, FromCrystal = k, H1 = h, H2 = h, Weapon = wi, AtkAt = at, AtkEvery = w.Cycle, Label = wn, MaxT = 120 });
                        foreach (int t in new[] { 1, 6, 12 })
                            ps.Add(new Prog { Name = "crystal-pogo-dj" + t, Ch = ch, Dir = d, FromCrystal = k, H1 = h, H2 = h, Weapon = wi, AtkAt = at, AtkEvery = w.Cycle, DjAt = t, Label = Req.Max(wn, dj), MaxT = 120 });
                        if (ch == 0) ps.Add(new Prog { Name = "crystal-pogo-ad", Ch = ch, Dir = d, FromCrystal = k, H1 = h, H2 = 1, Weapon = wi, AtkAt = at, AtkEvery = w.Cycle, AdAt = 4, Label = Req.Max(wn, ad), MaxT = 120 });
                    }
                }
            }
        return ps;
    }

    // where a move off a latch crystal starts: beside it on the side it was hit from, facing it, 24px off (the swing's
    // reach), the crystal dy above the feet (20: at the body's middle), or the nearest clear place to that
    bool CrystalStart(int k, int dy0, out int x, out int y)
    {
        var c = R.Crystals[k / 4];
        int f = (k / 2) % 2 == 1 ? 1 : -1;
        int cx = (c.X0 + c.X1) / 2, cy = (c.Y0 + c.Y1) / 2;
        foreach (int dx in new[] { 24, 28, 20, 32, 16, 36, 40 })
            foreach (int dy in new[] { dy0, dy0 - 4, dy0 + 4, dy0 - 8, dy0 + 8 })
            {
                x = cx - f * dx; y = cy + dy;
                if (!R.SolidC.Box(x - 7, y - 40, x + 6, y - 1)) return true;
            }
        x = y = 0;
        return false;
    }

    // just stomped a flying enemy (k: R.FlyerNode's key), up at -13.5 with the jump or up held or -6.5 with neither: on
    // either way or holding nothing, or steered after a while; with the double jump or the air dash it gave back, soon or
    // later
    List<Prog> FlyerPrograms(int k)
    {
        var ps = new List<Prog>();
        int ch = k % 2;
        var none = new Req();
        var dj = new Req().With(Req.DJUMP, 1);
        var ad = new Req().With(Req.ADASH, 1);
        foreach (bool lowB in new[] { false, true })
        {
            string n = lowB ? "flyer-low" : "flyer";
            foreach (int d in new[] { 1, -1 })
            {
                foreach (int h in new[] { 1, 0 })
                {
                    if (h == 0 && d < 0) continue;
                    ps.Add(new Prog { Name = n + "-off", Ch = ch, Dir = d, FromFlyer = k, LowBounce = lowB, H1 = h, H2 = h, Label = none, MaxT = 120 });
                    foreach (int t in new[] { 1, 6, 12, 18 }) ps.Add(new Prog { Name = n + "-dj" + t, Ch = ch, Dir = d, FromFlyer = k, LowBounce = lowB, H1 = h, H2 = h, DjAt = t, Label = dj, MaxT = 120 });
                    if (ch == 0) foreach (int t in new[] { 1, 6, 12 }) ps.Add(new Prog { Name = n + "-ad" + t, Ch = ch, Dir = d, FromFlyer = k, LowBounce = lowB, H1 = h, H2 = 1, AdAt = t, Label = ad, MaxT = 120 });
                }
                // (steered for a while and let go, or let go a while and steered: onto a narrow ledge up or across)
                foreach (int hd in new[] { 4, 8, 12, 16, 20 })
                {
                    ps.Add(new Prog { Name = n + "-steer" + hd, Ch = ch, Dir = d, FromFlyer = k, LowBounce = lowB, H1 = 1, H2 = 0, HDelay = hd, Label = none, MaxT = 120 });
                    ps.Add(new Prog { Name = n + "-late" + hd, Ch = ch, Dir = d, FromFlyer = k, LowBounce = lowB, H1 = 0, H2 = 1, HDelay = hd, Label = none, MaxT = 120 });
                }
                ps.Add(new Prog { Name = n + "-late-dj", Ch = ch, Dir = d, FromFlyer = k, LowBounce = lowB, H1 = 0, H2 = 1, HDelay = 8, DjAt = 14, Label = dj, MaxT = 120 });
            }
        }
        return ps;
    }

    // from each stomped flying enemy (a node of R.FlyerNode) to the other flying enemies near it and the regions near it
    // that it doesn't get to with as little yet: a grid of timings (when to steer and for how long, the double jump and
    // the air dash at different ticks), each counted only from both of the stomp's heights (Both) and with its timings a
    // tick off too (the chains a fixed few moves miss: Lava Cave 1's Paratroopas over the lava)
    void FlyerSearch()
    {
        if (R.FlyerNode.Length == 0) return;
        var direct = new Dictionary<long, List<Req>>();
        foreach (var e in R.Edges)
        {
            long ek = ((long)e.From << 32) | (uint)e.To;
            List<Req> l;
            if (!direct.TryGetValue(ek, out l)) { l = new List<Req>(); direct[ek] = l; }
            Pareto.Add(l, e.L);
        }
        // (the standing regions, by their places' box)
        var rbox = new Dictionary<int, int[]>();
        for (int i = 0; i < normal.Count; i++)
        {
            if (normal[i].Cling != 0 || normal[i].Gates != 0) continue;
            int[] b;
            if (!rbox.TryGetValue(normalReg[i], out b)) { b = new[] { normal[i].X, normal[i].Y, normal[i].X, normal[i].Y }; rbox[normalReg[i]] = b; }
            b[0] = Math.Min(b[0], normal[i].X); b[1] = Math.Min(b[1], normal[i].Y); b[2] = Math.Max(b[2], normal[i].X); b[3] = Math.Max(b[3], normal[i].Y);
        }
        for (int k = 0; k < R.FlyerNode.Length; k++)
        {
            int bx, by, lx, ly;
            if (!FlyerStart(k, 1, out bx, out by)) continue;
            bool low = FlyerStart(k, 9, out lx, out ly);
            int ch = k % 2, from = R.FlyerNode[k];
            var src = R.Flyers[k / 2];
            int scx = (src.X0 + src.X1) / 2;
            // (targets: a node or a region, where it is, and whether a move's result gets there)
            var targets = new List<Tuple<int, int, Func<Result, bool>>>();
            for (int f = 0; f < R.Flyers.Count; f++)
            {
                var S = R.Flyers[f];
                int tcx = (S.X0 + S.X1) / 2, fk = f * 2 + ch;
                if (f == k / 2 || Math.Abs(tcx - scx) > 320 || S.Y0 < src.Y0 - 200 || S.Y0 > src.Y0 + 200) continue;
                targets.Add(Tuple.Create(R.FlyerNode[fk], tcx, (Func<Result, bool>)(r => r.Stomps.Contains(fk))));
            }
            foreach (var kv in rbox)
            {
                var B = kv.Value; int rg = kv.Key;
                int gapX = Math.Max(0, Math.Max(B[0] - scx, scx - B[2]));
                if (gapX > 320 || B[1] < src.Y0 - 160 || B[1] > src.Y0 + 240) continue;
                targets.Add(Tuple.Create(rg, (B[0] + B[2]) / 2, (Func<Result, bool>)(r => r.LandX != int.MinValue && RegionAt(r.LandX, r.LandY, false) == rg && SafeLanding(r.LandX, r.LandY, false, false))));
            }
            foreach (var tg in targets)
            {
                List<Req> found;
                direct.TryGetValue(((long)from << 32) | (uint)tg.Item1, out found);
                found = found == null ? new List<Req>() : new List<Req>(found);
                if (found.Any(q => q.None)) continue;
                int dir = tg.Item2 >= scx ? 1 : -1;
                foreach (var prog in FlyerSearchPrograms(k, dir))
                {
                    if (found.Any(q => q.Le(prog.Label))) continue;
                    var res = Run(prog, bx, by, false, false, true, false);
                    R.Sims++;
                    if (!tg.Item3(res)) continue;
                    if (low)
                    {
                        var r2 = Run(prog, lx, ly, false, false, true, false);
                        R.Sims++;
                        if (!tg.Item3(r2)) continue;
                        Both(res, r2);
                    }
                    bool robust = false;
                    foreach (int sh in new[] { 1, -1 })
                    {
                        var q = prog.Copy();
                        if (q.DjAt >= 0) q.DjAt = Math.Max(1, q.DjAt + sh);
                        if (q.AdAt >= 0) q.AdAt = Math.Max(1, q.AdAt + sh);
                        if (q.HDelay > 0) q.HDelay = Math.Max(1, q.HDelay + sh);
                        var r3 = Run(q, bx, by, false, false, true, false);
                        R.Sims++;
                        if (tg.Item3(r3)) { robust = true; break; }
                    }
                    if (!robust) continue;
                    Record(from, prog, res, false, bx, by);
                    Pareto.Add(found, prog.Label);
                    long dk = ((long)from << 32) | (uint)tg.Item1;
                    List<Req> dl;
                    if (!direct.TryGetValue(dk, out dl)) { dl = new List<Req>(); direct[dk] = dl; }
                    Pareto.Add(dl, prog.Label);
                }
            }
        }
    }

    // FlyerSearch's timings off a stomped flying enemy: either bounce; steering its way from the start, after a while, or
    // for a while; the double jump and (Jerry) the air dash at different ticks or not at all
    Dictionary<int, List<Prog>> flyerSearchProgs = new Dictionary<int, List<Prog>>();
    List<Prog> FlyerSearchPrograms(int k, int dir)
    {
        int ch = k % 2, key = (k * 2 + (dir > 0 ? 1 : 0));
        List<Prog> cached;
        if (flyerSearchProgs.TryGetValue(key, out cached)) return cached;
        var ps = new List<Prog>();
        var steers = new List<int[]> { new[] { 1, 1, 0 } };
        foreach (int hd in new[] { 4, 8, 12, 16, 20 }) { steers.Add(new[] { 0, 1, hd }); steers.Add(new[] { 1, 0, hd }); }
        foreach (int hd in new[] { 8, 16 }) steers.Add(new[] { 1, -1, hd });
        foreach (bool lowB in new[] { false, true })
            foreach (var st in steers)
                foreach (int dj in new[] { -1, 2, 6, 10, 14, 18, 22, 26 })
                    foreach (int ad in ch == 0 ? new[] { -1, 2, 6, 10, 14, 18 } : new[] { -1 })
                    {
                        var lab = new Req();
                        if (dj >= 0) lab = lab.With(Req.DJUMP, 1);
                        if (ad >= 0) lab = lab.With(Req.ADASH, 1);
                        ps.Add(new Prog { Name = "flyer-search", Ch = ch, Dir = dir, FromFlyer = k, LowBounce = lowB, H1 = st[0], H2 = st[1], HDelay = st[2], DjAt = dj, AdAt = ad, Label = lab, MaxT = 120 });
                    }
        // (cheapest first: what needs nothing, then one item, then both)
        ps = ps.OrderBy(p => (p.DjAt >= 0 ? 1 : 0) + (p.AdAt >= 0 ? 1 : 0)).ToList();
        flyerSearchProgs[key] = ps;
        return ps;
    }

    // where a move off a stomped flying enemy starts: over its middle, the feet dy under its top, or the nearest clear
    // place to that
    bool FlyerStart(int k, int dy, out int x, out int y)
    {
        var fl = R.Flyers[k / 2];
        int cx = (fl.X0 + fl.X1) / 2;
        foreach (int dx in new[] { 0, -4, 4, -8, 8 })
        {
            x = cx + dx; y = fl.Y0 + dy;
            if (!R.SolidC.Box(x - 7, y - 40, x + 6, y - 1)) return true;
        }
        x = y = 0;
        return false;
    }

    // fired from a travel cannon: once it lets go, holding nothing, on ahead or back, with a double jump or an air dash
    // soon after or later (getting in gave them back)
    List<Prog> CannonPrograms(int ci)
    {
        var ps = new List<Prog>();
        var none = new Req();
        var dj = new Req().With(Req.DJUMP, 1);
        var ad = new Req().With(Req.ADASH, 1);
        int mt = R.Cannons[ci].Ticks + 120;
        foreach (int d in new[] { 1, -1 })
            foreach (int h in new[] { 1, 0 })
            {
                if (d < 0 && h == 0) continue;
                ps.Add(new Prog { Name = "cannon", Ch = 1, Dir = d, Cannon = ci, H1 = 0, H2 = h, AfterBounce = true, MaxT = mt, Label = none });
                foreach (int k in new[] { 1, 12 })
                {
                    ps.Add(new Prog { Name = "cannondj" + k, Ch = 1, Dir = d, Cannon = ci, H1 = 0, H2 = h, AfterBounce = true, DjAt = k, MaxT = mt, Label = dj });
                    if (h == 1) ps.Add(new Prog { Name = "cannonad" + k, Ch = 0, Dir = d, Cannon = ci, H1 = 0, H2 = 1, AfterBounce = true, AdAt = k, MaxT = mt, Label = ad });
                }
            }
        return ps;
    }

    List<Prog> Programs(bool morph, bool platform, bool runL, bool runR, bool spring = false, bool fade = false, bool crystal = false, bool stomper = false)
    {
        var ps = new List<Prog>();
        var none = new Req();
        var dj = new Req().With(Req.DJUMP, 1);
        var ad = new Req().With(Req.ADASH, 1);
        var gd = new Req().With(Req.GDASH, 1);
        var djad = Req.Max(dj, ad);
        int area = R.Data.Area;
        // (near a Mario enemy on the ground: landing on it)
        if (stomper && !morph) ps.AddRange(StompPrograms());
        // on a fading platform: waiting till it fades and falling through it, steered or not (as the Morph Ball too: only
        // it fits on some, under a low ceiling)
        if (fade)
            foreach (int h in new[] { 1, 0, -1 })
                ps.Add(new Prog { Name = "fade", Ch = 1, Dir = 1, Fade = true, Morph = morph, NoInputTillAir = morph, H1 = h, H2 = h, Label = none });
        if (morph)
        {
            // a morph bomb under the ball throws it up (oSamusBExplosion: yVel -9.5): one, steered or not
            var bombs = new Req().With(Req.SAMUS, 6);
            foreach (int h in new[] { -1, 0, 1 })
                ps.Add(new Prog { Name = "bombjump", Dir = 1, BombJump = true, Morph = true, H1 = h, H2 = h, Label = bombs, MaxT = 60 });
            foreach (int d in new[] { -1, 1 })
                foreach (int h in new[] { 1, 0, -1 })
                {
                    ps.Add(new Prog { Name = "roll", Dir = d, H1 = 1, H2 = h, HDelay = 1, NoInputTillAir = true, Morph = true, Label = none, MaxT = 80 });
                    if ((d < 0 ? runL : runR)) ps.Add(new Prog { Name = "rollrun", Dir = d, RunStart = true, H1 = 1, H2 = h, HDelay = 1, NoInputTillAir = true, Morph = true, Label = none, MaxT = 80 });
                }
            // rolling off (out of a tunnel) and turning back in the air once there's room: on with the body's speed, or a
            // double jump or air dash, at tick 6, 9 or 12 (at 60/120fps the body comes back a little later: Gate 5's
            // Mother Brain room's way left needs the later double jump there)
            var djM = new Req().With(Req.DJUMP, 1);
            var adM = new Req().With(Req.ADASH, 1);
            foreach (int d in new[] { -1, 1 })
            {
                bool run = d < 0 ? runL : runR;
                ps.Add(new Prog { Name = "roll-unmorph", Ch = 1, Dir = d, RunStart = run, H1 = 1, H2 = 1, HDelay = 1, NoInputTillAir = true, Morph = true, AutoUnmorph = true, Label = none, MaxT = 80 });
                foreach (int at in new[] { 6, 9, 12 })
                {
                    ps.Add(new Prog { Name = "roll-unmorph-dj", Ch = 1, Dir = d, RunStart = run, H1 = 1, H2 = 1, HDelay = 1, NoInputTillAir = true, Morph = true, AutoUnmorph = true, DjAt = at, Label = djM, MaxT = 80 });
                    ps.Add(new Prog { Name = "roll-unmorph-ad", Ch = 0, Dir = d, RunStart = run, H1 = 1, H2 = 1, HDelay = 1, NoInputTillAir = true, Morph = true, AutoUnmorph = true, AdAt = at, Label = adM, MaxT = 80 });
                }
            }
            return ps;
        }
        foreach (int d in new[] { -1, 1 })
        {
            bool run = d < 0 ? runL : runR;
            // walking off
            foreach (int h in new[] { 1, 0, -1 })
            {
                ps.Add(new Prog { Name = "walkoff", Ch = 1, Dir = d, H1 = 1, H2 = h, HDelay = 1, NoInputTillAir = true, Label = none });
                if (run) ps.Add(new Prog { Name = "runoff", Ch = 1, Dir = d, RunStart = true, H1 = 1, H2 = h, HDelay = 1, NoInputTillAir = true, Label = none });
            }
            // jumps
            foreach (int hold in new[] { 2, 6, 21 })
            {
                ps.Add(new Prog { Name = "jump" + hold, Ch = 1, Dir = d, JumpAt = 0, JumpHold = hold, H1 = 1, H2 = 1, Label = none });
                if (run) ps.Add(new Prog { Name = "runjump" + hold, Ch = 1, Dir = d, RunStart = true, JumpAt = 0, JumpHold = hold, H1 = 1, H2 = 1, Label = none });
            }
            ps.Add(new Prog { Name = "jumpup-side", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 1, HDelay = 8, Label = none });
            ps.Add(new Prog { Name = "jumpup-late", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 1, HDelay = 14, Label = none });
            if (run)
            {
                ps.Add(new Prog { Name = "runjump-coast", Ch = 1, Dir = d, RunStart = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 0, HDelay = 2, Label = none });
                ps.Add(new Prog { Name = "runjump-back", Ch = 1, Dir = d, RunStart = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = -1, HDelay = 6, Label = none });
            }
            // double jumps
            foreach (int t in new[] { 5, 10, 15 })
                ps.Add(new Prog { Name = "dj" + t, Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, DjAt = t, H1 = 1, H2 = 1, Label = dj });
            ps.Add(new Prog { Name = "djup", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, DjAt = 12, H1 = 0, H2 = 1, HDelay = 14, Label = dj });
            ps.Add(new Prog { Name = "djup2", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, DjAt = 14, H1 = 0, H2 = 0, HDelay = 99, Label = dj });
            if (run) ps.Add(new Prog { Name = "rundj", Ch = 1, Dir = d, RunStart = true, JumpAt = 0, JumpHold = 21, DjAt = 10, H1 = 1, H2 = 1, Label = dj });
            foreach (int t in new[] { 2, 8, 16, 24 })
                ps.Add(new Prog { Name = "walkoffdj" + t, Ch = 1, Dir = d, DjAt = t, H1 = 1, H2 = 1, NoInputTillAir = true, Label = dj });
            // (dropping down a shaft, then an air dash once out of it: on, or back the way it came)
            ps.Add(new Prog { Name = "walkoffad-clear", Ch = 0, Dir = d, AdAt = 6, AdClear = true, H1 = 1, H2 = 1, NoInputTillAir = true, Label = ad });
            ps.Add(new Prog { Name = "walkoffad-back", Ch = 0, Dir = d, AdAt = 6, AdClear = true, AdDir = -d, H1 = 1, H2 = -1, HDelay = 2, NoInputTillAir = true, Label = ad });
            ps.Add(new Prog { Name = "walkoffdj-back", Ch = 1, Dir = d, DjAt = 3, H1 = 1, H2 = -1, HDelay = 2, NoInputTillAir = true, Label = dj });
            // air dashes (Jerry's goes further, Claire's higher)
            foreach (int c in new[] { 0, 1 })
            {
                foreach (int t in new[] { 4, 10, 16 })
                    ps.Add(new Prog { Name = "ad" + t, Ch = c, Dir = d, JumpAt = 0, JumpHold = 21, AdAt = t, H1 = 1, H2 = 1, Label = ad });
                if (run) ps.Add(new Prog { Name = "runad", Ch = c, Dir = d, RunStart = true, JumpAt = 0, JumpHold = 21, AdAt = 8, H1 = 1, H2 = 1, Label = ad });
                ps.Add(new Prog { Name = "walkoffad", Ch = c, Dir = d, AdAt = 2, H1 = 1, H2 = 1, NoInputTillAir = true, Label = ad });
                ps.Add(new Prog { Name = "upad", Ch = c, Dir = d, JumpAt = 0, JumpHold = 21, AdAt = 12, H1 = 0, H2 = 1, HDelay = 12, Label = ad });
                ps.Add(new Prog { Name = "djad", Ch = c, Dir = d, JumpAt = 0, JumpHold = 21, DjAt = 10, AdAt = 18, H1 = 1, H2 = 1, Label = djad });
                ps.Add(new Prog { Name = "addj", Ch = c, Dir = d, JumpAt = 0, JumpHold = 21, AdAt = 8, DjAt = 16, H1 = 1, H2 = 1, Label = djad });
            }
            // ground dash (Jerry: a dash along the ground, then a jump keeps its speed; Claire: a hop)
            foreach (int k in new[] { 1, 4 })
                ps.Add(new Prog { Name = "dashjump" + k, Ch = 0, Dir = d, GdAt = 0, JumpAt = k, JumpHold = 21, H1 = 1, H2 = 1, Label = gd });
            ps.Add(new Prog { Name = "dashjumpdj", Ch = 0, Dir = d, GdAt = 0, JumpAt = 2, JumpHold = 21, DjAt = 12, H1 = 1, H2 = 1, Label = Req.Max(gd, dj) });
            ps.Add(new Prog { Name = "dashjumpad", Ch = 0, Dir = d, GdAt = 0, JumpAt = 2, JumpHold = 21, AdAt = 12, H1 = 1, H2 = 1, Label = Req.Max(gd, ad) });
            ps.Add(new Prog { Name = "hopdash", Ch = 1, Dir = d, GdAt = 0, H1 = 1, H2 = 1, Label = gd });
            ps.Add(new Prog { Name = "hopdashdj", Ch = 1, Dir = d, GdAt = 0, DjAt = 8, H1 = 1, H2 = 1, Label = Req.Max(gd, dj) });
            ps.Add(new Prog { Name = "hopdashad", Ch = 1, Dir = d, GdAt = 0, AdAt = 8, H1 = 1, H2 = 1, Label = Req.Max(gd, ad) });
            // the High Jump Boots (Gate 5 only)
            if (area == 49)
                foreach (int lv in new[] { 1, 2 })
                {
                    var hj = new Req().With(Req.HIJUMP, lv);
                    ps.Add(new Prog { Name = "hijump" + lv, Ch = 1, Dir = d, JumpAt = 0, JumpHold = 40, H1 = 1, H2 = 1, HiJump = lv, Label = hj });
                    ps.Add(new Prog { Name = "hijumpup" + lv, Ch = 1, Dir = d, JumpAt = 0, JumpHold = 40, H1 = 0, H2 = 1, HDelay = 12, HiJump = lv, Label = hj });
                    if (run) ps.Add(new Prog { Name = "runhijump" + lv, Ch = 1, Dir = d, RunStart = true, JumpAt = 0, JumpHold = 40, H1 = 1, H2 = 1, HiJump = lv, Label = hj });
                    ps.Add(new Prog { Name = "hijumpdj" + lv, Ch = 1, Dir = d, JumpAt = 0, JumpHold = 40, DjAt = 16, H1 = 0, H2 = 1, HDelay = 16, HiJump = lv, Label = Req.Max(hj, dj) });
                }
            // wall jumps (where the game allows them)
            if (area == 29 || area == 91 || area == 104)
            {
                ps.Add(new Prog { Name = "wallclimb", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 1, WallMode = 0, MaxT = 160, Label = none });
                ps.Add(new Prog { Name = "wallzigzag", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 1, WallMode = 1, MaxT = 160, Label = none });
            }
        }
        if (platform)
            foreach (int h in new[] { 1, 0, -1 })
                ps.Add(new Prog { Name = "dropdown", Ch = 1, Dir = 1, DropDown = true, H1 = h, H2 = h, Label = none });
        ps.Add(new Prog { Name = "jumpup", Ch = 1, Dir = 1, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 0, Label = none });
        // jumping and turning into the Morph Ball in the air (into a tunnel above the floor)
        if (morphOnly)
        {
            var samus2 = new Req().With(Req.SAMUS, 2);
            foreach (int d in new[] { -1, 1 })
                foreach (int m in new[] { 8, 14 })
                {
                    ps.Add(new Prog { Name = "jumpmorph" + m, Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, MorphAt = m, H1 = 1, H2 = 1, Label = samus2 });
                    ps.Add(new Prog { Name = "jumpupmorph" + m, Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, MorphAt = m, H1 = 0, H2 = 1, HDelay = m, Label = samus2 });
                }
        }
        // on a spring: hop onto it, and steer once it's bounced the player up
        if (spring)
            foreach (int d in new[] { -1, 1 })
                foreach (int h in new[] { 1, 0 })
                {
                    ps.Add(new Prog { Name = "spring", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 2, H1 = 0, H2 = h, AfterBounce = true, MaxT = 120, Label = none });
                    ps.Add(new Prog { Name = "springdj", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 2, H1 = 0, H2 = h, AfterBounce = true, DjAt = 18, MaxT = 120, Label = dj });
                    ps.Add(new Prog { Name = "springad", Ch = 0, Dir = d, JumpAt = 0, JumpHold = 2, H1 = 0, H2 = 1, AfterBounce = true, AdAt = 16, MaxT = 120, Label = ad });
                    // (steered only once it's high: up past a ledge's overhang, then onto it)
                    if (h == 1)
                        foreach (int k in new[] { 6, 12 })
                        {
                            ps.Add(new Prog { Name = "spring-late" + k, Ch = 1, Dir = d, JumpAt = 0, JumpHold = 2, H1 = 0, H2 = 1, HDelay = k, AfterBounce = true, MaxT = 120, Label = none });
                            ps.Add(new Prog { Name = "springdj-late" + k, Ch = 1, Dir = d, JumpAt = 0, JumpHold = 2, H1 = 0, H2 = 1, HDelay = k, AfterBounce = true, DjAt = 18, MaxT = 120, Label = dj });
                        }
                }
        // near a latch crystal: jumps with a melee attack pressed at one of a swing's ticks and again each time it can be
        // (mashing it), steered at it or after a while; a hit in the air bounces the player up (Weapon). The Blade Strike
        // only where Gate 6's sets work (its area)
        if (crystal)
            for (int wi = 0; wi < Weapon.All.Length; wi++)
            {
                var w = Weapon.All[wi];
                if (w.Need == Req.GAMEC && area != 58) continue;
                var wn = new Req().With(w.Need, 1);
                foreach (int d in new[] { -1, 1 })
                    for (int at = 0; at < w.Cycle; at += 2)
                    {
                        ps.Add(new Prog { Name = "pogo", Ch = w.Ch, Dir = d, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 1, Weapon = wi, AtkAt = at, AtkEvery = w.Cycle, Label = wn, MaxT = 160 });
                        ps.Add(new Prog { Name = "pogo-late", Ch = w.Ch, Dir = d, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 1, HDelay = 10, Weapon = wi, AtkAt = at, AtkEvery = w.Cycle, Label = wn, MaxT = 160 });
                        ps.Add(new Prog { Name = "pogo-dj", Ch = w.Ch, Dir = d, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 1, Weapon = wi, AtkAt = at, AtkEvery = w.Cycle, DjAt = at + w.Cycle, Label = Req.Max(wn, dj), MaxT = 160 });
                    }
            }
        // the same jumps, falls and bounces turning into the Morph Ball in the air where the body meets a wall or a
        // ceiling (AutoMorph): into a tunnel in a wall, or one up under a ceiling. Morphing earlier than that only slows
        // the ball down (its air speed is lower), so none of it is a precise timing
        if (morphOnly)
        {
            var samus2 = new Req().With(Req.SAMUS, 2);
            var am = new List<Prog>();
            foreach (var q in ps)
            {
                bool take = q.Name == "jump21" || q.Name == "jump6" || q.Name == "runjump21" || q.Name == "jumpup" || q.Name == "jumpup-late"
                    || q.Name == "dj10" || q.Name == "djup" || (q.Name == "ad10" && q.Ch == 1) || (q.Name == "walkoff" && q.H2 != 0)
                    || (q.Name == "spring" && q.H2 == 1);
                if (!take) continue;
                var c = q.Copy();
                c.Name = q.Name + "-morph"; c.AutoMorph = true; c.Label = Req.Max(q.Label, samus2);
                am.Add(c);
            }
            // (and off a spring: the double jump, then the Morph Ball a few ticks after it, up past a wall's top into a gap
            // over it too low to stand in; morphing where the body meets the wall comes before the double jump, and the ball
            // has none: Displaced Construction Site 12's)
            var djm = Req.Max(samus2, new Req().With(Req.DJUMP, 1));
            foreach (var q in ps.Where(q => q.Name == "spring" && q.H2 == 1).ToList())
                foreach (var km in new[] { new[] { 10, 14 }, new[] { 14, 18 }, new[] { 18, 22 } })
                {
                    var c = q.Copy();
                    c.Name = "springdj-morph" + km[1]; c.DjAt = km[0]; c.MorphAt = km[1]; c.MaxT = 140; c.Label = Req.Max(q.Label, djm);
                    am.Add(c);
                }
            ps.AddRange(am);
        }
        return ps;
    }

    // the moves off a Strike Chain point: jumping (straight up, or across), with a double jump or air dash, or dropping
    List<Prog> HangPrograms()
    {
        var ps = new List<Prog>();
        var none = new Req();
        var dj = new Req().With(Req.DJUMP, 1);
        var ad = new Req().With(Req.ADASH, 1);
        ps.Add(new Prog { Name = "hangjumpup", Ch = 1, Dir = 1, FromHang = true, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 0, Label = none });
        foreach (int d in new[] { -1, 1 })
        {
            ps.Add(new Prog { Name = "hangjump", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 1, Label = none });
            //ps.Add(new Prog { Name = "hangjump-late", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 1, HDelay = 10, Label = none });
            //ps.Add(new Prog { Name = "hangjumpdj", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, DjAt = 12, H1 = 0, H2 = 1, HDelay = 12, Label = dj });
            // (steering later, and the double jump at more ticks: the jump off a point is a standing jump's, whose first
            // tick has no gravity, so it goes higher and further than the logic used to have it, and steering at once
            // overshoots a ledge beside the point: Grand Rising's first, 72,1880)
            foreach (int hd in new[] { 10, 16, 22 })
                ps.Add(new Prog { Name = "hangjump-late", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 1, HDelay = hd, Label = none });
            foreach (var t in new[] { new[] { 12, 12 }, new[] { 12, 16 }, new[] { 16, 20 }, new[] { 20, 24 } })
                ps.Add(new Prog { Name = "hangjumpdj", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, DjAt = t[0], H1 = 0, H2 = 1, HDelay = t[1], Label = dj });
            ps.Add(new Prog { Name = "hangjumpdj-across", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, DjAt = 12, H1 = 1, H2 = 1, Label = dj });
            ps.Add(new Prog { Name = "hangjumpad", Ch = 0, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, AdAt = 10, H1 = 1, H2 = 1, Label = ad });
            ps.Add(new Prog { Name = "hangjumpad-early", Ch = 0, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, AdAt = 4, H1 = 1, H2 = 1, Label = ad });
            ps.Add(new Prog { Name = "hangjumpad-claire", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, AdAt = 8, H1 = 1, H2 = 1, Label = ad });
            // (both: an air dash, then a double jump; or the other way round)
            ps.Add(new Prog { Name = "hangjumpaddj", Ch = 0, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, AdAt = 6, DjAt = 16, H1 = 1, H2 = 1, Label = Req.Max(dj, ad) });
            ps.Add(new Prog { Name = "hangjumpdjad", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, DjAt = 10, AdAt = 18, H1 = 1, H2 = 1, Label = Req.Max(dj, ad) });
            //ps.Add(new Prog { Name = "hangdrop", Ch = 1, Dir = d, FromHang = true, H1 = 1, H2 = 1, Label = none });
            ps.Add(new Prog { Name = "hangdrop", Ch = 1, Dir = d, FromHang = true, HangDrop = true, H1 = 1, H2 = 1, Label = none });
        }
        //ps.Add(new Prog { Name = "hangdropdown", Ch = 1, Dir = 1, FromHang = true, H1 = 0, H2 = 0, Label = none });
        ps.Add(new Prog { Name = "hangdropdown", Ch = 1, Dir = 1, FromHang = true, HangDrop = true, H1 = 0, H2 = 0, Label = none });
        return ps;
    }

    class Result { public int LandX = int.MinValue, LandY, LandT; public List<int> Locs = new List<int>(); public List<int> Spots = new List<int>(); public List<int> Exits = new List<int>(); public List<int> Hangs = new List<int>(); public List<long> Clings = new List<long>(); public int Gates; public bool Morph, Morphed; public int Pogos, PillTouch, PillStood;
        // (the latch crystals it bounced off: R.CrystalNode's keys, (crystal*2 + 1 facing right)*2 + the character)
        public List<int> Bounces = new List<int>();
        // (the flying enemies it came down on: R.FlyerNode's keys, flyer*2 + the character)
        public List<int> Stomps = new List<int>(); }

    // the moves from standing at x,y (not as the Morph Ball) that land safely within maxT ticks: where, when, what they
    // need and how (for a shot at a switch: the player moves while it flies; AnalyzeStates)
    public List<Tuple<int, int, int, Req, string>> QuickMoves(int x, int y, int maxT)
    {
        var o = new List<Tuple<int, int, int, Req, string>>();
        // (the usual moves, and jumps of more heights steered from the start or after a few ticks: what lands soonest)
        var progs = Programs(false, false, false, false);
        var dj = new Req().With(Req.DJUMP, 1);
        foreach (int d in new[] { -1, 1 })
            foreach (int delay in new[] { 0, 3, 6, 9 })
            {
                foreach (int hold in new[] { 8, 10, 12, 14, 16 })
                    progs.Add(new Prog { Name = "quick", Ch = 1, Dir = d, JumpAt = 0, JumpHold = hold, H1 = delay == 0 ? 1 : 0, H2 = 1, HDelay = delay, Label = new Req(), MaxT = maxT + 1 });
                foreach (int djAt in new[] { 6, 9, 12 })
                    progs.Add(new Prog { Name = "quickdj", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 21, DjAt = djAt, H1 = delay == 0 ? 1 : 0, H2 = 1, HDelay = delay, Label = dj, MaxT = maxT + 1 });
            }
        foreach (var prog in progs)
        {
            if (prog.AutoMorph || prog.AutoUnmorph) continue;
            var res = Run(prog, x, y, false, false, false, false);
            R.Sims++;
            if (res.LandX == int.MinValue || res.Morph || res.LandT > maxT) continue;
            if (res.LandX == x && res.LandY == y) continue;
            if (!SafeLanding(res.LandX, res.LandY, false, false)) continue;
            o.Add(Tuple.Create(res.LandX, res.LandY, res.LandT, prog.Label, Describe(prog)));
        }
        return o;
    }

    // the Strike Chain points the chain reaches from (x,y): fired straight ahead (either way) at the player's chest
    // (y-32), 84px and a bit; nothing solid in its way
    List<int> ChainReach(int x, int y)
    {
        var o = new List<int>();
        int cy = y - 32;
        for (int k = 0; k < R.Points.Count; k++)
        {
            var p = R.Points[k];
            int dx = p[0] - x;
            if (Math.Abs(p[1] - cy) > 14 || Math.Abs(dx) > 94) continue;
            int a = Math.Min(x, p[0]), b = Math.Max(x, p[0]);
            if (R.SolidC.Row(cy, a, b) || R.SolidC.Row(cy - 5, a, b) || R.SolidC.Row(cy + 5, a, b)) continue;
            o.Add(k);
        }
        return o;
    }

    // (--allfps) every move at 30, 60 and 120fps: the game runs at any of them and a move works out a little differently
    // at each (above 30fps its own code: Sim.StepHi). What the logic then counts is what the move does at all three: the
    // landing if each lands in the same region, the places, exits and points each touches; the gates any of them goes
    // through. Above 30fps the pixel rounding goes by the player's ditherCounter, which a jump sets: a move that starts
    // some other way (walking off, a dash, rolling) is tried from two of its values. Off by default: the same timings at
    // every frame rate is stricter than a player needs (each frame rate's own logic, --fps 60/120 and combine_fps.py, is
    // the better test once the springs' touch and the rest Phase C has to model are right)
    public static bool AllFps = false;
    public static bool LogRejects;   // (--fpsrejects: what the 60/120fps check takes away, in work\..\fps_rejects.txt)
    // (--fps 60 or 120: every move at that frame rate alone, for working out each frame rate's logic on its own; above
    // 30fps a move that doesn't start with a jump is tried from both dither starts, as above)
    public static double FixedDt = 1;
    Result Run(Prog p, int sx, int sy, bool open, bool morphStart, bool airStart, bool elevator, int[] box = null)
    {
        // (a jump sets the ditherCounter to 15: a wall's kick doesn't)
        bool jumpsFirst = p.JumpAt == 0 && p.GdAt < 0 && !p.NoInputTillAir && !morphStart && !p.BombJump && !p.FromWall;
        if (FixedDt < 1 && p.Dt == 1 && !traceOn && !machineTrace)
        {
            var p0 = p.Copy(); p0.Dt = FixedDt; p0.Dither = 0;
            var rf = RunOne(p0, sx, sy, open, morphStart, airStart, elevator, box);
            if (jumpsFirst) return rf;
            var p1 = p0.Copy(); p1.Dither = 1;
            var rf1 = RunOne(p1, sx, sy, open, morphStart, airStart, elevator, box);
            Both(rf, rf1);
            return rf;
        }
        var r = RunOne(p, sx, sy, open, morphStart, airStart, elevator, box);
        if (!AllFps || p.Dt != 1 || traceOn || machineTrace) return r;
        foreach (double dt in new[] { 0.5, 0.25 })
            foreach (int d in jumpsFirst ? new[] { 0 } : new[] { 0, 1 })
            {
                if (r.LandX == int.MinValue && r.Locs.Count == 0 && r.Exits.Count == 0 && r.Spots.Count == 0 && r.Hangs.Count == 0 && r.Clings.Count == 0 && r.Bounces.Count == 0 && r.Stomps.Count == 0) return r;
                var q = p.Copy(); q.Dt = dt; q.Dither = d;
                var r2 = RunOne(q, sx, sy, open, morphStart, airStart, elevator, box);
                if (LogRejects)
                {
                    var lost = new List<string>();
                    if (r.LandX != int.MinValue && (r2.LandX == int.MinValue || r2.Morph != r.Morph || RegionAt(r2.LandX, r2.LandY, r2.Morph) != RegionAt(r.LandX, r.LandY, r.Morph)))
                        lost.Add(string.Format("landing {0},{1} (region {2}) -> {3}", r.LandX, r.LandY, RegionAt(r.LandX, r.LandY, r.Morph),
                            r2.LandX == int.MinValue ? "none" : r2.LandX + "," + r2.LandY + " (region " + RegionAt(r2.LandX, r2.LandY, r2.Morph) + ")"));
                    foreach (int k in r.Locs) if (!r2.Locs.Contains(k)) lost.Add("loc " + R.Locs[k].Type + " " + R.Locs[k].Num);
                    foreach (int k in r.Exits) if (!r2.Exits.Contains(k)) lost.Add("exit " + k);
                    foreach (int k in r.Hangs) if (!r2.Hangs.Contains(k)) lost.Add("point " + R.Points[k][0] + "," + R.Points[k][1]);
                    if (lost.Count > 0)
                        lock (R.Log) R.FpsRejects.Add(string.Format("{0} from {1},{2} {3} ({4}) at {5}fps dither {6}: {7}", R.Data.Name, sx, sy, Describe(p), p.Label,
                            (int)Math.Round(30 / dt), d, string.Join("; ", lost)));
                }
                Both(r, r2);
            }
        return r;
    }

    // what two runs of a move both do, into r: the landing if both land in the same region, the places, exits, points
    // and walls both touch; the gates either goes through
    void Both(Result r, Result r2)
    {
        if (r.LandX != int.MinValue && (r2.LandX == int.MinValue || r2.Morph != r.Morph || RegionAt(r2.LandX, r2.LandY, r2.Morph) != RegionAt(r.LandX, r.LandY, r.Morph)))
            r.LandX = int.MinValue;
        if (r2.LandT > r.LandT) r.LandT = r2.LandT;
        r.Locs.RemoveAll(k => !r2.Locs.Contains(k));
        r.Spots.RemoveAll(k => !r2.Spots.Contains(k));
        r.Exits.RemoveAll(k => !r2.Exits.Contains(k));
        r.Hangs.RemoveAll(k => !r2.Hangs.Contains(k));
        r.Bounces.RemoveAll(k => !r2.Bounces.Contains(k));
        r.Stomps.RemoveAll(k => !r2.Stomps.Contains(k));
        // (a wall reached: the same wall's standing region, not the same pixel)
        r.Clings.RemoveAll(k => !r2.Clings.Any(k2 => R.PosRegion[k2] == R.PosRegion[k]));
        r.Gates |= r2.Gates;
        r.Morphed |= r2.Morphed;
    }

    Result RunOne(Prog p, int sx, int sy, bool open, bool morphStart, bool airStart, bool elevator, int[] box = null)
    {
        var s = new Sim { R = R, S = SolidOverride ?? (open ? R.SolidO : R.SolidC), Open = open, x = sx, y = sy, ch = p.Ch, facing = p.Dir };
        s.runAcc = p.Ch == 0 ? 6.6 : 7.3;
        s.hasDJ = p.Label.Get(Req.DJUMP) > 0; s.hasAD = p.Label.Get(Req.ADASH) > 0; s.hasGD = p.Label.Get(Req.GDASH) > 0;
        s.wallArea = (R.Data.Area == 29 || R.Data.Area == 91 || R.Data.Area == 104);
        if (p.HiJump == 1) { s.ija = -7.8; s.jtt = 28; }
        else if (p.HiJump == 2) { s.ija = -9.4; s.jtt = 35; }
        // above 30fps: the frame rate, the pixel rounding's start, and the jumps' corrections (oPlayer1's Alarm 0: Gate 5's
        // upgrades have their own at 60fps and at 120fps)
        s.dt = p.Dt; s.dither = p.Dither;
        if (p.Dt < 1 && !Sim.OldExe)
        {
            if (p.HiJump == 1) { if (p.Dt < 0.5) { s.jb60 = 1.077; s.jgc60 = 0.511; s.djb60 = 0.97; } else { s.jb60 = 0.943; s.jgc60 = -0.364; s.djb60 = 1.012; } }
            else if (p.HiJump == 2) { if (p.Dt < 0.5) { s.jb60 = 0.876; s.jgc60 = -1.071; s.djb60 = 0.954; } else { s.jb60 = 0.974; s.jgc60 = -0.187; s.djb60 = 0.992; } }
        }
        s.jumpTime = s.jtt; s.gi = s.grav;
        // jumps, air dashes and springs a bit weaker than the game's (about 10% lower), so nothing the logic counts needs
        // a pixel-perfect jump (and the 60/120fps game's jumps are a pixel or two off the 30fps ones)
        s.ija *= Sim.Slack; s.djAcc *= Sim.Slack;
        if (morphStart) { s.morph = true; s.top = 13; }
        s.state = airStart ? Sim.FALLING : Sim.STANDING;
        if (p.Fade)
        {
            // (the fading platform under the feet: gone for this move)
            var fp = R.Fades.FirstOrDefault(f => f.Hits(sx - 7, sy - 1, sx + 6, sy - 1));
            if (fp == null) return new Result();
            s.Faded = new[] { fp.X0, fp.Y0, fp.X1, fp.Y1 };
        }
        if (elevator) { s.ex = true; s.ex0 = sx - 16; s.ex1 = sx + 15; s.ey0 = sy; s.ey1 = sy + 50; }
        // (a solid box only this move has: a push rock where it's been pushed to)
        if (box != null) { s.ex = true; s.ex0 = box[0]; s.ex1 = box[1]; s.ey0 = box[2]; s.ey1 = box[3]; }
        if (p.FromWall)
        {
            // (sliding down it: the game's wall grab keeps a double jump or air dash from firing on the kick's press)
            s.state = Sim.FALLING; s.wallGrab = true; s.facing = p.Dir;
            if (p.Dir < 0) { s.kL = true; s.kLSteps = 5; } else { s.kR = true; s.kRSteps = 5; }
        }
        if (p.FromHang)
        {
            s.state = Sim.FALLING; s.canAirDash = 1; s.djc = 1;
            //if (p.JumpAt == 0) { s.yAcc += s.ija; s.jbr = false; s.jumpTime = 0; s.kJ = true; }
            // (characterStepEvent's grappleState 3: the gravity that piled up while hanging is dropped, yAcc=initialJumpAcc
            // at 30fps, yAcc=0 above it, so the jump's first tick has no gravity, as a standing jump's hasn't; above 30fps the
            // jump is the standing jump's, pMoveJump's. Letting go, down and jump, is yAcc=2 in place of the gravity, above
            // 30fps a one-off push; both with the jump button held that tick, so the gravity ramps up as in a jump)
            if (p.JumpAt == 0)
            {
                // (the jump sets the ditherCounter to 15 in that frame, after oPlayer1's Step has added 1: 14 here, as
                // StepHi adds 1 first)
                if (p.Dt == 1) s.yAcc += s.ija;
                else { s.yVel = s.ija * s.jb60 + s.grav * s.jgc60; s.dither = 14; }
                s.jbr = false; s.jumpTime = 0; s.kJ = true;
            }
            else if (p.HangDrop)
            {
                s.yAcc = 2;
                if (p.Dt < 1) s.pendYSet = true;
                s.jbr = false; s.jumpTime = 0; s.kJ = true; s.kD = true;
            }
            s.gi = 0;
        }
        if (p.RunStart && !airStart)
        {
            s.xVel = p.Dir * (morphStart ? 7.6 : (p.Ch == 0 ? 6.6 : 7.3)); s.state = Sim.RUNNING;
            if (p.Dir < 0) { s.kL = true; s.kLSteps = 5; } else { s.kR = true; s.kRSteps = 5; }
        }
        // fired from a travel cannon: ahead of it and up, in the air with the double jump and air dash back (getting in gives
        // them: canAirDash, doubleJumpCheck), flown at its speed till it lets go (below)
        Cannon cn = p.Cannon >= 0 ? R.Cannons[p.Cannon] : null;
        if (cn != null) { s.x = cn.X + 21 * cn.Dir; s.y = cn.Y - 36; s.state = Sim.FALLING; s.canAirDash = 1; s.djc = 1; s.facing = cn.Dir; s.inCannon = true; s.gi = 0; }
        // just bounced off a latch crystal (facing it): takeDamage's push up (yVel -2, then yAcc -3) and the weapon's slow
        // fall (the sword's 3 ticks, the whip's and the Blade Strike's 5), the double jump and air dash back
        if (p.FromCrystal >= 0)
        {
            s.state = Sim.FALLING; s.facing = (p.FromCrystal / 2) % 2 == 1 ? 1 : -1;
            s.yVel = -2;
            if (p.Dt >= 1) s.yAcc = -3; else { s.yVel -= 3; s.yVel += s.gi * 0.5; }
            s.sft = p.Ch == 0 ? 3 : 5; s.sfe = 0.5;
            s.canAirDash = 1; s.djc = 1;
        }
        // just stomped a flying enemy, on its top: oEMarioBase's bounce (the jump or up held, or neither: LowBounce)
        if (p.FromFlyer >= 0) { s.state = Sim.FALLING; s.facing = p.Dir; s.Stomp(!p.LowBounce); }
        var res = new Result();
        if (R.Pillars.Count > 0) { res.PillTouch = PillarsTouched(s.x, s.y, s.top); if (!airStart) res.PillStood = PillarsUnder(s.x, s.y); }
        bool wasAir = airStart || cn != null, airborne = airStart || cn != null, bounced = false;
        int bounceT = 0;
        int airT = 0, wallFlip = 1;
        bool prevJ = false;
        var inp = new In();
        int x0 = s.x, y0 = s.y;
        int roomT = 0;
        bool adDone = false;
        // a melee attack (Prog.Weapon): when it started, where its weapon is (made at the player, then put where the
        // player is at each tick's end: its End Step, after the tick's collisions), the crystals it's hit, and till when
        // each crystal can't be hit (its damage flash)
        Weapon wpn = p.Weapon >= 0 ? Weapon.All[p.Weapon] : null;
        int atkT0 = -1000, atkN = 0, wx = 0, wy = 0, wFacing = 1;
        // (off a crystal: the swing that hit it began a few ticks back)
        if (p.FromCrystal >= 0) atkT0 = -4;
        var stomped = new HashSet<int>();
        // (when a dash was last pressed: its invulnerability keeps a stomp from happening)
        int dashT = -1000;
        var atkHit = new HashSet<int>();
        var flashTill = new Dictionary<int, int>();
        int lim = p.MaxT;
        for (int t = 0; t < lim; t++)
        {
            // (the cannon lets go: the keys from here, counted from it as after a spring's bounce; the speed it gave goes on)
            if (cn != null && t == cn.Ticks) { s.inCannon = false; s.gi = s.grav; bounced = true; bounceT = t; }
            // the input this tick
            int hs;
            int tt = p.NoInputTillAir ? (airborne ? airT : -1) : t;
            //if (p.AfterBounce) hs = bounced ? p.H2 : p.H1;
            // (HDelay: that many ticks after the bounce)
            if (p.AfterBounce) hs = bounced && t - bounceT >= p.HDelay ? p.H2 : p.H1;
            else if (tt < 0) hs = 1;
            else hs = tt < p.HDelay ? p.H1 : p.H2;
            int hd = hs * p.Dir;
            if (p.WallMode == 1) hd = p.Dir * wallFlip;
            inp.L = hd < 0; inp.R = hd > 0;
            bool j = false;
            int jt = p.NoInputTillAir ? tt : t;
            if (p.JumpAt >= 0 && jt >= p.JumpAt && jt < p.JumpAt + p.JumpHold) j = true;
            // (after a spring: the double jump and air dash count from the bounce)
            if (p.AfterBounce) jt = bounced ? t - bounceT : -100;
            if (p.DjAt >= 0)
            {
                if (jt == p.DjAt - 1) j = false;
                if (jt >= p.DjAt && jt < p.DjAt + p.DjHold) j = true;
            }
            if (p.WallMode >= 0 && s.InAir && t > 2)
            {
                bool touching = (s.facing == 1 && s.ColRight(3)) || (s.facing == -1 && s.ColLeft(3));
                j = touching && !prevJ;
                if (s.wjt > 0) j = prevJ && s.wjt > 1;
            }
            inp.J = j; prevJ = j;
            inp.DL = false; inp.DR = false;
            if (p.GdAt >= 0 && jt == p.GdAt) { if (p.Dir < 0) inp.DL = true; else inp.DR = true; }
            if (p.AdAt >= 0 && !adDone)
            {
                int ad = p.AdDir != 0 ? p.AdDir : p.Dir;
                bool go = jt == p.AdAt;
                if (p.AdClear && jt >= p.AdAt && s.InAir)
                {
                    // (64px clear ahead, from the body's top to a bit under its feet: it's falling)
                    int ax0 = ad > 0 ? s.x + 7 : s.x - 71, ax1 = ad > 0 ? s.x + 70 : s.x - 8;
                    go = !s.S.Box(ax0, s.y - s.top, ax1, s.y + 24);
                }
                if (go)
                {
                    inp.L = ad < 0; inp.R = ad > 0;
                    if (ad < 0) inp.DL = true; else inp.DR = true;
                    adDone = true;
                }
            }
            if (inp.DL || inp.DR) dashT = t;
            inp.D = p.DropDown && t == 0;
            // (letting go of a Strike Chain point: down and jump, that tick)
            if (p.HangDrop && t == 0) { inp.D = true; inp.J = true; }
            if (p.MorphAt >= 0 && jt == p.MorphAt && !s.morph) { s.morph = true; s.top = 13; }
            if (p.AutoMorph && !s.morph && s.InAir)
            {
                bool wall = (inp.R && s.ColRight(1)) || (inp.L && s.ColLeft(1));
                bool ceil = false;
                if (s.yVel < 0)
                    for (int k = 0; k <= (int)Math.Ceiling(-s.yVel) && !ceil; k++)
                        if (s.S.Row(s.y - s.top - 1 - k, s.x - 7, s.x + 6)) ceil = true;
                if (wall || ceil) { s.morph = true; s.top = 13; res.Morphed = true; }
            }
            if (p.AutoUnmorph && s.morph && s.InAir)
            {
                // (playerTechStart: the body's box has to be clear; the game's runAcc is 7.3 after it)
                if (!s.S.Box(s.x - 7, s.y - 40, s.x + 6, s.y - 2)) roomT++; else roomT = 0;
                if (roomT >= 2) { s.morph = false; s.top = 40; s.runAcc = 7.3; res.Morphed = true; }
            }
            if (p.BombJump && t == 0) { s.yVel = -9.5 * Sim.Slack; s.state = Sim.JUMPING; }
            if (p.BounceAt >= 0 && jt == p.BounceAt && s.InAir) s.Stomp();
            // (the attack pressed: at AtkAt, and every AtkEvery after, once the last swing's over; the Blade Strike's 12
            // weapon energy a swing, of 150 at most and nothing that gives it back here: 6 swings a move)
            inp.A = false;
            if (wpn != null && jt >= p.AtkAt && (jt == p.AtkAt || (p.AtkEvery > 0 && (jt - p.AtkAt) % p.AtkEvery == 0)) && t - atkT0 >= wpn.Cycle && !s.morph
                && (wpn.Need != Req.GAMEC || atkN < 6))
            {
                atkT0 = t; atkN++; atkHit.Clear(); wx = s.x; wy = s.y; wFacing = s.facing; inp.A = true;
            }
            // the tick's frames (one at 30fps; above it the game moves every frame, StepHi), what they touch checked each
            // frame; the trace line is the tick's end (or where the move stops)
            int frames = p.Dt < 1 ? (int)Math.Round(1 / p.Dt) : 1;
            bool printed = false;
            Action traceTick = () =>
            {
                if (printed) return;
                printed = true;
                if (traceOn) Console.WriteLine("  t{0} {1},{2} state {3} vel {4:F2},{5:F2} keys {6}{7}{8}{9} bounce {10}", t, s.x, s.y, s.state, s.xVel, s.yVel, inp.L ? "L" : "", inp.R ? "R" : "", inp.J ? "J" : "", inp.DL || inp.DR ? "D" : "", s.bounce);
                if (machineTrace) Console.WriteLine(string.Format(CultureInfo.InvariantCulture, "T {0} {1} {2} {3:F3} {4:F3} {5} {6} {7}", t, s.x, s.y, s.xVel, s.yVel, s.state, KeysOf(inp), s.morph ? 1 : 0));
            };
            for (int fr = 0; fr < frames; fr++)
            {
            int px = s.x, py = s.y;
            double wjtWas = s.wjt;
            // (oTravelCannon's Step: 16 right and 16 up, every frame of the flight)
            if (s.inCannon) { s.xVel = 16; s.yVel = -16; s.xAcc = 0; s.yAcc = 0; }
            if (p.Dt < 1) s.StepHi(inp); else s.Step(inp);
            if (machineTrace && p.Dt < 1) Console.WriteLine(string.Format(CultureInfo.InvariantCulture, "F {0} {1} {2} {3} {4:F3} {5:F3} {6} {7} {8:R} {9:R}", t, fr, s.x, s.y, s.xVel, s.yVel, s.state, s.dither, s.lastRoundX, s.lastRoundY));
            // the attack's weapon against the latch crystals after the step (the collision events): this tick's frame of
            // it (image_index 0 the tick it's made, then its speed a tick) where its End Step last put it. A hit in the air
            // bounces the player (takeDamage: yVel -2, then yAcc -3; a slow fall) and gives the air dash and the double
            // jump back; the crystal flashes a tick (charEnemyCreateEvent's flashTime 1), not hit again in it
            if (wpn != null && fr == frames - 1 && R.Crystals.Count > 0)
            {
                int n = t - atkT0, wf = (int)Math.Floor(n * wpn.Speed);
                if (n >= 0 && wf < wpn.Frames)
                {
                    var ws = wpn.Frame(wf, wFacing, n == 0);
                    for (int c = 0; ws != null && c < R.Crystals.Count; c++)
                    {
                        var cr = R.Crystals[c];
                        int ft;
                        if (atkHit.Contains(c) || (flashTill.TryGetValue(c, out ft) && t < ft)) continue;
                        if (!ws.Hits(cr.X0 - wx, cr.Y0 - wy, cr.X1 - wx, cr.Y1 - wy)) continue;
                        atkHit.Add(c); flashTill[c] = t + 2;
                        if (!s.InAir) continue;
                        s.yVel = -2;
                        if (p.Dt >= 1) s.yAcc = -3; else { s.yVel -= 3; s.yVel += s.gi * 0.5; }
                        if (s.sft < wpn.SlowFall) { s.sft = wpn.SlowFall; s.sfe = 0.5; }
                        s.canAirDash = 1; s.djc = 1;
                        res.Pogos++;
                        int bk = (c * 2 + (wFacing > 0 ? 1 : 0)) * 2 + p.Ch;
                        if (!res.Bounces.Contains(bk)) res.Bounces.Add(bk);
                    }
                }
                wx = s.x + wpn.OffX * s.facing; wy = s.y + wpn.OffY; wFacing = s.facing;
            }
            if (fr == frames - 1) traceTick();
            if (s.InAir) { airborne = true; }
            if (fr == frames - 1 && airborne) airT++;
            //if (p.WallMode == 1 && s.wjt == 3) wallFlip = -wallFlip;
            // (a wall jump this frame: off to the other wall. The wall jump's 3 has already been counted down in the
            // same step, so wjt is never 3 here: wallzigzag kept to one wall like wallclimb)
            if (p.WallMode == 1 && s.wjt > wjtWas) wallFlip = -wallFlip;
            // touching things at the end of the tick (the game's collision events; above 30fps, of each frame)
            int bx0, by0, bx1, by1;
            if (s.OnGround) StandBox(s.x, s.y, out bx0, out by0, out bx1, out by1); else AirBox(s.x, s.y, out bx0, out by0, out bx1, out by1);
            if (s.morph) by0 = s.y - 12;
            // (the falling pillars the body touches, standing: on, beside or under one, a pixel round it)
            if (R.Pillars.Count > 0) { res.PillTouch |= PillarsTouched(s.x, s.y, s.top); if (s.OnGround) res.PillStood |= PillarsUnder(s.x, s.y); }
            if (HazardAt(s.x, s.y, s.top, open)) { traceTick(); return res; }
            if (s.dead) { traceTick(); return res; }
            if (open && R.Gates.Count > 0)
            {
                // (the gates gone through: a solid one where the body's been, a hazard one where its hurt box has)
                int ax0 = Math.Min(px, s.x) - 7, ax1 = Math.Max(px, s.x) + 6, ay0 = Math.Min(py, s.y) - s.top, ay1 = Math.Max(py, s.y) - 2;
                int hy0 = Math.Min(py, s.y) - (s.top < 40 ? 14 : Math.Max(s.top, 46));
                foreach (var gt in R.Gates)
                    if (gt.Group < 31 && (res.Gates & (1 << gt.Group)) == 0 && gt.S.Hits(ax0, gt.Hazard ? hy0 : ay0, ax1, ay1)) res.Gates |= 1 << gt.Group;
            }
            for (int k = 0; k < R.Locs.Count; k++) if (R.Locs[k].S.Hits(bx0, by0, bx1, by1) && !res.Locs.Contains(k)) res.Locs.Add(k);
            for (int k = 0; k < R.Spots.Count; k++) if (R.Spots[k].S.Hits(bx0, by0, bx1, by1) && !res.Spots.Contains(k)) res.Spots.Add(k);
            for (int k = 0; k < R.Exits.Count; k++)
            {
                var e = R.Exits[k];
                bool hit = e.Type == 3 ? (s.OnGround && e.S.Hits(s.x - 7, s.y - 2, s.x + 6, s.y + 1)) : e.S.Hits(bx0, by0, bx1, by1);
                if (!hit || res.Exits.Contains(k)) continue;
                res.Exits.Add(k);
                if (e.Type == 1 && !e.InRoom) { traceTick(); return res; }   // walked into: gone at once
            }
            // beside a wall in the air where the game has wall jumps: on that wall (it can be climbed from there)
            if (wallArea && !s.morph && s.InAir && (s.ColRight(1) || s.ColLeft(1)))
            {
                long ck = Shape.Key(s.x, s.y);
                if (R.PosRegion.ContainsKey(ck) && !res.Clings.Contains(ck)) res.Clings.Add(ck);
            }
            if (R.Points.Count > 0 && !s.morph && (s.OnGround || Math.Abs(s.yVel) <= 4))
                foreach (int k in ChainReach(s.x, s.y)) if (!res.Hangs.Contains(k)) res.Hangs.Add(k);
            // (coming down on a flying enemy where it starts: stomped with the Mario Ability Set, a node to go on from,
            // R.FlyerNode; the move itself goes on as if it weren't there. Not as the Morph Ball, nor in a dash's
            // invulnerability (9 ticks, more with the skill tree: 12 here). Its top crossed by the air touch box's bottom,
            // a few pixels in: the game's stomp, as the feet meet it, came a little before)
            if (R.FlyerNode.Length > 0 && s.yVel > 0 && !s.morph && t - dashT >= 12)
            {
                int fx0, fy0, fx1, fy1;
                AirBox(s.x, s.y, out fx0, out fy0, out fx1, out fy1);
                for (int f = 0; f < R.Flyers.Count; f++)
                {
                    var fl = R.Flyers[f];
                    if ((p.FromFlyer >= 0 && f == p.FromFlyer / 2) || fx1 < fl.X0 || fx0 > fl.X1 || py - 13 >= fl.Y0 || fy1 < fl.Y0) continue;
                    int fk = f * 2 + p.Ch;
                    if (!res.Stomps.Contains(fk)) res.Stomps.Add(fk);
                }
            }
            // (coming down on a Mario enemy on the ground, a move with the Mario Ability Set: stomped once, the bounce of
            // a flying one's, jump held (oEMarioBase: -13.5, the double jump and air dash back))
            if (p.Stomp && s.yVel > 0 && !s.morph)
                for (int k = 0; k < R.Stompers.Count; k++)
                {
                    var z = R.Stompers[k];
                    if (stomped.Contains(k) || s.x < z[0] || s.x > z[1] || py >= z[2] || s.y < z[2]) continue;
                    s.y = z[2]; s.Stomp(); stomped.Add(k);
                    if (!bounced) bounceT = t;
                    bounced = true;
                    break;
                }
            if (s.yVel > 0)
                foreach (var sp in R.Springs)
                    if (sp.S.Hits(bx0, by0, bx1, by1) && s.bounce <= 0)
                    {
                        s.canAirDash = 1; s.djc = 1;
                        //s.yVel = (sp.Large ? -16 : -14) * Sim.Slack; s.bounceVel = s.yVel; s.bounce = sp.Large ? 7 : 3;
                        s.yVel = (sp.Large ? -16 : -14) * Sim.Slack; s.bounceVel = s.yVel; s.bounce = sp.Ticks;
                        if (s.OnGround) s.state = Sim.JUMPING;
                        if (!bounced) bounceT = t;
                        bounced = true;
                    }
            if (airborne && s.OnGround && (s.x != x0 || s.y != y0 || t > 0))
            {
                res.LandX = s.x; res.LandY = s.y; res.Morph = s.morph; res.LandT = t;
                traceTick();
                return res;
            }
            }
            // (water slows a fall to about 4px a tick: a move still in the air in water as its time runs out gets more,
            // up to 5 times its own)
            if (t == lim - 1 && lim < p.MaxT * 5 && s.InAir && R.Water.Any && R.Water.Row(s.y - 14, s.x - 7, s.x + 6)) lim += p.MaxT;
        }
        return res;
    }

    int RegionAt(int x, int y, bool morph)
    {
        var map = morph ? R.MPosRegion : R.PosRegion;
        int r;
        for (int dy = 0; dy <= 3; dy++)
            foreach (int sy in new[] { y - dy, y + dy })
                for (int dx = 0; dx <= 2; dx++)
                    foreach (int sx in new[] { x - dx, x + dx })
                        if (map.TryGetValue(Shape.Key(sx, sy), out r)) return r;
        return -1;
    }

    // what a move (p from sx,sy) did: the places it touched, the Strike Chain points and walls it got to, where it landed
    void Record(int from, Prog p, Result res, bool open, int sx, int sy)
    {
        var need = new List<Req> { p.Label };
        int gates = open ? res.Gates : 0;
        if (gates != 0) need = Pareto.Product(need, GatesNeed(gates));
        // (the falling pillars a move with them standing touches: the ones it goes on, off, or against; a move with the
        // gates open goes through fallen ones, its gates)
        int pt = open ? 0 : res.PillTouch;
        // (and the ones it starts on, stands on on the way and lands on; each region's moves' pillars, the ones that
        // come to nothing too)
        int ps0 = 0, pst = 0, pld = 0;
        if (R.Pillars.Count > 0)
        {
            ps0 = PillarsUnder(sx, sy);
            pst = open ? ps0 : res.PillStood | ps0;
            if (res.LandX != int.MinValue) pld = PillarsUnder(res.LandX, res.LandY) & ~(open ? res.Gates : 0);
            int rp;
            runPills.TryGetValue(from, out rp);
            runPills[from] = rp | pt | (open ? res.Gates & R.PillarMask : 0);
        }
        foreach (int k in res.Locs) foreach (var l in need) AddTouch(from, 0, k, l, p, sx, sy, gates, pt, ps0);
        foreach (int k in res.Exits) foreach (var l in need) AddTouch(from, 1, k, l, p, sx, sy, gates, pt, ps0);
        foreach (int k in res.Spots) foreach (var l in need) AddTouch(from, 2, k, l, p, sx, sy, gates, pt, ps0);
        // (a way in's moves are made before the points' nodes are: from there, the moves of where it lands reach them)
        foreach (int k in res.Hangs) if (k < R.HangNode.Length) foreach (var l in need) AddEdge(from, R.HangNode[k], l.With(Req.MEGAMAN, 4), p, sx, sy, 2, R.Points[k][0], R.Points[k][1], gates, pt, ps0, pst);
        foreach (long ck in res.Clings) foreach (var l in need) AddEdge(from, R.PosRegion[ck], l, p, sx, sy, 1, (int)(ck >> 32), (int)(uint)ck, gates, pt, ps0, pst);
        // (the latch crystals it bounced off: on from there, as from a Strike Chain point)
        foreach (int bk in res.Bounces)
            if (bk < R.CrystalNode.Length)
            {
                var c = R.Crystals[bk / 4];
                foreach (var l in need) AddEdge(from, R.CrystalNode[bk], l, p, sx, sy, 3, (c.X0 + c.X1) / 2, (c.Y0 + c.Y1) / 2, gates, pt, ps0, pst);
            }
        // (the flying enemies it came down on: on from there, stomped with the Mario Ability Set)
        foreach (int fk in res.Stomps)
            if (fk < R.FlyerNode.Length)
            {
                var fl = R.Flyers[fk / 2];
                foreach (var l in need) AddEdge(from, R.FlyerNode[fk], l.With(Req.MARIO, 1), p, sx, sy, 4, (fl.X0 + fl.X1) / 2, fl.Y0, gates, pt, ps0, pst);
            }
        if (res.LandX != int.MinValue && SafeLanding(res.LandX, res.LandY, res.Morph, open))
        {
            int to = RegionAt(res.LandX, res.LandY, res.Morph);
            if (to >= 0) foreach (var l in need) AddEdge(from, to, l, p, sx, sy, 0, res.LandX, res.LandY, gates, pt, ps0, pst, pld);
        }
    }

    // the moves off a wall where the game has wall jumps (side: the wall's, 1 right): kicking off it (away, with a
    // double jump or air dash after), kicking up it, or letting go
    List<Prog> WallPrograms(int side)
    {
        var none = new Req();
        var dj = new Req().With(Req.DJUMP, 1);
        var ad = new Req().With(Req.ADASH, 1);
        return new List<Prog> {
            new Prog { Name = "kickaway", Ch = 1, Dir = side, FromWall = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = -1, HDelay = 1, Label = none },
            new Prog { Name = "kickaway-coast", Ch = 1, Dir = side, FromWall = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 0, HDelay = 1, Label = none },
            new Prog { Name = "kickclimb", Ch = 1, Dir = side, FromWall = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 1, WallMode = 0, MaxT = 160, Label = none },
            new Prog { Name = "kickaway-dj", Ch = 1, Dir = side, FromWall = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = -1, HDelay = 1, DjAt = 10, Label = dj },
            new Prog { Name = "kickaway-ad", Ch = 0, Dir = side, FromWall = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = -1, HDelay = 1, AdAt = 5, AdDir = -side, Label = ad },
            new Prog { Name = "letgo", Ch = 1, Dir = side, FromWall = true, H1 = -1, H2 = -1, Label = none },
        };
    }

    void Launches(List<Pos> ps, List<int> reg, bool morph)
    {
        // off the walls (every 16px up each, and its top)
        var walls = new Dictionary<long, List<int>>();
        for (int i = 0; i < ps.Count; i++)
            if (ps[i].Cling != 0)
            {
                long k = ((long)ps[i].X << 2) | (uint)(ps[i].Cling + 1);
                List<int> l;
                if (!walls.TryGetValue(k, out l)) { l = new List<int>(); walls[k] = l; }
                l.Add(i);
            }
        foreach (var w in walls.Values)
        {
            int topY = w.Min(i => ps[i].Y);
            foreach (int i in w)
            {
                var p = ps[i];
                if (p.Y % 16 != 0 && p.Y != topY) continue;
                foreach (var prog in WallPrograms(p.Cling))
                {
                    var res = Run(prog, p.X, p.Y, p.Gates != 0, false, true, false);
                    R.Sims++;
                    Record(reg[i], prog, res, p.Gates != 0, p.X, p.Y);
                }
            }
        }
        // by region: its places by x (standing ones)
        var byReg = new Dictionary<int, List<int>>();
        for (int i = 0; i < ps.Count; i++)
        {
            if (ps[i].Cling != 0) continue;
            List<int> l;
            if (!byReg.TryGetValue(reg[i], out l)) { l = new List<int>(); byReg[reg[i]] = l; }
            l.Add(i);
        }
        foreach (var kv in byReg)
        {
            int rg = kv.Key;
            var idx = kv.Value;
            int minx = int.MaxValue, maxx = int.MinValue;
            foreach (int i in idx) { minx = Math.Min(minx, ps[i].X); maxx = Math.Max(maxx, ps[i].X); }
            var chosen = new List<int>();
            foreach (int i in idx)
            {
                int x = ps[i].X;
                bool end = x - minx <= 8 || maxx - x <= 8;
                if (x % 16 == 0 || (end && (x - minx) % 4 == 0) || (end && (maxx - x) % 4 == 0)) chosen.Add(i);
            }
            if (chosen.Count == 0) chosen.Add(idx[0]);
            foreach (int i in chosen)
            {
                var p = ps[i];
                bool runL = R_has(rg, p.X + 24, p.Y, morph), runR = R_has(rg, p.X - 24, p.Y, morph);
                bool onPlat = !morph && (R.Plat.Row(p.Y - 1, p.X - 7, p.X + 6) || R.GhostB.Row(p.Y - 1, p.X - 7, p.X + 6)) && !R.SolidC.Row(p.Y - 1, p.X - 7, p.X + 6);
                bool nearSpring = !morph && R.Springs.Any(sp => p.X + 2 >= sp.S.X0 && p.X - 2 <= sp.S.X1 && Math.Abs(sp.S.Y1 + 1 - p.Y) <= 8);
                bool onFade = R.Fades.Count > 0 && R.Fades.Any(f => f.Hits(p.X - 7, p.Y - 1, p.X + 6, p.Y - 1));
                // (a latch crystal within a jump or two)
                bool nearCrystal = !morph && R.Crystals.Any(c => Math.Abs((c.X0 + c.X1) / 2 - p.X) <= 240 && Math.Abs((c.Y0 + c.Y1) / 2 - p.Y) <= 240);
                // (a Mario enemy on the ground within a jump or a drop)
                bool nearStomper = !morph && R.Stompers.Any(z => p.X >= z[0] - 160 && p.X <= z[1] + 160 && z[2] - p.Y <= 80 && p.Y - z[2] <= 240);
                foreach (var prog in Programs(morph, onPlat, runL, runR, nearSpring, onFade, nearCrystal, nearStomper))
                {
                    // (a move that turns into the Morph Ball where it meets a wall, or back once there's room, and didn't:
                    // the same as the move without; one that attacks and never bounced off a crystal, the same as the jump)
                    bool auto = prog.AutoMorph || prog.AutoUnmorph;
                    var res = Run(prog, p.X, p.Y, p.Gates != 0, morph, false, false);
                    R.Sims++;
                    if ((!auto || res.Morphed) && (prog.Weapon < 0 || res.Pogos > 0)) Record(rg, prog, res, p.Gates != 0, p.X, p.Y);
                    if (R.Gates.Count > 0 && p.Gates == 0)
                    {
                        var r2 = Run(prog, p.X, p.Y, true, morph, false, false);
                        R.Sims++;
                        if (r2.Gates != 0 && (!auto || r2.Morphed) && (prog.Weapon < 0 || r2.Pogos > 0)) Record(rg, prog, r2, true, p.X, p.Y);
                    }
                }
            }
            // (a travel cannon the body touches from a place of the region: got into, pressing up, and fired)
            if (!morph)
                for (int ci = 0; ci < R.Cannons.Count; ci++)
                {
                    var cn = R.Cannons[ci];
                    int at = -1;
                    foreach (int i in idx) if (cn.S.Hits(ps[i].X - 7, ps[i].Y - 40, ps[i].X + 6, ps[i].Y - 1)) { at = i; break; }
                    if (at < 0) continue;
                    var p = ps[at];
                    foreach (var prog in CannonPrograms(ci))
                    {
                        var res = Run(prog, p.X, p.Y, p.Gates != 0, false, false, false);
                        R.Sims++;
                        Record(rg, prog, res, p.Gates != 0, p.X, p.Y);
                        if (R.Gates.Count > 0 && p.Gates == 0)
                        {
                            var r2 = Run(prog, p.X, p.Y, true, false, false, false);
                            R.Sims++;
                            if (r2.Gates != 0) Record(rg, prog, r2, true, p.X, p.Y);
                        }
                    }
                }
        }
    }

    bool R_has(int region, int x, int y, bool morph)
    {
        var map = morph ? R.MPosRegion : R.PosRegion;
        int r;
        for (int dy = -8; dy <= 8; dy++) if (map.TryGetValue(Shape.Key(x, y + dy), out r) && r == region) return true;
        return false;
    }

    // coming into the room at (x,y): falling from there, steering or not, or with a double jump or air dash
    void EntrySims(int node, int ex, int ey)
    {
        bool morph = false;
        int sy = ey;
        if (!Clear(R.SolidC, ex, sy, 40))
        {
            bool found = false;
            for (int dy = 1; dy <= 8 && !found; dy++) if (Clear(R.SolidC, ex, ey - dy, 40)) { sy = ey - dy; found = true; }
            if (!found)
            {
                if (Clear(R.SolidC, ex, ey, 13)) morph = true;
                else { R.Log.Add("entry " + ex + "," + ey + " is inside a solid"); R.BadEntries.Add(ex + "," + ey); return; }
            }
        }
        var progs = new List<Prog>();
        var none = new Req();
        var dj = new Req().With(Req.DJUMP, 1);
        var ad = new Req().With(Req.ADASH, 1);
        foreach (int h in new[] { 0, 1, -1 })
            progs.Add(new Prog { Name = "enter", Ch = 1, Dir = 1, H1 = h, H2 = h, Label = none, Morph = morph, Entering = true });
        if (!morph)
            foreach (int d in new[] { -1, 1 })
            {
                progs.Add(new Prog { Name = "enterdj", Ch = 1, Dir = d, DjAt = 3, H1 = 1, H2 = 1, Label = dj, Entering = true });
                progs.Add(new Prog { Name = "enterad", Ch = 0, Dir = d, AdAt = 3, H1 = 1, H2 = 1, Label = ad, Entering = true });
            }
        var samus2 = new Req().With(Req.SAMUS, 2);
        foreach (var p in progs)
        {
            if (morph) p.Label = Req.Max(p.Label, samus2);
            // standing already?
            bool standing = (morph ? R.MPosRegion : R.PosRegion).ContainsKey(Shape.Key(ex, sy));
            if (standing && p.H1 == 0)
            {
                int r0 = RegionAt(ex, sy, morph);
                if (r0 >= 0) AddEdge(node, r0, p.Label, "standing where they come in, at " + ex + "," + sy + (morph ? " as the Morph Ball" : ""));
            }
            var res = Run(p, ex, sy, false, morph, !standing, false);
            Record(node, p, res, false, ex, sy);
            if (R.Gates.Count > 0)
            {
                var r2 = Run(p, ex, sy, true, morph, !standing, false);
                if (r2.Gates != 0) Record(node, p, r2, true, ex, sy);
            }
        }
    }

    // push rocks: the player gets beside one where it rests (on its floor) and pushes it where it's needed, then stands on
    // it there (a place every 8px of its way, each end too) and moves off it, with the rock there as a solid under the
    // player
    void RockMoves()
    {
        foreach (var rk in R.Rocks)
        {
            int hub = R.NNodes++;
            R.NodeName[hub] = "beside the push rock (from " + rk.From + "), to push it";
            var seen = new HashSet<int>();
            foreach (var kv in R.PosRegion)
            {
                int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key;
                if (y != rk.Y + rk.H + 2 || !(Math.Abs(x - (rk.X - 7)) <= 3 || Math.Abs(x - (rk.X + rk.W + 8)) <= 3)) continue;
                if (seen.Add(kv.Value)) AddEdge(kv.Value, hub, new Req(), "get beside the push rock (from " + rk.From + "), at " + x + "," + y);
            }
            if (seen.Count == 0) continue;
            int lastX = int.MinValue, lastY = int.MinValue;
            var sorted = rk.Places.OrderBy(c => c[1]).ThenBy(c => c[0]).ToList();
            for (int i = 0; i < sorted.Count; i++)
            {
                var c = sorted[i];
                bool end = i == sorted.Count - 1 || sorted[i + 1][1] != c[1] || sorted[i + 1][0] != c[0] + 1;
                bool start = i == 0 || sorted[i - 1][1] != c[1] || sorted[i - 1][0] != c[0] - 1;
                if (!start && !end && c[1] == lastY && c[0] - lastX < 8) continue;
                lastX = c[0]; lastY = c[1];
                int node = R.NNodes++;
                int py = c[1] + 1;
                R.NodeName[node] = "on the push rock (from " + rk.From + "), pushed to " + c[0] + "," + c[1] + " (its top at y " + c[1] + ")";
                AddEdge(hub, node, new Req(), "push the rock (from " + rk.From + ") to " + c[0] + "," + c[1] + " and climb onto it");
                var box = new[] { c[0], c[0] + rk.W, c[1], c[1] + rk.H };
                foreach (int px in new[] { c[0], c[0] + rk.W / 2, c[0] + rk.W })
                {
                    if (!Clear(R.SolidC, px, py, 40)) continue;
                    foreach (var prog in Programs(false, false, false, false))
                    {
                        if (prog.AutoMorph || prog.AutoUnmorph) continue;
                        var res = Run(prog, px, py, false, false, false, false, box);
                        R.Sims++;
                        Record(node, prog, res, false, px, py);
                    }
                }
            }
        }
    }

    // elevators (oUseElevator, Zelda II's): the player stands on its lower bar (the elevator's y; the player's y one below
    // it) between its two bars, and rides it up or down its shaft holding up or down. It goes up while the row 52px above
    // its y is clear of solids across its 32px (x-16 to x+15), and down while its own row is. Its top bar keeps the
    // player from jumping off: they walk off where a floor beside the shaft is level with it. It comes to the height the
    // player comes into the room at, so it's there for every way in; riding it touches what its shaft passes (an exit at
    // an end of the shaft). A wider one (Neo Grime City's Chaos elevators) has its half width, the height of its cabin
    // (its ceiling over its floor) and the floors it stops at: the player steps on and off it only there (the cabin's
    // walls shut while it goes)
    void Elevators()
    {
        foreach (var e in R.Elevators)
        {
            int ex = e[0], ey = e[1];
            int hw = e.Length > 3 ? e[2] : 16, cab = e.Length > 3 ? e[3] : 52;
            var floors = e.Skip(4).ToList();
            int top = ey, bot = ey;
            if (floors.Count > 0) { top = floors.Min(); bot = floors.Max(); }
            else
            {
                while (top > -64 && !R.SolidC.Row(top - cab, ex - hw, ex + hw - 1)) top--;
                while (bot < R.Data.H + 64 && !R.SolidC.Row(bot, ex - hw, ex + hw - 1)) bot++;
            }
            int node = R.NNodes++;
            R.NodeName[node] = "riding the elevator at x " + ex + " (its bar from y " + top + " to " + bot + ")";
            // on and off it: standing beside its shaft (the body over its columns), level with its bar (at a floor)
            var seen = new HashSet<int>();
            foreach (var kv in R.PosRegion)
            {
                int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key;
                if (x + 6 < ex - hw || x - 7 > ex + hw - 1 || y - 1 < top || y - 1 > bot) continue;
                if (floors.Count > 0 && !floors.Contains(y - 1)) continue;
                if (!seen.Add(kv.Value)) continue;
                AddEdge(kv.Value, node, new Req(), "step onto the elevator at " + x + "," + y);
                AddEdge(node, kv.Value, new Req(), "ride the elevator to where its bar is at y " + (y - 1) + ", and step off it to " + x + "," + y);
            }
            // (one stopping at its floors may rest above the floor beside it (Neo Grime City B's lowest, 48px up): a jump up
            // onto it from beside its shaft, up to 48px, and a drop off it, up to 64px; the body's way between clear: up
            // or down at the player's place, across at the elevator's height)
            Func<int, int, int, int, bool> clear = (ya, yb, xa, xb) => { for (int yy = ya; yy <= yb; yy++) if (R.SolidC.Row(yy, xa, xb)) return false; return true; };
            foreach (int f in floors)
            {
                var seenF = new HashSet<int>();
                foreach (var kv in R.PosRegion)
                {
                    int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key;
                    if (x + 6 < ex - hw - 24 || x - 7 > ex + hw + 23 || y - 1 <= f || y - 1 > f + 64) continue;
                    // (beside its shaft, not under its cabin: its floor is solid from below)
                    if (x + 6 >= ex - hw && x - 7 <= ex + hw - 1) continue;
                    int cx = Math.Max(ex - hw + 7, Math.Min(ex + hw - 8, x));
                    if (!clear(f + 1 - 48, y - 2, x - 7, x + 6) || !clear(f + 1 - 48, f - 1, Math.Min(x, cx) - 7, Math.Max(x, cx) + 6)) continue;
                    if (!seenF.Add(kv.Value)) continue;
                    if (y - 1 <= f + 48) AddEdge(kv.Value, node, new Req(), "jump up onto the elevator resting at y " + f + ", from " + x + "," + y);
                    AddEdge(node, kv.Value, new Req(), "ride the elevator to y " + f + ", and drop off it to " + x + "," + y);
                }
            }
            // coming into the room in its shaft: on it
            foreach (var kv in R.EntryNode)
            {
                int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key;
                if (Math.Abs(x - ex) <= hw && y >= top - 2 && y <= bot + 2) AddEdge(kv.Value, node, new Req(), "come in on the elevator, at " + x + "," + y);
            }
            // what riding it touches: the player's box at each height of its bar
            for (int y = top; y <= bot; y++)
            {
                int bx0, by0, bx1, by1;
                StandBox(ex, y + 1, out bx0, out by0, out bx1, out by1);
                for (int k = 0; k < R.Locs.Count; k++)
                    if (R.Locs[k].S.Hits(bx0, by0, bx1, by1)) AddTouch(node, 0, k, new Req(), "ride the elevator to where its bar is at y " + y + ": touches it");
                for (int k = 0; k < R.Exits.Count; k++)
                    if (R.Exits[k].Type == 1 && R.Exits[k].S.Hits(bx0, by0, bx1, by1)) AddTouch(node, 1, k, new Req(), "ride the elevator to where its bar is at y " + y + ": goes into it");
            }
        }
    }
}

// ---------------------------------------------------------------- the whole game
static class Program
{
    static List<RoomData> Rooms = new List<RoomData>();
    static Dictionary<string, int> RoomIx = new Dictionary<string, int>();
    static string StartRoom; static int StartX, StartY;
    static HashSet<string> Via = new HashSet<string>();   // "from>to": going through that exit is a boss fight
    static List<KeyValuePair<string, int>> CarryStart = new List<KeyValuePair<string, int>>();   // the carried states as a new game starts
    static Dictionary<string, string> CarryScope = new Dictionary<string, string>();   // a carried state kept only within some rooms: their name prefix

    static double D(string s) { return double.Parse(s, CultureInfo.InvariantCulture); }

    static void Read(string path)
    {
        RoomData cur = null;
        foreach (var line in File.ReadAllLines(path))
        {
            if (line.Length == 0) continue;
            var f = line.Split('\t');
            if (f[0] == "START") { StartRoom = f[1]; StartX = int.Parse(f[2]); StartY = int.Parse(f[3]); continue; }
            if (f[0] == "BV") { Via.Add(f[1] + ">" + f[2]); continue; }
            if (f[0] == "CARRY") { CarryStart.Add(new KeyValuePair<string, int>(f[1], int.Parse(f[2]))); if (f.Length > 3) CarryScope[f[1]] = f[3]; continue; }
            if (f[0] == "R")
            {
                cur = new RoomData { Name = f[1], W = int.Parse(f[2]), H = int.Parse(f[3]), Area = int.Parse(f[4]), AreaName = f.Length > 5 ? f[5] : "" };
                RoomIx[cur.Name] = Rooms.Count; Rooms.Add(cur); continue;
            }
            if (cur == null) continue;
            if (f[0] == "Q") { cur.IsMap = true; continue; }
            if (f[0] == "QW") { cur.WalkMap = true; continue; }
            if (f[0] == "B") { cur.Boss = true; continue; }
            if (f[0] == "M") continue;
            // (a carried state: CG; what the room sets it to as the player comes in: RS, or RG where the room has nothing
            // the state changes; RBAUTO: enemies' shots or traps hit the red/blue switches)
            if (f[0] == "CG")
            {
                cur.Carried.Add(f[1]);
                if (f[1] == "water") { cur.Group("w1"); cur.Group("w3"); } else cur.Group(f[1]);
                continue;
            }
            if (f[0] == "RS")
            {
                int v = int.Parse(f[2]);
                cur.Resets[f[1]] = v;
                if (f[1] == "water") { cur.Group("w1"); cur.Group("w3"); cur.Initial = cur.WithLevel(cur.Initial, v); }
                else { int gi = cur.Group(f[1]); if (v == 1) cur.Initial |= 1 << gi; else cur.Initial &= ~(1 << gi); }
                continue;
            }
            if (f[0] == "RG") { cur.Resets[f[1]] = int.Parse(f[2]); continue; }
            // (WS x y group state: coming in at x,y, the room's that group is in that state; a line there only in one
            // state of a group: "@group=state" in front of it)
            if (f[0] == "WS")
            {
                long wk = Shape.Key((int)Math.Round(D(f[1])), (int)Math.Round(D(f[2])));
                List<int[]> wl;
                if (!cur.WayIn.TryGetValue(wk, out wl)) { wl = new List<int[]>(); cur.WayIn[wk] = wl; }
                wl.Add(new[] { cur.Group(f[3]), int.Parse(f[4]) });
                continue;
            }
            int condG = -1, condV = 0;
            if (f[0].StartsWith("@"))
            {
                var c = f[0].Substring(1).Split('=');
                condG = cur.Group(c[0]); condV = int.Parse(c[1]);
                f = f.Skip(1).ToArray();
            }
            if (f[0] == "PI")
            {
                // (where it starts; with xThres, newX, newY and rev: put at newX,newY when the player comes in past
                // xThres, before it with rev)
                var pi = f.Skip(1).Select(v => (int)Math.Round(D(v))).ToArray();
                cur.Partner.Add(pi.Length >= 6 ? pi : new[] { pi[0], pi[1], int.MaxValue, pi[0], pi[1], 0 });
                continue;
            }
            if (f[0] == "RBAUTO") { cur.RbAuto = true; continue; }
            // (a switch: SW, kept as w; a state's solid: T, its group's number in F[0]; water in one of the Water Palace's
            // levels: TW, kept as y; a floating platform: FP, kept as f; a fan: FN, kept as n, a switch's group's number
            // in F[1]; a hazard something makes harmless: HV, kept as v; a latch crystal: LC, kept as c; a falling pillar:
            // FL, kept as q; a solid there part of the time: TS, kept as z; a travel cannon: TC, kept as o; a Mario enemy on
            // the ground: FG, kept as e)
            var it = new Inst { K = f[0] == "SW" ? 'w' : f[0] == "KR" ? 'k' : f[0] == "PR" ? 'r' : f[0] == "TW" ? 'y' : f[0] == "FP" ? 'f' : f[0] == "SP" ? 's' : f[0] == "FN" ? 'n' : f[0] == "HV" ? 'v' : f[0] == "LC" ? 'c' : f[0] == "FL" ? 'q' : f[0] == "TS" ? 'z' : f[0] == "TC" ? 'o' : f[0] == "FG" ? 'e' : f[0][0],
                Spr = f[1], X = D(f[2]), Y = D(f[3]), XS = D(f[4]), YS = D(f[5]), A = D(f[6]), F = f.Skip(7).ToArray() };
            if (it.K == 'w' && it.F[0] == "water") { cur.Group("w3"); it.F = new[] { cur.Group("w1").ToString(), "water", it.F[1] }; }
            else if (it.K == 'T' || it.K == 'w' || it.K == 'U') it.F[0] = cur.Group(it.F[0]).ToString();
            else if (it.K == 'n' && it.F.Length >= 3) it.F[1] = cur.Group(it.F[1]).ToString();
            // (an exit whose way goes by a carried group: its group's number in F[5])
            else if (it.K == 'X' && it.F.Length >= 7) it.F[5] = cur.Group(it.F[5]).ToString();
            if (it.K == 'y') { cur.Group("w1"); cur.Group("w3"); }
            it.CondG = condG; it.CondV = condV;
            cur.I.Add(it);
        }
    }

    // RoomLogic.exe --test: jumps on a flat floor (for checking the movement against the game's)
    static void Test()
    {
        Sim.Slack = 1;
        var rd = new RoomData { Name = "test", W = 2000, H = 400, Area = 1 };
        var room = new Room(rd);
        room.SolidC = new Bits2D(2000, 400); room.SolidO = room.SolidC; room.Plat = new Bits2D(2000, 400);
        room.Haz = new Bits2D(2000, 400); room.Water = new Bits2D(2000, 400); room.GhostB = new Bits2D(2000, 400); room.HazV = new Bits2D(2000, 400);
        for (int x = -320; x < 2320; x++) for (int y = 300; y < 400; y++) room.SolidC.Set(x, y);
        var tests = new[] {
            new Prog { Name = "jump21", Ch = 0, Dir = 1, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 0, HDelay = 0 },
            new Prog { Name = "jump6", Ch = 0, Dir = 1, JumpAt = 0, JumpHold = 6, H1 = 0, H2 = 0 },
            new Prog { Name = "runjump21 claire", Ch = 1, Dir = 1, RunStart = true, JumpAt = 0, JumpHold = 21, H1 = 1, H2 = 1 },
            new Prog { Name = "dj10", Ch = 0, Dir = 1, JumpAt = 0, JumpHold = 21, DjAt = 10, H1 = 0, H2 = 0, Label = new Req().With(Req.DJUMP, 1) },
            new Prog { Name = "ad10 jerry", Ch = 0, Dir = 1, JumpAt = 0, JumpHold = 21, AdAt = 10, H1 = 1, H2 = 1, Label = new Req().With(Req.ADASH, 1) },
            new Prog { Name = "dashjump2 jerry", Ch = 0, Dir = 1, GdAt = 0, JumpAt = 2, JumpHold = 21, H1 = 1, H2 = 1, Label = new Req().With(Req.GDASH, 1) },
            new Prog { Name = "bounce12 (a stomp at tick 12)", Ch = 1, Dir = 1, JumpAt = 0, JumpHold = 40, BounceAt = 12, H1 = 0, H2 = 0, Label = new Req().With(Req.MARIO, 1) },
            new Prog { Name = "dj14 (at the top)", Ch = 1, Dir = 1, JumpAt = 0, JumpHold = 21, DjAt = 14, H1 = 0, H2 = 0, Label = new Req().With(Req.DJUMP, 1) },
            new Prog { Name = "dj14 ad26 claire", Ch = 1, Dir = 1, JumpAt = 0, JumpHold = 21, DjAt = 14, AdAt = 26, H1 = 1, H2 = 1, Label = Req.Max(new Req().With(Req.DJUMP, 1), new Req().With(Req.ADASH, 1)) },
        };
        foreach (var p in tests)
        {
            var s = new Sim { R = room, S = room.SolidC, x = 200, y = 301, ch = p.Ch, facing = 1, state = Sim.STANDING };
            s.runAcc = p.Ch == 0 ? 6.6 : 7.3; s.jumpTime = s.jtt; s.gi = s.grav;
            s.hasDJ = p.Label.Get(Req.DJUMP) > 0; s.hasAD = p.Label.Get(Req.ADASH) > 0; s.hasGD = p.Label.Get(Req.GDASH) > 0;
            if (p.RunStart) { s.xVel = 7.3; s.state = Sim.RUNNING; s.kR = true; s.kRSteps = 5; }
            int minY = 301; var path = new StringBuilder();
            bool prevJ = false; var inp = new In();
            for (int t = 0; t < 60; t++)
            {
                int hd = (t < p.HDelay ? p.H1 : p.H2) * p.Dir;
                inp.L = hd < 0; inp.R = hd > 0;
                bool j = p.JumpAt >= 0 && t >= p.JumpAt && t < p.JumpAt + p.JumpHold;
                if (p.DjAt >= 0) { if (t == p.DjAt - 1) j = false; if (t >= p.DjAt && t < p.DjAt + p.DjHold) j = true; }
                inp.J = j; prevJ = j;
                inp.DL = false; inp.DR = (p.GdAt == t) || (p.AdAt == t);
                if (p.AdAt == t) inp.R = true;
                if (p.BounceAt == t && s.InAir) s.Stomp();
                s.Step(inp);
                minY = Math.Min(minY, s.y);
                path.Append("(" + (s.x - 200) + "," + (301 - s.y) + ")");
                if (t > 0 && s.OnGround) break;
            }
            Console.WriteLine("{0}: height {1}, landed x+{2}  {3}", p.Name, 301 - minY, s.x - 200, path);
        }
    }

    // RoomLogic.exe --draw <project> <rooms.txt> <room> <out.png> [<roomlogic.txt>]: a picture of a room as the logic sees
    // it (solids grey, gates orange, platforms blue, hazards red, water cyan, standing places by region, locations green,
    // exits yellow, entries magenta), with each region's needs from roomlogic.txt's "region" lines if given
    static void Draw(string[] args)
    {
        Mask.Root = args[1];
        Read(args[2]);
        var rd = Rooms[RoomIx[args[3]]];
        // (a room with switch states: the one given after --state, else the one it starts in)
        int si = Array.IndexOf(args, "--state");
        string regName = rd.Name;
        if (rd.Groups.Count > 0)
        {
            int brk = rd.Groups.IndexOf("brk");
            if (brk >= 0 && brk < rd.MaxG) rd.KeepSolid = BricksKept(rd, brk);
            int st = si > 0 ? int.Parse(args[si + 1]) : rd.Initial;
            if (st != (rd.Initial & ((1 << rd.MaxG) - 1))) regName = rd.Name + "@" + st;
            rd = StateData(rd, st);
        }
        if (si > 0) args = args.Take(si).ToArray();
        var room = new Room(rd);
        foreach (var o in Rooms)
            foreach (var it in o.I)
            {
                if (it.K == 'X' && it.F[0] == rd.Name) room.Entries.Add(new[] { (int)Math.Round(D(it.F[1])), (int)Math.Round(D(it.F[2])) });
                if (it.K == 'D' && o.Name == rd.Name) room.Entries.Add(new[] { (int)Math.Round(D(it.F[0])), (int)Math.Round(D(it.F[1])) });
            }
        if (rd.Name == StartRoom) room.Entries.Add(new[] { StartX, StartY });
        Analyzer.NoPillarStates = true;
        new Analyzer(room).Analyze();
        var needs = new Dictionary<int, string>();
        if (args.Length > 5)
            foreach (var l in File.ReadAllLines(args[5]))
            {
                var f = l.Split(' ');
                if (f.Length == 4 && f[0] == "region" && f[1] == regName) needs[int.Parse(f[2])] = f[3];
            }
        int W = rd.W, H = rd.H;
        using (var bmp = new Bitmap(W, H))
        {
            var px = new int[W * H];
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++)
                {
                    int c = unchecked((int)0xFF101018);
                    if (room.Water.Get(x, y)) c = unchecked((int)0xFF103848);
                    if (room.SolidO.Get(x, y)) c = unchecked((int)0xFF707070);
                    else if (room.SolidC.Get(x, y)) c = unchecked((int)0xFFE08020);
                    if (room.Plat.Get(x, y)) c = unchecked((int)0xFF4060E0);
                    if (room.GhostB.Get(x, y)) c = unchecked((int)0xFF304890);
                    if (room.Haz.Get(x, y)) c = unchecked((int)0xFFE02020);
                    else if (room.HazV.Get(x, y)) c = unchecked((int)0xFFE08830);
                    px[y * W + x] = c;
                }
            Func<int, int> regColor = r => { uint h = (uint)(r * 2654435761u); return unchecked((int)(0xFF000000u | ((h & 0x7F7F7Fu) + 0x606060u))); };
            foreach (var kv in room.PosRegion)
            {
                int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key - 1;
                if (x >= 0 && x < W && y >= 0 && y < H) px[y * W + x] = regColor(kv.Value);
            }
            foreach (var kv in room.MPosRegion)
            {
                int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key - 3;
                if (x >= 0 && x < W && y >= 0 && y < H && !room.PosRegion.ContainsKey(kv.Key)) px[y * W + x] = unchecked((int)0xFFFF80FF);
            }
            Action<Shape, int> fill = (s, c) => { foreach (var k in s.Px) { int x = (int)(k >> 32), y = (int)(uint)k; if (x >= 0 && x < W && y >= 0 && y < H) px[y * W + x] = c; } };
            foreach (var l in room.Locs) fill(l.S, unchecked((int)0xFF20FF40));
            foreach (var e in room.Exits) fill(e.S, e.InRoom ? unchecked((int)0xFFC0C000) : unchecked((int)0xFFFFFF00));
            foreach (var s in room.Springs) fill(s.S, unchecked((int)0xFF00FFFF));
            foreach (var c in room.Cannons) fill(c.S, unchecked((int)0xFFFF8000));
            foreach (var f in room.Flyers) fill(f, unchecked((int)0xFFFF40A0));
            foreach (var e in room.Entries) for (int dx = -3; dx <= 3; dx++) for (int dy = -3; dy <= 3; dy++) { int x = e[0] + dx, y = e[1] - 20 + dy; if (x >= 0 && x < W && y >= 0 && y < H) px[y * W + x] = unchecked((int)0xFFFF00FF); }
            var data = bmp.LockBits(new Rectangle(0, 0, W, H), ImageLockMode.WriteOnly, PixelFormat.Format32bppArgb);
            for (int y = 0; y < H; y++) System.Runtime.InteropServices.Marshal.Copy(px, y * W, data.Scan0 + y * data.Stride, W);
            bmp.UnlockBits(data);
            using (var g = Graphics.FromImage(bmp))
            using (var font = new Font("Arial", 9))
            {
                // each region's number (and needs) at its leftmost place
                var first = new Dictionary<int, long>();
                foreach (var kv in room.PosRegion) { long cur; if (!first.TryGetValue(kv.Value, out cur) || (kv.Key >> 32) < (cur >> 32)) first[kv.Value] = kv.Key; }
                foreach (var kv in first)
                {
                    string label = kv.Key.ToString();
                    string nd; if (needs.TryGetValue(kv.Key, out nd)) label += " " + nd;
                    g.DrawString(label, font, Brushes.White, (int)(kv.Value >> 32), (int)(uint)kv.Value - 14);
                }
                for (int i = 0; i < room.Locs.Count; i++)
                    g.DrawString("L" + room.Locs[i].Type + "." + room.Locs[i].Num, font, Brushes.LightGreen, room.Locs[i].S.X1 + 2, room.Locs[i].S.Y0);
                for (int i = 0; i < room.Exits.Count; i++)
                    g.DrawString((room.Exits[i].InRoom ? "door " : "") + room.Exits[i].To + " t" + room.Exits[i].Type, font, Brushes.Yellow, room.Exits[i].S.X0, room.Exits[i].S.Y0 - 12);
            }
            if (args.Length > 9)
            {
                // a part of it: x y width height
                int cx = int.Parse(args[6]), cy = int.Parse(args[7]), cw = int.Parse(args[8]), ch = int.Parse(args[9]);
                cx = Math.Max(0, Math.Min(W - 1, cx)); cy = Math.Max(0, Math.Min(H - 1, cy));
                cw = Math.Min(cw, W - cx); ch = Math.Min(ch, H - cy);
                using (var part = bmp.Clone(new Rectangle(cx, cy, cw, ch), bmp.PixelFormat)) part.Save(args[4], ImageFormat.Png);
            }
            else bmp.Save(args[4], ImageFormat.Png);
        }
        Console.WriteLine("{0}: {1} regions, {2} edges, {3} touches, {4} moves; log: {5}", rd.Name, room.NRegions, room.Edges.Count, room.Touches.Count, room.Sims, string.Join(" / ", room.Log));
    }

    // RoomLogic.exe --trace <project> <rooms.txt> <room> <x> <y> <move> [dir] [--state N]: one move from a standing place,
    // tick by tick (in a room with switch states, the one given, else the one it starts in)
    static void Trace(string[] args)
    {
        Mask.Root = args[1];
        Read(args[2]);
        var rd = Rooms[RoomIx[args[3]]];
        // (--slack N: the jumps' strength, the game's own at 1)
        int sl = Array.IndexOf(args, "--slack");
        if (sl > 0) { Sim.Slack = D(args[sl + 1]); args = args.Take(sl).Concat(args.Skip(sl + 2)).ToArray(); }
        int si = Array.IndexOf(args, "--state");
        if (rd.Groups.Count > 0)
        {
            int brk = rd.Groups.IndexOf("brk");
            if (brk >= 0 && brk < rd.MaxG) rd.KeepSolid = BricksKept(rd, brk);
            rd = StateData(rd, si > 0 ? int.Parse(args[si + 1]) : rd.Initial);
        }
        if (si > 0) args = args.Take(si).ToArray();
        var room = new Room(rd);
        var an = new Analyzer(room);
        an.TraceMove(int.Parse(args[4]), int.Parse(args[5]), args[6], args.Length > 7 ? int.Parse(args[7]) : 1);
    }

    // RoomLogic.exe --move <project> <rooms.txt> <room> <x> <y> [name=value ...] [--slack S] [--state N]: one move, Prog's
    // fields by name (ch dir run jumpAt jumpHold h1 h2 hDelay djAt djHold adAt adDir gdAt hiJump maxT noInputTillAir
    // dropDown morphAt bounceAt wallMode autoMorph autoUnmorph bombJump, need=dj,ad,gd for what it may use; air=1 starts
    // it falling, morph=1 as the Morph Ball, open=1 with the gates open; fps=30|60|120 the frame rate, dither=N the pixel
    // rounding's start above 30fps),
    // from x,y, tick by tick (Analyzer.MoveSpec)
    static void MoveCmd(string[] args)
    {
        Mask.Root = args[1];
        Read(args[2]);
        var rd = Rooms[RoomIx[args[3]]];
        int sl = Array.IndexOf(args, "--slack");
        if (sl > 0) { Sim.Slack = D(args[sl + 1]); args = args.Take(sl).Concat(args.Skip(sl + 2)).ToArray(); }
        int si = Array.IndexOf(args, "--state");
        if (rd.Groups.Count > 0)
        {
            int brk = rd.Groups.IndexOf("brk");
            if (brk >= 0 && brk < rd.MaxG) rd.KeepSolid = BricksKept(rd, brk);
            rd = StateData(rd, si > 0 ? int.Parse(args[si + 1]) : rd.Initial);
        }
        if (si > 0) args = args.Take(si).ToArray();
        var p = new Prog { Name = "move", Label = new Req() };
        bool air = false, morph = false, open = false;
        foreach (var a in args.Skip(6))
        {
            int eq = a.IndexOf('=');
            if (eq < 0) { Console.WriteLine("ERROR not name=value: " + a); return; }
            string k = a.Substring(0, eq), v = a.Substring(eq + 1);
            switch (k)
            {
                case "ch": p.Ch = int.Parse(v); break;
                case "dir": p.Dir = int.Parse(v); break;
                case "run": p.RunStart = v == "1"; break;
                case "jumpAt": p.JumpAt = int.Parse(v); break;
                case "jumpHold": p.JumpHold = int.Parse(v); break;
                case "h1": p.H1 = int.Parse(v); break;
                case "h2": p.H2 = int.Parse(v); break;
                case "hDelay": p.HDelay = int.Parse(v); break;
                case "djAt": p.DjAt = int.Parse(v); break;
                case "djHold": p.DjHold = int.Parse(v); break;
                case "adAt": p.AdAt = int.Parse(v); break;
                case "adDir": p.AdDir = int.Parse(v); break;
                case "gdAt": p.GdAt = int.Parse(v); break;
                case "hiJump": p.HiJump = int.Parse(v); break;
                case "maxT": p.MaxT = int.Parse(v); break;
                case "noInputTillAir": p.NoInputTillAir = v == "1"; break;
                case "dropDown": p.DropDown = v == "1"; break;
                case "morphAt": p.MorphAt = int.Parse(v); break;
                case "weapon": p.Weapon = int.Parse(v); break;
                case "atkAt": p.AtkAt = int.Parse(v); break;
                case "atkEvery": p.AtkEvery = int.Parse(v); break;
                case "bounceAt": p.BounceAt = int.Parse(v); break;
                case "wallMode": p.WallMode = int.Parse(v); break;
                case "fromHang": p.FromHang = v == "1"; break;
                case "hangDrop": p.HangDrop = v == "1"; break;
                case "afterBounce": p.AfterBounce = v == "1"; break;
                case "stomp": p.Stomp = v == "1"; break;
                case "fromWall": p.FromWall = v == "1"; break;
                case "fps": p.Dt = 30.0 / int.Parse(v); break;
                case "dither": p.Dither = int.Parse(v); break;
                case "oldexe": Sim.OldExe = v == "1"; break;
                case "autoMorph": p.AutoMorph = v == "1"; break;
                case "autoUnmorph": p.AutoUnmorph = v == "1"; break;
                case "bombJump": p.BombJump = v == "1"; break;
                case "air": air = v == "1"; break;
                case "morph": morph = v == "1"; break;
                case "open": open = v == "1"; break;
                case "need":
                    foreach (var n in v.Split(','))
                    {
                        if (n == "dj") p.Label = p.Label.With(Req.DJUMP, 1);
                        else if (n == "ad") p.Label = p.Label.With(Req.ADASH, 1);
                        else if (n == "gd") p.Label = p.Label.With(Req.GDASH, 1);
                        else if (n != "") { Console.WriteLine("ERROR need: dj, ad or gd, not " + n); return; }
                    }
                    break;
                default: Console.WriteLine("ERROR a field that isn't known: " + k); return;
            }
        }
        new Analyzer(new Room(rd)).MoveSpec(int.Parse(args[4]), int.Parse(args[5]), p, air, morph, open);
    }

    // RoomLogic.exe --edges <project> <rooms.txt> <room>: a room's regions' joins (from > to: needs) and what they touch
    static void Edges(string[] args)
    {
        Mask.Root = args[1];
        Read(args[2]);
        var rd = Rooms[RoomIx[args[3]]];
        var room = new Room(rd);
        foreach (var o in Rooms)
            foreach (var it in o.I)
            {
                if (it.K == 'X' && it.F[0] == rd.Name) room.Entries.Add(new[] { (int)Math.Round(D(it.F[1])), (int)Math.Round(D(it.F[2])) });
                if (it.K == 'D' && o == rd) room.Entries.Add(new[] { (int)Math.Round(D(it.F[0])), (int)Math.Round(D(it.F[1])) });
            }
        if (rd.Name == StartRoom) room.Entries.Add(new[] { StartX, StartY });
        if (rd.Groups.Count > 0) AnalyzeStates(room); else new Analyzer(room).Analyze();
        foreach (var kv in room.EntryNode) Console.WriteLine("entry {0},{1} = node {2}", (int)(kv.Key >> 32), (int)(uint)kv.Key, kv.Value);
        foreach (var kv in room.NodeName.OrderBy(k => k.Key)) Console.WriteLine("node {0}: {1}", kv.Key, kv.Value);
        foreach (var e in room.Edges.OrderBy(e => e.From).ThenBy(e => e.To)) Console.WriteLine("{0} > {1}: {2}   {3}", e.From, e.To, e.L, e.How);
        foreach (var t in room.Touches) Console.WriteLine("{0} touches {1} {2}: {3}   {4}", t.From, t.Kind == 0 ? "location" : "exit", t.Index, t.L, t.How);
        Console.WriteLine("log: " + string.Join(" / ", room.Log));
    }

    // RoomLogic.exe --stones <project> <rooms.txt> <out folder> <room>:<x>,<y>:<number>...: the Teleporting Stones'
    // rooms, each as the main run has it with its stones in it too, each a place (type 98, its number: network*100 +
    // its number in the teleport menu) and a way in (where warping to it puts the player), written as its room file to
    // the out folder (the Check Tracker's ways there with the stones: stones.py, tracker.py; the logic doesn't read them)
    static void Stones(string[] args)
    {
        Mask.Root = args[1];
        Read(args[2]);
        string outDir = Path.GetFullPath(args[3]);
        Directory.CreateDirectory(outDir);
        var byRoom = new Dictionary<string, List<int[]>>();
        foreach (var a in args.Skip(4))
        {
            var p = a.Split(':'); var xy = p[1].Split(',');
            List<int[]> l;
            if (!byRoom.TryGetValue(p[0], out l)) { l = new List<int[]>(); byRoom[p[0]] = l; }
            l.Add(new[] { int.Parse(xy[0]), int.Parse(xy[1]), int.Parse(p[2]) });
        }
        foreach (var kv in byRoom)
        {
            var rd = Rooms[RoomIx[kv.Key]];
            foreach (var s in kv.Value)
                rd.I.Add(new Inst { K = 'L', Spr = "sWarpStatue", X = s[0], Y = s[1], XS = 1, YS = 1, A = 0, F = new[] { "98", s[2].ToString(), "0", "teleporting stone " + s[2] } });
            var room = new Room(rd);
            var cf = new Dictionary<long, List<string>>();
            Action<int, int, string> entry = (x, y, from) =>
            {
                room.Entries.Add(new[] { x, y });
                List<string> l;
                if (!cf.TryGetValue(Shape.Key(x, y), out l)) { l = new List<string>(); cf[Shape.Key(x, y)] = l; }
                if (!l.Contains(from)) l.Add(from);
            };
            // (its ways in as the main run has them: every exit into it, its doors' and the start; then the stones')
            foreach (var o in Rooms)
                foreach (var it in o.I)
                {
                    if (it.K == 'X' && it.F[0] == rd.Name)
                        entry((int)Math.Round(D(it.F[1])), (int)Math.Round(D(it.F[2])), o.Name + (it.F.Length > 4 && it.F[4] == "menu" ? "'s menu" : it.F.Length > 4 && it.F[4] == "encounter" ? "'s encounters" : " out " + (int)Math.Round(it.X) + "," + (int)Math.Round(it.Y)));
                    if (it.K == 'D' && o == rd) entry((int)Math.Round(D(it.F[0])), (int)Math.Round(D(it.F[1])), "this room's door out " + (int)Math.Round(it.X) + "," + (int)Math.Round(it.Y));
                }
            if (rd.Name == StartRoom) entry(StartX, StartY, "the start of a new game");
            foreach (var s in kv.Value) entry(s[0], s[1], "warping to Teleporting Stone " + s[2]);
            try { if (rd.Groups.Count > 0) AnalyzeStates(room); else new Analyzer(room).Analyze(); }
            catch (Exception e) { room.Log.Add("failed: " + e); }
            string file;
            try { file = RoomFile(room, cf); }
            catch (Exception e) { room.Log.Add("failed: the room file: " + e); file = "# " + rd.Name + "\n"; }
            if (room.Log.Any(l => l.StartsWith("failed"))) file = "# THE ANALYSIS FAILED: this file may be missing ways\n" + file;
            File.WriteAllText(Path.Combine(outDir, rd.Name + ".txt"), file);
            Console.WriteLine("{0}: {1} stone(s){2}", rd.Name, kv.Value.Count, room.Log.Any(l => l.StartsWith("failed")) ? ", FAILED: " + string.Join(" / ", room.Log) : "");
        }
    }

    // RoomLogic.exe --probes <project> <rooms.txt> <out folder> <room>:<tag>:<x0>,<y0>,<x1>,<y1>...: rooms as the main run
    // has them, each with boxes in it (spots: reaching one is touching it), written as their room files to the out folder:
    // what getting from each way in to each box takes (a door's way in, the space around a place: perdoor.py, which checks
    // overrides.txt's lines for a whole room door by door; the logic doesn't read them)
    static void Probes(string[] args)
    {
        Mask.Root = args[1];
        Read(args[2]);
        string outDir = Path.GetFullPath(args[3]);
        Directory.CreateDirectory(outDir);
        var byRoom = new Dictionary<string, List<string[]>>();
        foreach (var a in args.Skip(4))
        {
            var p = a.Split(':');
            List<string[]> l;
            if (!byRoom.TryGetValue(p[0], out l)) { l = new List<string[]>(); byRoom[p[0]] = l; }
            l.Add(new[] { p[1], p[2] });
        }
        foreach (var kv in byRoom)
        {
            var rd = Rooms[RoomIx[kv.Key]];
            foreach (var s in kv.Value)
            {
                var b = s[1].Split(',').Select(int.Parse).ToArray();
                rd.I.Add(new Inst { K = 's', Spr = "sInvisibleSolidMask", X = b[0], Y = b[1], XS = (b[2] - b[0]) / 16.0, YS = (b[3] - b[1]) / 16.0, A = 0, F = new[] { s[0] } });
            }
            var room = new Room(rd);
            var cf = new Dictionary<long, List<string>>();
            Action<int, int, string> entry = (x, y, from) =>
            {
                room.Entries.Add(new[] { x, y });
                List<string> l;
                if (!cf.TryGetValue(Shape.Key(x, y), out l)) { l = new List<string>(); cf[Shape.Key(x, y)] = l; }
                if (!l.Contains(from)) l.Add(from);
            };
            // (its ways in as the main run has them: every exit into it, its doors' and the start)
            foreach (var o in Rooms)
                foreach (var it in o.I)
                {
                    if (it.K == 'X' && it.F[0] == rd.Name)
                        entry((int)Math.Round(D(it.F[1])), (int)Math.Round(D(it.F[2])), o.Name + (it.F.Length > 4 && it.F[4] == "menu" ? "'s menu" : it.F.Length > 4 && it.F[4] == "encounter" ? "'s encounters" : " out " + (int)Math.Round(it.X) + "," + (int)Math.Round(it.Y)));
                    if (it.K == 'D' && o == rd) entry((int)Math.Round(D(it.F[0])), (int)Math.Round(D(it.F[1])), "this room's door out " + (int)Math.Round(it.X) + "," + (int)Math.Round(it.Y));
                }
            if (rd.Name == StartRoom) entry(StartX, StartY, "the start of a new game");
            try { if (rd.Groups.Count > 0) AnalyzeStates(room); else new Analyzer(room).Analyze(); }
            catch (Exception e) { room.Log.Add("failed: " + e); }
            string file;
            try { file = RoomFile(room, cf); }
            catch (Exception e) { room.Log.Add("failed: the room file: " + e); file = "# " + rd.Name + "\n"; }
            if (room.Log.Any(l => l.StartsWith("failed"))) file = "# THE ANALYSIS FAILED: this file may be missing ways\n" + file;
            File.WriteAllText(Path.Combine(outDir, rd.Name + ".txt"), file);
            Console.WriteLine("{0}: {1} box(es){2}", rd.Name, kv.Value.Count, room.Log.Any(l => l.StartsWith("failed")) ? ", FAILED: " + string.Join(" / ", room.Log) : "");
        }
    }

    static void Main(string[] args)
    {
        // (--allfps: every move also at 60 and 120fps, counting what it does at all three: Analyzer.AllFps; --fps30, the
        // moves at 30fps only, is the default)
        if (args.Contains("--allfps")) { Analyzer.AllFps = true; args = args.Where(a => a != "--allfps").ToArray(); }
        if (args.Contains("--fps30")) { Analyzer.AllFps = false; args = args.Where(a => a != "--fps30").ToArray(); }
        if (args.Contains("--fpsrejects")) { Analyzer.LogRejects = true; args = args.Where(a => a != "--fpsrejects").ToArray(); }
        // (--fps 60|120: the moves at that frame rate alone, Analyzer.FixedDt: a frame rate's own logic, for
        // combine_fps.py; 30 is --fps30. Also for --edges and --draw)
        int fpo = Array.IndexOf(args, "--fps");
        if (fpo >= 0) { Analyzer.FixedDt = 30.0 / int.Parse(args[fpo + 1]); Analyzer.AllFps = false; args = args.Take(fpo).Concat(args.Skip(fpo + 2)).ToArray(); }
        // (--slack S: the moves' strength, Sim.Slack, for trying other margins: 0.95 normally)
        int slk = Array.IndexOf(args, "--slack");
        if (slk >= 0) { Sim.Slack = D(args[slk + 1]); args = args.Take(slk).Concat(args.Skip(slk + 2)).ToArray(); }
        if (args.Length > 0 && args[0] == "--test") { Test(); return; }
        if (args.Length > 0 && args[0] == "--probes") { Probes(args); return; }
        if (args.Length > 0 && args[0] == "--edges") { Edges(args); return; }
        if (args.Length > 0 && args[0] == "--stones") { Stones(args); return; }
        if (args.Length > 0 && args[0] == "--draw") { Draw(args); return; }
        if (args.Length > 0 && args[0] == "--trace") { Trace(args); return; }
        if (args.Length > 0 && args[0] == "--move") { MoveCmd(args); return; }
        Mask.Root = args[0];
        Read(args[1]);
        // the output folder: rooms\<room>.txt and connections.txt go there (an older call gave roomlogic.txt in it)
        string outDir = args[2].EndsWith(".txt") ? Path.GetDirectoryName(Path.GetFullPath(args[2])) : Path.GetFullPath(args[2]);
        string roomsDir = Path.Combine(outDir, "rooms");
        Directory.CreateDirectory(roomsDir);
        string work = Path.GetDirectoryName(Path.GetFullPath(args[1]));
        var only = new HashSet<string>(args.Skip(3));
        // entries: every exit's destination, and the start; and, for the room files, where each comes from in the game
        var entries = new Dictionary<string, HashSet<long>>();
        var cameFrom = new Dictionary<string, Dictionary<long, List<string>>>();
        Action<string, int, int, string> addEntry = (rm, x, y, from) =>
        {
            HashSet<long> s;
            if (!entries.TryGetValue(rm, out s)) { s = new HashSet<long>(); entries[rm] = s; }
            s.Add(Shape.Key(x, y));
            Dictionary<long, List<string>> cf;
            if (!cameFrom.TryGetValue(rm, out cf)) { cf = new Dictionary<long, List<string>>(); cameFrom[rm] = cf; }
            List<string> l;
            if (!cf.TryGetValue(Shape.Key(x, y), out l)) { l = new List<string>(); cf[Shape.Key(x, y)] = l; }
            if (!l.Contains(from)) l.Add(from);
        };
        addEntry(StartRoom, StartX, StartY, "the start of a new game");
        foreach (var rd in Rooms)
            foreach (var it in rd.I)
            {
                if (it.K == 'X') addEntry(it.F[0], (int)Math.Round(D(it.F[1])), (int)Math.Round(D(it.F[2])),
                    rd.Name + (it.F.Length > 4 && it.F[4] == "menu" ? "'s menu" : it.F.Length > 4 && it.F[4] == "encounter" ? "'s encounters" : " out " + (int)Math.Round(it.X) + "," + (int)Math.Round(it.Y))
                    + (it.F.Length >= 7 ? " [" + rd.Groups[int.Parse(it.F[5])] + " " + it.F[6] + "]" : ""));
                if (it.K == 'D') addEntry(rd.Name, (int)Math.Round(D(it.F[0])), (int)Math.Round(D(it.F[1])),
                    "this room's door out " + (int)Math.Round(it.X) + "," + (int)Math.Round(it.Y));
            }
        var rooms = new Room[Rooms.Count];
        int done = 0;
        var sw = System.Diagnostics.Stopwatch.StartNew();
        var todo = Enumerable.Range(0, Rooms.Count).Where(i => only.Count == 0 || only.Contains(Rooms[i].Name)).ToList();
        // big rooms first (they take longest)
        todo.Sort((a, b) => ((long)Rooms[b].W * Rooms[b].H).CompareTo((long)Rooms[a].W * Rooms[a].H));
        Parallel.ForEach(todo, new ParallelOptions { MaxDegreeOfParallelism = Math.Max(1, Environment.ProcessorCount - 1) }, i =>
        {
            var rd = Rooms[i];
            var room = new Room(rd);
            HashSet<long> es;
            if (entries.TryGetValue(rd.Name, out es)) foreach (var k in es) room.Entries.Add(new[] { (int)(k >> 32), (int)(uint)k });
            try { if (rd.Groups.Count > 0) AnalyzeStates(room); else new Analyzer(room).Analyze(); }
            catch (Exception e) { room.Log.Add("failed: " + e); }
            // the grids aren't needed after the analysis
            room.SolidC = room.SolidO = room.Plat = room.Haz = room.Water = room.GhostB = room.HazV = null;
            // the room's file (its ways through, and how); the words aren't needed after it
            Dictionary<long, List<string>> cf;
            string file;
            try { file = RoomFile(room, cameFrom.TryGetValue(rd.Name, out cf) ? cf : new Dictionary<long, List<string>>()); }
            catch (Exception e) { room.Log.Add("failed: the room file: " + e); file = "# " + rd.Name + "\n"; }
            if (room.Log.Any(l => l.StartsWith("failed"))) file = "# THE ANALYSIS FAILED (work\\roomlogic_log.txt says why): this file may be missing ways\n" + file;
            // (another program may have the file open a while, reading it (a scan of the files just written): tried again
            // for up to two minutes)
            for (int tries = 0; ; tries++)
            {
                try { File.WriteAllText(Path.Combine(roomsDir, rd.Name + ".txt"), file); break; }
                catch (IOException) { if (tries >= 240) throw; Thread.Sleep(500); }
            }
            foreach (var e in room.Edges) e.How = null;
            foreach (var t in room.Touches) t.How = null;
            room.NodeName = null;
            rooms[i] = room;
            int n = Interlocked.Increment(ref done);
            if (n % 50 == 0) Console.Error.WriteLine("{0}/{1} rooms, {2:F0}s", n, todo.Count, sw.Elapsed.TotalSeconds);
        });
        Console.Error.WriteLine("rooms analysed in {0:F0}s, {1} moves tried", sw.Elapsed.TotalSeconds, rooms.Where(r => r != null).Sum(r => r.Sims));
        if (only.Count == 0) File.WriteAllText(Path.Combine(outDir, "connections.txt"), ConnectionsFile(rooms));
        // (the joining done here too, the old way: solve.py's result must be the same, without overrides)
        if (only.Count == 0) Solve(rooms, Path.Combine(work, "roomlogic_check.txt"), work);
        // (some rooms only: what the 60/120fps check took away, which Solve writes for a whole run)
        else if (Analyzer.LogRejects)
        {
            var rej = new StringBuilder();
            foreach (var r in rooms) if (r != null) foreach (var l in r.FpsRejects) rej.AppendLine(l);
            File.WriteAllText(Path.Combine(work, "fps_rejects.txt"), rej.ToString());
        }
    }

    // ---------------------------------------------------------------- joining the rooms: what each place needs
    static void Solve(Room[] rooms, string outPath, string work)
    {
        // node numbers: each room's regions and entry nodes in a row; then the locations
        var baseOf = new int[rooms.Length];
        int n = 0;
        for (int i = 0; i < rooms.Length; i++) { baseOf[i] = n; if (rooms[i] != null) n += rooms[i].NNodes; }
        var locKeys = new List<string>();
        var locIx = new Dictionary<string, int>();
        var locWhere = new List<string>();
        foreach (var r in rooms)
            if (r != null)
                foreach (var l in r.Locs)
                {
                    string k = l.Type + " " + l.Num;
                    if (!locIx.ContainsKey(k)) { locIx[k] = locKeys.Count; locKeys.Add(k); locWhere.Add(r.Data.Name); }
                }
        int locBase = n; n += locKeys.Count;
        // each exit a node too (for the report: how it's reached)
        var exitBase = new int[rooms.Length];
        for (int i = 0; i < rooms.Length; i++) { exitBase[i] = n; if (rooms[i] != null) n += rooms[i].Exits.Count; }
        var adj = new List<KeyValuePair<int, Req>>[n];
        for (int i = 0; i < n; i++) adj[i] = new List<KeyValuePair<int, Req>>();
        var attack = Req.ParseAlts("attack");
        for (int ri = 0; ri < rooms.Length; ri++)
        {
            var r = rooms[ri]; if (r == null) continue;
            int b = baseOf[ri];
            foreach (var e in r.Edges) adj[b + e.From].Add(new KeyValuePair<int, Req>(b + e.To, e.L));
            // (an exit whose way goes by a carried group leads on from where it's touched, in that place's state: below)
            for (int k = 0; k < r.Exits.Count; k++) if (r.Exits[k].Group < 0) AddExit(rooms, baseOf, adj, exitBase[ri] + k, r, k, 0, new Req(), attack);
            // a map (an overworld): every entry reaches every exit
            if (r.Data.IsMap)
                foreach (var en in r.EntryNode.Values)
                    for (int k = 0; k < r.Exits.Count; k++) adj[b + en].Add(new KeyValuePair<int, Req>(exitBase[ri] + k, new Req()));
            foreach (var t in r.Touches)
            {
                if (t.Kind == 0) adj[b + t.From].Add(new KeyValuePair<int, Req>(locBase + locIx[r.Locs[t.Index].Type + " " + r.Locs[t.Index].Num], t.L));
                else if (t.Kind == 1)
                {
                    adj[b + t.From].Add(new KeyValuePair<int, Req>(exitBase[ri] + t.Index, t.L));
                    if (r.Exits[t.Index].Group >= 0) AddExit(rooms, baseOf, adj, b + t.From, r, t.Index, StateOfNode(r, t.From), t.L, attack);
                }
            }
        }
        // the best ways: from the start, every node's alternatives (none needing more than another)
        var best = new List<Req>[n];
        for (int i = 0; i < n; i++) best[i] = new List<Req>();
        var q = new Queue<int>();
        var inQ = new bool[n];
        int si = RoomIx[StartRoom];
        int startNode = baseOf[si] + rooms[si].EntryNode[Shape.Key(StartX, StartY)];
        best[startNode].Add(new Req());
        q.Enqueue(startNode); inQ[startNode] = true;
        long relax = 0;
        while (q.Count > 0)
        {
            int u = q.Dequeue(); inQ[u] = false;
            var bu = best[u].ToArray();
            foreach (var e in adj[u])
            {
                bool changed = false;
                foreach (var a in bu) if (Pareto.Add(best[e.Key], Req.Max(a, e.Value))) changed = true;
                relax++;
                if (changed && !inQ[e.Key]) { q.Enqueue(e.Key); inQ[e.Key] = true; }
            }
        }
        // write
        var sb = new StringBuilder();
        sb.AppendLine("# what each Randomizer location needs, from the rooms (RoomLogic.exe from rooms.txt):");
        sb.AppendLine("#   loc <type> <number> <alternatives> <room>      room <room> <alternatives>");
        sb.AppendLine("# (alternatives separated by |, each a comma-separated list; - nothing; never: not reached from the start)");
        int reached = 0;
        for (int i = 0; i < locKeys.Count; i++)
        {
            var bl = best[locBase + i];
            if (bl.Count > 0) reached++;
            sb.AppendLine("loc " + locKeys[i] + " " + (bl.Count == 0 ? "never" : string.Join("|", bl.Select(x => x.ToString()))) + " " + locWhere[i]);
        }
        var rsb = new StringBuilder();
        for (int ri = 0; ri < rooms.Length; ri++)
        {
            var r = rooms[ri]; if (r == null) continue;
            var all = new List<Req>();
            for (int k = 0; k < r.NNodes; k++)
            {
                foreach (var a in best[baseOf[ri] + k]) Pareto.Add(all, a);
                if (k < r.NRegions) rsb.AppendLine("region " + r.Data.Name + " " + k + " " + (best[baseOf[ri] + k].Count == 0 ? "never" : string.Join("|", best[baseOf[ri] + k].Select(x => x.ToString()))));
            }
            // (a room with switch states: each state's regions, the one it starts in under the room's name, the others
            // under room@state, as --draw's --state looks for them)
            if (r.StateOff != null)
                for (int s = 0; s < r.StateOff.Length; s++)
                    for (int k = 0; k < r.StateRegions[s]; k++)
                        rsb.AppendLine("region " + r.Data.Name + (s == r.StateInit ? "" : "@" + s) + " " + k + " " + Alts(best[baseOf[ri] + r.StateOff[s] + k]));
            foreach (var kv in r.EntryNode)
                rsb.AppendLine("entry " + r.Data.Name + " " + (int)(kv.Key >> 32) + "," + (int)(uint)kv.Key + " " + Alts(best[baseOf[ri] + kv.Value]));
            for (int k = 0; k < r.Exits.Count; k++)
            {
                var e = r.Exits[k];
                rsb.AppendLine("exit " + r.Data.Name + " " + e.S.X0 + "," + e.S.Y0 + " -> " + e.To + " " + e.NX + "," + e.NY + " " + Alts(best[exitBase[ri] + k]));
            }
            sb.AppendLine("room " + r.Data.Name + " " + (all.Count == 0 ? "never" : string.Join("|", all.Select(x => x.ToString()))));
        }
        File.WriteAllText(outPath, sb.ToString());
        File.WriteAllText(Path.Combine(work, "roomlogic_regions.txt"), rsb.ToString());
        var log = new StringBuilder();
        foreach (var r in rooms) if (r != null) foreach (var l in r.Log) log.AppendLine(r.Data.Name + ": " + l);
        File.WriteAllText(Path.Combine(work, "roomlogic_log.txt"), log.ToString());
        if (Analyzer.LogRejects)
        {
            var rej = new StringBuilder();
            foreach (var r in rooms) if (r != null) foreach (var l in r.FpsRejects) rej.AppendLine(l);
            File.WriteAllText(Path.Combine(work, "fps_rejects.txt"), rej.ToString());
        }
        Console.Error.WriteLine("locations reached {0} of {1}; written {2}", reached, locKeys.Count, outPath);
    }

    static string Alts(List<Req> l) { return l.Count == 0 ? "never" : string.Join("|", l.Select(x => x.ToString())); }

    // ---------------------------------------------------------------- a room's logic file (rooms\<room>.txt)
    // For each way in, what each way out and place needs, from the moves inside the room alone (solve.py joins the
    // rooms), and the moves that do it. A step of a way: the requirements so far, the step before, and the node it gets to
    class Step { public Req L; public Step Prev; public int Node; public string How; public Req Own; public bool Dead; }

    // adds a way (needing l) to a list, unless one there needs no more; the ones needing more than it stop counting
    static bool AddStep(List<Step> list, Req l, Step prev, int node, string how, Req own)
    {
        foreach (var s in list) if (!s.Dead && s.L.Le(l)) return false;
        foreach (var s in list) if (!s.Dead && l.Le(s.L)) s.Dead = true;
        list.Add(new Step { L = l, Prev = prev, Node = node, How = how, Own = own });
        return true;
    }

    // an exit's name in the room files: where it's placed ("menu:<room>" for a menu's choices, "encounter:<room>" for a
    // map's encounters); a second one at the same place gets (2)
    public static List<string> ExitIds(Room r)
    {
        var ids = new List<string>();
        foreach (var e in r.Exits)
        {
            string id = e.Obj == "menu" || e.Obj == "encounter" ? e.Obj + ":" + e.To : e.IX + "," + e.IY;
            string u = id; int n = 2;
            while (ids.Contains(u)) u = id + "(" + n++ + ")";
            ids.Add(u);
        }
        return ids;
    }

    static string RoomFile(Room r, Dictionary<long, List<string>> cameFrom)
    {
        var d = r.Data;
        var sb = new StringBuilder();
        var exitIds = ExitIds(r);
        sb.AppendLine("# " + d.Name + ": " + (d.AreaName != "" ? d.AreaName : "?") + " (area " + d.Area + "), " + d.W + "x" + d.H + " px");
        sb.AppendLine("# The Randomizer's logic for this room, worked out from the room itself by roomlogic.py (RoomLogic.cs).");
        sb.AppendLine("# Don't edit this file (it's made again): change ..\\overrides.txt instead. ..\\README.txt explains it all.");
        sb.AppendLine("# Coordinates are the room's pixels, as in the room editor; where the player is, is where their feet are (x the");
        sb.AppendLine("# middle of the body, y its bottom). A tick is a 30th of a second (the game's movement steps).");
        if (d.Boss) sb.AppendLine("boss      # going into this room from another is its boss fight: that needs an attack (solve.py adds it)");
        if (d.IsMap) sb.AppendLine("map       # a map or a menu: every way in reaches every way out");
        if (d.WalkMap) sb.AppendLine("walkmap   # a map walked across as an icon (Zelda II's overworld): a way in reaches the exits its walk gets to (rivers and mountains in the way), and the encounters from anywhere");
        foreach (var g in d.Carried.OrderBy(g => g))
            sb.AppendLine("carried " + g + (g == "water" ? "   # the Water Palace's water level comes in with the player and goes out with them (1 the highest, 2, 3 the lowest)"
                                         : g.StartsWith("crystal") ? "   # the Forest Palace's crystal " + g.Substring(7) + " comes in with the player and goes out with them (0: as at the start, 1: hit, its rooms turned over)"
                                         : "   # the red and blue switches' state comes in with the player and goes out with them (0: the blue blocks solid, 1: the red ones)"));
        //foreach (var kv in d.Resets.OrderBy(k => k.Key))
        // (a carried group's, or one the room hasn't itself: a room's own group, the Maridia tube's, starts as the
        // switches' line says)
        foreach (var kv in d.Resets.Where(k => d.Carried.Contains(k.Key) || !d.Groups.Contains(k.Key)).OrderBy(k => k.Key))
            sb.AppendLine("resets " + kv.Key + " " + kv.Value + "   # the room sets it to that as the player comes in");
        if (d.Groups.Count > 0)
            sb.AppendLine("# switches: the room is worked out in each of its states, the player coming in in the first: [" + StateWords(d, d.Initial & ((1 << d.MaxG) - 1)) + "]");
        sb.AppendLine();
        sb.AppendLine("# Ways in: where the player appears coming into the room (and, in the game, the exits that lead there)");
        // (in the room's order of them, the connections': a room worked out in states numbers its nodes state by state,
        // and the order is what a save's marks go by, rndVisitData's)
        var entryIx = new Dictionary<long, int>();
        for (int i = 0; i < r.Entries.Count; i++) { long k = Shape.Key(r.Entries[i][0], r.Entries[i][1]); if (!entryIx.ContainsKey(k)) entryIx[k] = i; }
        var entries = r.EntryNode.OrderBy(kv => entryIx.ContainsKey(kv.Key) ? entryIx[kv.Key] : int.MaxValue).ThenBy(kv => kv.Value).ToList();
        // (on a map or a menu, every way in reaches every way out, wherever it puts the player)
        var bad = d.IsMap ? new HashSet<string>() : new HashSet<string>(r.BadEntries);
        foreach (var kv in entries)
        {
            string id = (int)(kv.Key >> 32) + "," + (int)(uint)kv.Key;
            var notes = new List<string>();
            List<string> from;
            if (cameFrom.TryGetValue(kv.Key, out from)) notes.Add("from " + string.Join(", ", from));
            if (bad.Contains(id)) notes.Add("can't be come in at: the player would be inside a solid");
            sb.AppendLine("in " + id + (notes.Count > 0 ? "   # " + string.Join("; ", notes) : ""));
        }
        sb.AppendLine();
        sb.AppendLine("# Ways out: exits (and, in the game, where they lead), and how they're gone through");
        for (int k = 0; k < r.Exits.Count; k++)
        {
            var e = r.Exits[k];
            if (e.Group >= 0)
            {
                string g = d.Groups[e.Group];
                sb.AppendLine("out " + exitIds[k] + "   # to " + e.To + " at " + e.NX + "," + e.NY + " with " + g + " 0, to " + e.To1 + " at " + e.NX1 + "," + e.NY1 + " with " + g + " 1; the player " + Analyzer.ExitAction(e));
                continue;
            }
            sb.AppendLine("out " + exitIds[k] + "   # to " + (e.InRoom ? "this room" : e.To) + " at " + e.NX + "," + e.NY + "; the player " + Analyzer.ExitAction(e));
        }
        sb.AppendLine();
        sb.AppendLine("# Places: the Randomizer's locations (type number, as roomlogic.txt and logic.txt name them)");
        for (int j = 0; j < r.Locs.Count; j++)
        {
            var l = r.Locs[j];
            sb.AppendLine("loc " + l.Type + " " + l.Num + "   # " + l.Label + ", at " + (l.S.X0 + l.S.X1) / 2 + "," + (l.S.Y0 + l.S.Y1) / 2);
        }
        if (r.Spots.Count > 0)
        {
            sb.AppendLine();
            sb.AppendLine("# Spots: somewhere whose reaching opens a way (the barriers that wait for it need event:" + d.Name + "/<spot>, and");
            sb.AppendLine("# solve.py makes that what reaching the spot needs)");
            foreach (var sp in r.Spots)
                sb.AppendLine("spot " + sp.Tag + "   # " + (sp.Tag.StartsWith("key") ? "a colored key, at " : "a colored switch the partner can be left standing on (party split), at ") + (sp.S.X0 + sp.S.X1) / 2 + "," + (sp.S.Y0 + sp.S.Y1) / 2);
        }
        // each way in: the ways through the room from it
        int N = r.NNodes;
        var adj = new List<Edge>[N];
        for (int i = 0; i < N; i++) adj[i] = new List<Edge>();
        foreach (var e in r.Edges) if (e.From < N && e.To < N) adj[e.From].Add(e);
        var touchesAt = new List<Touch>[N];
        for (int i = 0; i < N; i++) touchesAt[i] = new List<Touch>();
        foreach (var t in r.Touches) if (t.From < N) touchesAt[t.From].Add(t);
        var table = new StringBuilder();
        var how = new StringBuilder();
        // (a room that carries a state: each way in in each state the player can come in in, and each way out in each
        // state they leave in: "[rb 1]", "[water 2]")
        bool carried = d.Carried.Count > 0 && r.StateOff != null;
        var carriedGroups = d.Carried.OrderBy(g => g).ToList();
        Func<int, string> label = s => carried ? " [" + string.Join(", ", carriedGroups.Select(g => g + " " + d.Carry(g, s))) + "]" : "";
        Func<int, int> stateOf = n => { int st = 0; if (r.StateOff != null) for (int i = 0; i < r.StateOff.Length; i++) if (n >= r.StateOff[i]) st = i; return st; };
        var ways = new List<Tuple<long, int, int>>();
        foreach (var kv in entries)
        {
            Dictionary<int, int> bySt;
            if (carried && r.EntryByState.TryGetValue(kv.Key, out bySt))
            {
                foreach (int s in r.EntryStates) { int nd; if (bySt.TryGetValue(s, out nd)) ways.Add(Tuple.Create(kv.Key, s, nd)); }
            }
            else ways.Add(Tuple.Create(kv.Key, r.StateInit, kv.Value));
        }
        foreach (var way in ways)
        {
            string inId = (int)(way.Item1 >> 32) + "," + (int)(uint)way.Item1 + label(way.Item2);
            int startNode = way.Item3;
            var steps = new List<Step>[N];
            var q = new Queue<int>(); var inQ = new bool[N];
            steps[startNode] = new List<Step> { new Step { L = new Req(), Node = startNode, How = null } };
            q.Enqueue(startNode); inQ[startNode] = true;
            while (q.Count > 0)
            {
                int u = q.Dequeue(); inQ[u] = false;
                foreach (var s in steps[u].Where(x => !x.Dead).ToList())
                    foreach (var e in adj[u])
                    {
                        if (steps[e.To] == null) steps[e.To] = new List<Step>();
                        if (AddStep(steps[e.To], Req.Max(s.L, e.L), s, e.To, e.How, e.L) && !inQ[e.To]) { inQ[e.To] = true; q.Enqueue(e.To); }
                    }
            }
            // what each way out (in the state it's left in) and each place needs from here
            var tmap = new Dictionary<string, List<Step>>();
            Func<string, List<Step>> T = key => { List<Step> l; if (!tmap.TryGetValue(key, out l)) { l = new List<Step>(); tmap[key] = l; } return l; };
            for (int u = 0; u < N; u++)
            {
                if (steps[u] == null) continue;
                foreach (var t in touchesAt[u])
                {
                    string key = t.Kind == 1 ? "out " + exitIds[t.Index] + label(stateOf(u)) : t.Kind == 2 ? "spot " + r.Spots[t.Index].Tag : "loc " + r.Locs[t.Index].Type + " " + r.Locs[t.Index].Num;
                    var tl = T(key);
                    foreach (var s in steps[u]) if (!s.Dead) AddStep(tl, Req.Max(s.L, t.L), s, -1, t.How, t.L);
                }
            }
            if (d.IsMap)
                for (int k = 0; k < r.Exits.Count; k++)
                    AddStep(T("out " + exitIds[k] + label(way.Item2)), new Req(), steps[startNode][0], -1, "on the map (or menu), choose it", new Req());
            var targets = new List<KeyValuePair<string, List<Step>>>();
            for (int k = 0; k < r.Exits.Count; k++)
            {
                string bare = "out " + exitIds[k];
                var keys = tmap.Keys.Where(x => x == bare || x.StartsWith(bare + " [")).OrderBy(x => x).ToList();
                if (keys.Count == 0) targets.Add(new KeyValuePair<string, List<Step>>(bare, new List<Step>()));
                foreach (var key in keys) targets.Add(new KeyValuePair<string, List<Step>>(key, tmap[key]));
            }
            for (int j = 0; j < r.Locs.Count; j++)
            {
                string key = "loc " + r.Locs[j].Type + " " + r.Locs[j].Num;
                List<Step> l;
                targets.Add(new KeyValuePair<string, List<Step>>(key, tmap.TryGetValue(key, out l) ? l : new List<Step>()));
            }
            foreach (var sp in r.Spots)
            {
                string key = "spot " + sp.Tag;
                List<Step> l;
                targets.Add(new KeyValuePair<string, List<Step>>(key, tmap.TryGetValue(key, out l) ? l : new List<Step>()));
            }
            table.AppendLine("from in " + inId);
            if (targets.Count == 0) { table.AppendLine("  (the room has no ways out or places)"); continue; }
            if (bad.Contains((int)(way.Item1 >> 32) + "," + (int)(uint)way.Item1)) { table.AppendLine("  (can't be come in at: nothing is reached from here)"); continue; }
            int w = targets.Max(t => t.Key.Length);
            foreach (var t in targets)
            {
                var alive = t.Value.Where(x => !x.Dead).ToList();
                table.AppendLine("  " + t.Key.PadRight(w) + "   " + (alive.Count == 0 ? "never" : string.Join(" | ", alive.Select(x => x.L.ToString()))));
                // the moves for each way
                foreach (var s in alive)
                {
                    var chain = new List<Step>();
                    for (var c = s; c != null; c = c.Prev) chain.Add(c);
                    chain.Reverse();
                    how.AppendLine("how in " + inId + " -> " + t.Key + ": " + s.L);
                    how.AppendLine("     " + (r.NodeName.ContainsKey(startNode) ? r.NodeName[startNode] : "coming in at " + inId));
                    for (int i = 1; i < chain.Count; i++)
                    {
                        var c = chain[i];
                        string own = c.Own.ToString() == "-" ? "" : "   [" + c.Own + "]";
                        string to = c.Node >= 0 ? (r.NodeName.ContainsKey(c.Node) ? r.NodeName[c.Node] : "node " + c.Node) : t.Key;
                        how.AppendLine("  " + i.ToString().PadLeft(2) + ". " + (c.How ?? "?") + own);
                        how.AppendLine("      -> " + to);
                    }
                }
            }
        }
        sb.AppendLine();
        sb.AppendLine("# What each way out and place needs, from each way in, with the moves inside this room alone (alternatives");
        sb.AppendLine("# separated by |, any one of them is enough; - nothing but walking and jumping; never: not from there).");
        sb.AppendLine("# Words: djump double jump, adash air dash, gdash dash, hijump:N High Jump Boots, mario the Mario Ability Set,");
        sb.AppendLine("# link:N belmont:N megaman:N samus:N gamej:N gamec:N that many of the ability set's items, key:N the key of");
        sb.AppendLine("# the locked door whose objectNum is N.");
        sb.Append(table);
        sb.AppendLine();
        sb.AppendLine("# How: for each of those ways, the steps, in order: what the player does, then (->) where it gets them; a step");
        sb.AppendLine("# that needs something says what in [ ]. In a room with switches, [the state] it's in comes first.");
        sb.Append(how);
        return sb.ToString();
    }

    // connections.txt: which way in each exit leads to (the game's), the start, and the exits that are boss fights
    static string ConnectionsFile(Room[] rooms)
    {
        var sb = new StringBuilder();
        sb.AppendLine("# Which way in each exit leads to: the game's own connections, as roomdata.py read them from the rooms. solve.py");
        sb.AppendLine("# joins the rooms (their files in rooms\\) with these. An entrance randomizer would use a different list. Lines:");
        sb.AppendLine("#   start <room> in <x,y>                     where a new game starts");
        sb.AppendLine("#   <room> out <exit> -> <room> in <x,y>      where an exit leads (the exit as its room's file names it)");
        sb.AppendLine("#   <room> out <exit> [<state> <value>] -> <room> in <x,y>");
        sb.AppendLine("#                                             where it leads when the player goes through it with a carried state at");
        sb.AppendLine("#                                             that value (the Forest Palace's crystals turn its rooms over)");
        sb.AppendLine("#   via <room> out <exit>                     going through that exit is a boss fight (it needs an attack); a room");
        sb.AppendLine("#                                             whose file says boss is one when it's come into from another room");
        sb.AppendLine("#   carried <state> <value> [within <prefix>] a state the player carries from room to room (rooms whose file says");
        sb.AppendLine("#                                             carried use it; the rest pass it on), and its value as a new game starts;");
        sb.AppendLine("#                                             within: kept only in the rooms whose names start so (solve.py remembers");
        sb.AppendLine("#                                             the values the player leaves them with)");
        sb.AppendLine("# (A way in whose room's file says it can't be come in at reaches nothing: the player would be inside a solid.)");
        sb.AppendLine("start " + StartRoom + " in " + StartX + "," + StartY);
        foreach (var kv in CarryStart) sb.AppendLine("carried " + kv.Key + " " + kv.Value + (CarryScope.ContainsKey(kv.Key) ? " within " + CarryScope[kv.Key] : ""));
        var via = new StringBuilder();
        foreach (var r in rooms)
        {
            if (r == null) continue;
            var ids = ExitIds(r);
            for (int k = 0; k < r.Exits.Count; k++)
            {
                var e = r.Exits[k];
                if (e.Group >= 0)
                {
                    string g = r.Data.Groups[e.Group];
                    sb.AppendLine(r.Data.Name + " out " + ids[k] + " [" + g + " 0] -> " + e.To + " in " + e.NX + "," + e.NY);
                    sb.AppendLine(r.Data.Name + " out " + ids[k] + " [" + g + " 1] -> " + e.To1 + " in " + e.NX1 + "," + e.NY1);
                    continue;
                }
                sb.AppendLine(r.Data.Name + " out " + ids[k] + " -> " + e.To + " in " + e.NX + "," + e.NY);
                if (Via.Contains(r.Data.Name + ">" + e.To)) via.AppendLine("via " + r.Data.Name + " out " + ids[k]);
            }
        }
        sb.Append(via);
        return sb.ToString();
    }

    // a room whose switches change it (RoomData.Groups): each state analysed on its own, with that state's solids, the
    // player coming in in the one it starts in; joined where a switch can be hit: by an attack (within 48px across, at
    // the body's height, or a shot along a clear line), a block by the head from below (within a jump), an ice block by
    // an elemental attack (its platforms come out), a Forest Palace crystal by the sword or the whip (as an attack's
    // reach, no shots). A switch marked once only opens (a barrier; the ice's platforms)
    // a room in one of its switch states (a bit a group: its solids in that state; groups past the 4th as they start)
    static RoomData StateData(RoomData rd, int s)
    {
        int G = rd.MaxG;
        var d2 = new RoomData { Name = rd.Name, W = rd.W, H = rd.H, Area = rd.Area, IsMap = rd.IsMap, WalkMap = rd.WalkMap, Boss = rd.Boss, Partner = rd.Partner };
        foreach (var it in rd.I)
        {
            if (it.K == 'w') continue;
            // (a line there in one state of a group only)
            if (it.CondG >= 0 && (it.CondG < G ? (s >> it.CondG) & 1 : (rd.Initial >> it.CondG) & 1) != it.CondV) continue;
            // (water at one of the Water Palace's levels: there at that level)
            if (it.K == 'y')
            {
                if (int.Parse(it.F[0]) == rd.Level(s)) d2.I.Add(new Inst { K = 'W', Spr = it.Spr, X = it.X, Y = it.Y, XS = it.XS, YS = it.YS, A = it.A, F = new string[0] });
                continue;
            }
            // (a fan a switch turns on and off: there in its state)
            if (it.K == 'n' && it.F.Length >= 3)
            {
                int gi = int.Parse(it.F[1]);
                if ((gi < G ? (s >> gi) & 1 : (rd.Initial >> gi) & 1) == int.Parse(it.F[2]))
                    d2.I.Add(new Inst { K = 'n', Spr = it.Spr, X = it.X, Y = it.Y, XS = it.XS, YS = it.YS, A = it.A, F = new[] { it.F[0] } });
                continue;
            }
            if (it.K == 'T' || it.K == 'U')
            {
                int gi = int.Parse(it.F[0]), want = int.Parse(it.F[1]);
                int have = gi < G ? (s >> gi) & 1 : (rd.Initial >> gi) & 1;
                if (have != want && !(rd.KeepSolid != null && rd.KeepSolid.Contains(it))) continue;
                // (a state's solid; a state's moving platform, as an N line)
                if (it.K == 'T') d2.I.Add(new Inst { K = 'S', Spr = it.Spr, X = it.X, Y = it.Y, XS = it.XS, YS = it.YS, A = it.A, F = new string[0] });
                else d2.I.Add(new Inst { K = 'N', Spr = it.Spr, X = it.X, Y = it.Y, XS = it.XS, YS = it.YS, A = it.A, F = it.F.Skip(2).ToArray() });
                continue;
            }
            d2.I.Add(it);
        }
        return d2;
    }

    // the bricks (the brk group's solids) the head can't get to: a brick breaks when the player jumps into it from a
    // standing place under it (the head within 60px of it, nothing between); one that breaks may let the head get to the
    // next. The rest stay in the brk state too
    static HashSet<Inst> BricksKept(RoomData rd, int gi)
    {
        var bricks = rd.I.Where(i => i.K == 'T' && i.F[0] == gi.ToString() && i.F[1] == "0").ToList();
        var room = new Room(StateData(rd, rd.Initial & ~(1 << gi)));
        var an = new Analyzer(room);
        an.Build();
        var shapes = bricks.Select(b => { var m = Mask.Get(b.Spr); return m == null ? null : new Shape(m, b.X, b.Y, b.XS, b.YS, b.A); }).ToList();
        var gone = new bool[bricks.Count];
        for (int round = 0; round < 30; round++)
        {
            var places = an.StandingPlaces();
            bool any = false;
            for (int k = 0; k < bricks.Count; k++)
            {
                if (gone[k] || shapes[k] == null || shapes[k].Empty) continue;
                var sh = shapes[k];
                foreach (var p in places)
                {
                    int x = p[0], y = p[1], head = y - 40;
                    if (p[0] + 6 < sh.X0 || p[0] - 7 > sh.X1 || head - sh.Y1 < 1 || head - sh.Y1 > 60) continue;
                    if (room.SolidC.Box(x - 7, sh.Y1 + 1, x + 6, head - 1)) continue;
                    gone[k] = true; any = true;
                    foreach (var key in sh.Px) { room.SolidC.Clear((int)(key >> 32), (int)(uint)key); room.SolidO.Clear((int)(key >> 32), (int)(uint)key); }
                    break;
                }
            }
            if (!any) break;
        }
        var keep = new HashSet<Inst>();
        for (int k = 0; k < bricks.Count; k++) if (!gone[k]) keep.Add(bricks[k]);
        return keep;
    }

    // a room's switch state in words: each group's
    public static string StateWords(RoomData rd, int s)
    {
        int G = rd.MaxG;
        var w = new List<string>();
        for (int gi = 0; gi < G; gi++)
        {
            bool on = ((s >> gi) & 1) == 1;
            string g = rd.Groups[gi];
            if (g == "w3") continue;
            if (g == "w1") { w.Add("water at level " + rd.Level(s)); continue; }
            if (g == "rb") w.Add(on ? "red blocks solid" : "blue blocks solid");
            else if (g == "pb") w.Add(on ? "sliding blocks moved" : "sliding blocks as placed");
            else if (g == "ice") w.Add(on ? "ice platforms out" : "no ice platforms");
            else if (g == "brk") w.Add(on ? "bricks broken" : "bricks whole");
            else if (g == "cpm") w.Add(on ? "platform makers' platforms out" : "no platform makers' platforms");
            else if (g == "tube") w.Add(on ? "the tube walled for passing behind it" : "the tube walled for going through it");
            else if (g.StartsWith("alert")) w.Add(on ? "the alert door shut" : "no alert door");
            else if (g.StartsWith("crystal")) w.Add("crystal " + g.Substring(7) + (on ? " hit (its rooms turned over)" : " as at the start"));
            else if (g.StartsWith("way"))
            {
                // (a group a way in sets: the room as the ways in that set it make it)
                var by = rd.WayIn.Where(kv => kv.Value.Any(p => p[0] == gi && p[1] == 1)).Select(kv => (int)(kv.Key >> 32) + "," + (int)(uint)kv.Key).ToList();
                w.Add(on ? "as coming in at " + string.Join(" or ", by) + " makes the room" : "as the other ways in make the room");
            }
            else if (g.StartsWith("b")) w.Add(on ? "barrier " + g.Substring(1) + " open" : "barrier " + g.Substring(1) + " shut");
            else w.Add(g + (on ? " on" : " off"));
        }
        return string.Join(", ", w);
    }

    // the standing region at x,y (or a pixel or two above or below) in a room, or -1
    static int RegionNear(Room r, int x, int y)
    {
        for (int dy = 0; dy <= 2; dy++)
            foreach (int yy in new[] { y - dy, y + dy })
            {
                int q;
                if (r.PosRegion.TryGetValue(Shape.Key(x, yy), out q)) return q;
            }
        return -1;
    }

    static void AnalyzeStates(Room parent)
    {
        var rd = parent.Data;
        int G = rd.MaxG;
        int nS = 1 << G;
        int init = rd.Initial & (nS - 1);
        int brk = rd.Groups.IndexOf("brk");
        if (brk >= 0 && brk < G) rd.KeepSolid = BricksKept(rd, brk);
        var subs = new Room[nS];
        var off = new int[nS];
        int total = 0;
        // the states the player can come in in: the room's own groups as they start; each carried one (rb, water) as it
        // comes in from the room before, unless the room sets it as the player comes in
        var entryStates = new List<int> { init };
        foreach (var g in rd.Carried)
        {
            if (rd.Resets.ContainsKey(g)) continue;
            var vals = g == "water" ? new[] { 1, 2, 3 } : new[] { 0, 1 };
            entryStates = entryStates.SelectMany(s0 => vals.Select(v => rd.WithCarry(g, s0, v) & (nS - 1))).Distinct().ToList();
        }
        // (each way in in those states, with what it sets itself as the player comes in by it: WS)
        var byEntry = new Dictionary<long, List<int>>();
        foreach (var e in parent.Entries)
        {
            long k = Shape.Key(e[0], e[1]);
            byEntry[k] = entryStates.Select(s0 => rd.WayState(k, s0) & (nS - 1)).Distinct().ToList();
        }
        if (rd.WayIn.Count > 0) entryStates = entryStates.Concat(byEntry.Values.SelectMany(v => v)).Distinct().ToList();
        parent.EntryStates = entryStates;
        // (the states the player can be in: the ways in's, and what the room's switches change from them; a group a way in
        // sets never changes in the room, so most of its states can't be, and aren't worked out)
        var reach = new HashSet<int>(entryStates);
        if (rd.WayIn.Count > 0)
        {
            var flips = rd.I.Where(i => i.K == 'w').Select(i => i.F[1] == "water" ? -1 : int.Parse(i.F[0])).Where(g => g < G).Distinct().ToList();
            var todo = new Queue<int>(reach);
            while (todo.Count > 0)
            {
                int s0 = todo.Dequeue();
                var next = new List<int>();
                foreach (int g in flips)
                {
                    if (g < 0) next.AddRange(new[] { 1, 2, 3 }.Select(lv => rd.WithLevel(s0, lv) & (nS - 1)));
                    else next.Add(s0 ^ (1 << g));
                }
                foreach (int s1 in next) if (!rd.BadLevel(s1) && reach.Add(s1)) todo.Enqueue(s1);
            }
        }
        else for (int s = 0; s < nS; s++) reach.Add(s);
        for (int s = 0; s < nS; s++)
        {
            var sub = new Room(StateData(rd, s));
            if (reach.Contains(s))
            {
                sub.Entries.AddRange(parent.Entries.Where(e => byEntry[Shape.Key(e[0], e[1])].Contains(s)));
                new Analyzer(sub).Analyze();
            }
            subs[s] = sub; off[s] = total; total += sub.NNodes;
        }
        // (the room's ways out, places and spots: each state has the same ones; from one worked out)
        int any = reach.Min();
        parent.NNodes = total;
        parent.NRegions = 0;
        parent.StateOff = off; parent.StateRegions = subs.Select(x => x.NRegions).ToArray(); parent.StateInit = init;
        parent.Exits = subs[any].Exits; parent.Locs = subs[any].Locs; parent.Spots = subs[any].Spots;
        parent.BadEntries = subs[reach.Contains(init) ? init : any].BadEntries;
        for (int s = 0; s < nS; s++)
        {
            foreach (var e in subs[s].Edges) parent.Edges.Add(new Edge { From = e.From + off[s], To = e.To + off[s], L = e.L, How = e.How });
            foreach (var t in subs[s].Touches) parent.Touches.Add(new Touch { From = t.From + off[s], Kind = t.Kind, Index = t.Index, L = t.L, How = t.How });
            // (each node's name with the state: "[ice platforms out] standing at ...")
            string st = StateWords(rd, s);
            foreach (var kv in subs[s].NodeName) parent.NodeName[kv.Key + off[s]] = "[" + st + "] " + kv.Value;
            parent.Sims += subs[s].Sims;
            parent.Log.AddRange(subs[s].Log.Distinct());
        }
        // (each way in's node in the state it's come in in: the room's first, with what the way in sets)
        foreach (var e in parent.Entries)
        {
            long k = Shape.Key(e[0], e[1]);
            int s0 = rd.WayState(k, init) & (nS - 1), nd;
            if (subs[s0].EntryNode.TryGetValue(k, out nd)) parent.EntryNode[k] = nd + off[s0];
        }
        foreach (int s in entryStates)
            foreach (var kv in subs[s].EntryNode)
            {
                Dictionary<int, int> bySt;
                if (!parent.EntryByState.TryGetValue(kv.Key, out bySt)) { bySt = new Dictionary<int, int>(); parent.EntryByState[kv.Key] = bySt; }
                bySt[s] = kv.Value + off[s];
            }
        var attack = Req.ParseAlts("attack");
        // (a shot or a thrown weapon reaches further, along a clear line at the chest: the X-Buster, the Arm Cannon, the
        // bow, the dagger)
        var ranged = Req.ParseAlts("megaman:1|samus:1|link:2|belmont:2");
        // (an ice block takes an elemental attack: Shotgun Ice, a shot; Holy Water, thrown close)
        var iceNear = Req.ParseAlts("megaman:2|belmont:3");
        var iceFar = Req.ParseAlts("megaman:2");
        // (a Forest Palace crystal takes only a NORMAL attack, close up: the sword, the whip)
        var normalHit = Req.ParseAlts("link:1|belmont:1");
        // the blocks a switch slides that carry a player standing on one (T lines with ride, a pair a block: its place in
        // its group's state 0, then 1)
        var rides = new List<Shape[]>();
        var rideG = new List<int>();
        var rideTs = rd.I.Where(i => i.K == 'T' && i.F.Length > 2 && i.F[2] == "ride").ToList();
        for (int k = 0; k + 1 < rideTs.Count; k += 2)
        {
            var t0 = rideTs[k]; var t1 = rideTs[k + 1];
            var m0 = Mask.Get(t0.Spr); var m1 = Mask.Get(t1.Spr);
            if (m0 == null || m1 == null || t0.F[0] != t1.F[0]) continue;
            var a0 = new Shape(m0, t0.X, t0.Y, t0.XS, t0.YS, t0.A); var a1 = new Shape(m1, t1.X, t1.Y, t1.XS, t1.YS, t1.A);
            rides.Add(t0.F[1] == "0" ? new[] { a0, a1 } : new[] { a1, a0 });
            rideG.Add(int.Parse(t0.F[0]));
        }
        foreach (var sw in rd.I.Where(i => i.K == 'w'))
        {
            int gi = int.Parse(sw.F[0]);
            if (gi >= G) continue;
            var m = Mask.Get(sw.Spr);
            if (m == null) { parent.Log.Add("no mask for a switch: " + sw.Spr); continue; }
            var shape = new Shape(m, sw.X, sw.Y, sw.XS, sw.YS, sw.A);
            bool bump = sw.F[1] == "bump", ice = sw.F[1] == "ice", normal = sw.F[1] == "normal", once = sw.F.Length > 2 && sw.F[2] == "once";
            // (a Water Palace switch sets the water to its level)
            bool water = sw.F[1] == "water";
            int wlv = water ? int.Parse(sw.F[2]) : 0;
            // (a zone sets its group's state, as the player stands in it: the Maridia tube's walls)
            bool zone = sw.F[1] == "zone";
            int zoneTo = zone ? int.Parse(sw.F[2]) : 0;
            for (int s = 0; s < nS; s++)
            {
                if (once && ((s >> gi) & 1) == 1) continue;
                //int s2 = water ? rd.WithLevel(s, wlv) & (nS - 1) : s ^ (1 << gi);
                int s2 = water ? rd.WithLevel(s, wlv) & (nS - 1) : zone ? (zoneTo == 1 ? s | (1 << gi) : s & ~(1 << gi)) : s ^ (1 << gi);
                if (s2 == s || rd.BadLevel(s)) continue;
                var seen = new HashSet<long>();
                int cy = (shape.Y0 + shape.Y1) / 2, cx = (shape.X0 + shape.X1) / 2;
                var far = new Dictionary<int, int[]>();   // each region's place furthest from the switch it can be shot from, standing
                var seenD = new HashSet<string>();
                foreach (var kv in subs[s].PosRegion)
                {
                    int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key;
                    if (zone)
                    {
                        // (standing there: the player's x and the feet's row in its box)
                        if (!shape.Hits(x, y - 1, x, y - 1)) continue;
                        int rz = RegionNear(subs[s2], x, y);
                        if (rz < 0 || !seen.Add(((long)kv.Value << 32) | (uint)rz)) continue;
                        parent.Edges.Add(new Edge { From = kv.Value + off[s], To = rz + off[s2], L = new Req(), How = "walk to " + x + "," + y + ": [" + StateWords(rd, s2) + "]" });
                        continue;
                    }
                    // (standing there, or at the top of a jump straight up from there: 60px, less any ceiling)
                    int rise = 0;
                    if (!bump) while (rise < 60 && !subs[s].SolidC.Row(y - 41 - rise, x - 7, x + 6)) rise++;
                    bool hit = bump ? (shape.X1 >= x - 7 && shape.X0 <= x + 6 && y - 40 - shape.Y1 >= 1 && y - 40 - shape.Y1 <= 60)
                                    : shape.Hits(x - 48, y - 44 - rise, x + 48, y - 4);
                    bool shot = false;
                    if (!hit && !bump && !normal && cy >= y - 28 - rise - 16 && cy <= y - 28 + 16 && Math.Abs(cx - x) <= 320)
                    {
                        int a = Math.Min(x, cx), b = Math.Max(x, cx);
                        shot = !subs[s].SolidC.Row(cy, a, b);
                    }
                    if (!hit && !shot) continue;
                    // where the player is once it's hit: where they were, in the other state; or, standing on a sliding
                    // block the switch moves, carried with it (one moving sideways only from a hit made standing: from a
                    // jump's, it slides away under the player)
                    bool standing = bump || (hit ? shape.Hits(x - 48, y - 44, x + 48, y - 4) : cy >= y - 28 - 16);
                    if (shot && standing && !ice)
                    {
                        int[] fc;
                        if (!far.TryGetValue(kv.Value, out fc) || Math.Abs(cx - x) > Math.Abs(cx - fc[0])) far[kv.Value] = new[] { x, y };
                    }
                    var targets = new List<KeyValuePair<int, string>>();
                    int r2 = RegionNear(subs[s2], x, y);
                    if (r2 >= 0) targets.Add(new KeyValuePair<int, string>(r2, ""));
                    for (int k = 0; k < rides.Count; k++)
                    {
                        if (rideG[k] != gi) continue;
                        Shape b0 = rides[k][(s >> gi) & 1], b1 = rides[k][(s2 >> gi) & 1];
                        if (!b0.Hits(x - 7, y - 1, x + 6, y - 1)) continue;   // (standing: the row under the feet, y-1, is the block's)
                        int dx = b1.X0 - b0.X0, dyb = b1.Y0 - b0.Y0;
                        if (dyb == 0 && !standing) continue;
                        int rr = RegionNear(subs[s2], x + dx, y + dyb);
                        if (rr >= 0) targets.Add(new KeyValuePair<int, string>(rr, ", carried by the block it moves to " + (x + dx) + "," + (y + dyb)));
                    }
                    foreach (var tg in targets)
                    {
                        if (!seen.Add(((long)kv.Value << 32) | (uint)tg.Key ^ (hit ? 0L : 1L << 62) ^ (tg.Value == "" ? 0L : 1L << 61))) continue;
                        // (in words: what's hit, how, from where, and what it changes)
                        string what = ice ? "the ice block" : (bump ? "the block" : (normal ? "the crystal" : "the switch"));
                        string how = bump ? "jump at " + x + "," + y + " and hit " + what + " at " + sw.X + "," + sw.Y + " from below"
                            : (hit ? "hit " + what + " at " + sw.X + "," + sw.Y + " from " + x + "," + y + (rise > 0 ? " (jumping if need be)" : "")
                                   : "shoot " + what + " at " + sw.X + "," + sw.Y + " from " + x + "," + y + (cy < y - 28 - 16 ? " (at the top of a jump)" : ""));
                        how += ice ? (hit ? " with Shotgun Ice or Holy Water" : " with Shotgun Ice") : (normal ? " with the sword or the whip" : "");
                        how += tg.Value + ": [" + StateWords(rd, s2) + "]";
                        if (bump) parent.Edges.Add(new Edge { From = kv.Value + off[s], To = tg.Key + off[s2], L = new Req(), How = how });
                        else foreach (var a in (ice ? (hit ? iceNear : iceFar) : normal ? normalHit : (hit ? attack : ranged))) parent.Edges.Add(new Edge { From = kv.Value + off[s], To = tg.Key + off[s2], L = a, How = how });
                    }
                }
                // a shot takes a while to get there, and meanwhile the player can jump somewhere else (onto a block the
                // switch is about to move, say). It leaves 10px ahead of the player at each weapon's speed (px a tick:
                // Belmont's dagger 15, the X-Buster 12, Link's arrows 12, the Arm Cannon 11.5); the move has to land 3
                // ticks before the shot gets there, or, onto a block that then rises (8px a tick, 8 ticks: it catches a
                // player coming down onto it), up to 2 ticks after
                if (far.Count == 0) continue;
                var an = new Analyzer(subs[s]);
                foreach (var fk in far)
                {
                    int fx = fk.Value[0], fy = fk.Value[1];
                    double dist = Math.Abs(cx - fx) - 10 - (shape.X1 - shape.X0) / 2;
                    int maxT = (int)(dist / 11.5) + 2;
                    if (maxT < 6) continue;
                    foreach (var mv in an.QuickMoves(fx, fy, maxT))
                    {
                        int lx = mv.Item1, ly = mv.Item2;
                        // (where the move lands, then the switch's change: there in the other state, or carried by a block;
                        // with the ticks the move may take past the shot's)
                        var targets = new List<Tuple<int, string, int>>();
                        int r2 = RegionNear(subs[s2], lx, ly);
                        if (r2 >= 0) targets.Add(Tuple.Create(r2, "", -3));
                        for (int k = 0; k < rides.Count; k++)
                        {
                            if (rideG[k] != gi) continue;
                            Shape b0 = rides[k][(s >> gi) & 1], b1 = rides[k][(s2 >> gi) & 1];
                            if (!b0.Hits(lx - 7, ly - 1, lx + 6, ly - 1)) continue;
                            int rr = RegionNear(subs[s2], lx + b1.X0 - b0.X0, ly + b1.Y0 - b0.Y0);
                            if (rr >= 0) targets.Add(Tuple.Create(rr, ", and the block it lands on carries the player to " + (lx + b1.X0 - b0.X0) + "," + (ly + b1.Y0 - b0.Y0), b1.Y0 < b0.Y0 ? 2 : -3));
                        }
                        foreach (var tg in targets)
                        {
                            if (tg.Item1 == RegionNear(subs[s2], fx, fy) && tg.Item2 == "") continue;   // (no better than shooting and staying)
                            string how = "shoot (or throw at) the switch at " + sw.X + "," + sw.Y + " from " + fx + "," + fy + ", and while the shot flies, "
                                + mv.Item5 + "; lands at " + lx + "," + ly + " (tick " + mv.Item3 + ")" + tg.Item2 + ": [" + StateWords(rd, s2) + "]";
                            foreach (var w in new[] { Tuple.Create("belmont:2", 15.0), Tuple.Create("megaman:1", 12.0), Tuple.Create("link:2", 12.0), Tuple.Create("samus:1", 11.5) })
                            {
                                if (mv.Item3 > (int)(dist / w.Item2) + tg.Item3) continue;
                                var l = Req.Max(mv.Item4, Req.ParseAlts(w.Item1)[0]);
                                if (!seenD.Add(fk.Key + ">" + tg.Item1 + ":" + l.Id + (tg.Item2 == "" ? "" : ":ride"))) continue;
                                parent.Edges.Add(new Edge { From = fk.Key + off[s], To = tg.Item1 + off[s2], L = l, How = how });
                            }
                        }
                    }
                }
            }
        }
        // enemies' shots and traps hit the red and blue switches by themselves: the player waits where they are for the state
        // they need
        int rbg = rd.Groups.IndexOf("rb");
        if (rd.RbAuto && rbg >= 0 && rbg < G)
            for (int s = 0; s < nS; s++)
            {
                if (rd.BadLevel(s)) continue;
                int s2 = s ^ (1 << rbg);
                var seenS = new HashSet<long>();
                foreach (var kv in subs[s].PosRegion)
                {
                    int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key;
                    int r2 = RegionNear(subs[s2], x, y);
                    if (r2 < 0 || !seenS.Add(((long)kv.Value << 32) | (uint)r2)) continue;
                    parent.Edges.Add(new Edge { From = kv.Value + off[s], To = r2 + off[s2], L = new Req(), How = "wait at " + x + "," + y + " for an enemy's shot or a trap to hit a red or blue switch: [" + StateWords(rd, s2) + "]" });
                }
            }
        foreach (var sub in subs) sub.SolidC = sub.SolidO = sub.Plat = sub.Haz = sub.Water = sub.GhostB = sub.HazV = null;
    }

    // (s: the room's state the exit's gone through in, for one whose way goes by a carried group)
    static void AddExit(Room[] rooms, int[] baseOf, List<KeyValuePair<int, Req>>[] adj, int from, Room r, int k, int s, Req l, List<Req> attack)
    {
        var e = r.Exits[k];
        string dest = e.ToIn(s);
        int ti;
        if (!RoomIx.TryGetValue(dest, out ti) || rooms[ti] == null) return;
        int en;
        if (!rooms[ti].EntryNode.TryGetValue(Shape.Key(e.NXIn(s), e.NYIn(s)), out en)) return;
        int to = baseOf[ti] + en;
        // into a boss's room: its fight comes first (the Randomizer starts it), and needs an attack
        if ((rooms[ti].Data.Boss && rooms[ti] != r) || Via.Contains(r.Data.Name + ">" + dest))
            foreach (var a in attack) adj[from].Add(new KeyValuePair<int, Req>(to, Req.Max(l, a)));
        else adj[from].Add(new KeyValuePair<int, Req>(to, l));
    }

    // the room state a node of a room is in (a room with switch states: each state's nodes in a row)
    static int StateOfNode(Room r, int node)
    {
        int st = 0;
        if (r.StateOff != null) for (int i = 0; i < r.StateOff.Length; i++) if (node >= r.StateOff[i]) st = i;
        return st;
    }
}
