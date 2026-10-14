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
// what a way needs: counts of the progression items (4 bits each) and the locked doors' keys (a bit each, by objectNum)
public struct Req : IEquatable<Req>
{
    public ulong C, K;
    public const int DJUMP = 0, ADASH = 1, GDASH = 2, HIJUMP = 3, MARIO = 4, LINK = 5, BELMONT = 6, MEGAMAN = 7, SAMUS = 8,
        GAMEJ = 9, GAMEC = 10, N = 11;
    public static readonly string[] Names = { "djump", "adash", "gdash", "hijump", "mario", "link", "belmont", "megaman",
        "samus", "gamej", "gamec" };
    public int Get(int i) { return (int)((C >> (i * 4)) & 15); }
    public Req With(int i, int n)
    {
        Req r = this;
        if (n > Get(i)) r.C = (C & ~(15UL << (i * 4))) | ((ulong)n << (i * 4));
        return r;
    }
    public static Req Max(Req a, Req b)
    {
        Req r; r.K = a.K | b.K; r.C = 0;
        for (int i = 0; i < N; i++) r.C |= (ulong)Math.Max(a.Get(i), b.Get(i)) << (i * 4);
        return r;
    }
    public bool Le(Req b)
    {
        if ((K & ~b.K) != 0) return false;
        for (int i = 0; i < N; i++) if (Get(i) > b.Get(i)) return false;
        return true;
    }
    public bool Equals(Req o) { return C == o.C && K == o.K; }
    public override bool Equals(object o) { return o is Req && Equals((Req)o); }
    public override int GetHashCode() { return (C ^ (K * 0x9E3779B97F4A7C15UL)).GetHashCode(); }
    public override string ToString()
    {
        var p = new List<string>();
        for (int i = 0; i < N; i++)
        {
            int n = Get(i);
            if (n == 1 && (i == DJUMP || i == ADASH || i == GDASH || i == MARIO)) p.Add(Names[i]);
            else if (n > 0) p.Add(Names[i] + ":" + n);
        }
        for (int k = 0; k < 64; k++) if ((K & (1UL << k)) != 0) p.Add("key:" + k);
        return p.Count == 0 ? "-" : string.Join(",", p);
    }
    // "a|b": alternatives; each comma-separated item:count (key:N a door's key, attack any ability set's attack)
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

    static Mask Load(string name)
    {
        string dir = Path.Combine(Root, "sprites", name);
        var k = Kv(Path.Combine(dir, "sprite.txt"));
        string png = Path.Combine(dir, "0.png");
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

    // calls set(x, y) for every room pixel the instance covers (its mask at its place, scale and angle)
    public void Stamp(double x, double y, double xs, double ys, double ang, Action<int, int> set)
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
    public Shape(Mask m, double x, double y, double xs, double ys, double a)
    {
        X0 = int.MaxValue; Y0 = int.MaxValue; X1 = int.MinValue; Y1 = int.MinValue;
        m.Stamp(x, y, xs, ys, a, (px, py) =>
        {
            Px.Add(Key(px, py));
            if (px < X0) X0 = px; if (px > X1) X1 = px; if (py < Y0) Y0 = py; if (py > Y1) Y1 = py;
        });
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
}
class RoomData
{
    public string Name, AreaName = ""; public int W, H, Area; public bool IsMap; public bool Boss;
    public List<Inst> I = new List<Inst>();
    // what the room's switches change: its groups (pb the sliding blocks and gears, rb the red and blue blocks, b<GID> a
    // barrier), and the state it starts in (a bit a group: 1 its other state)
    public List<string> Groups = new List<string>();
    public int Initial;
    // a state's solids that stay in every state (the bricks the head can't get to: AnalyzeStates)
    public HashSet<Inst> KeepSolid;
    public int Group(string name) { int i = Groups.IndexOf(name); if (i < 0) { Groups.Add(name); i = Groups.Count - 1; } return i; }
}

class Exit { public Shape S; public string To; public int NX, NY, Type; public bool InRoom; public int IX, IY; public string Obj; }   // IX,IY: where it's placed
class Loc { public int Type, Num; public Shape S; public string Label; }
class Gate { public Shape S; public List<Req> Need; public string Name; public int Group; }   // Group: the room's gates by what opens them
class Spring { public Shape S; public bool Large; }

// ---------------------------------------------------------------- the player (characterStepEvent at 30fps)
class In { public bool L, R, J, D, DL, DR; }

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
    public bool AfterBounce;                                 // H1 till a spring bounces the player, then H2
    public bool FromHang;                                    // starts hanging from a Strike Chain point (jumping off it if JumpAt is 0)
    public bool Entering;                                    // coming into the room (where the last one's exit puts the player)
    public bool FromWall;                                    // starts beside a wall in the air (Dir: towards it), kicking off it if JumpAt is 0
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
    public int kLSteps, kRSteps, lastXI, lastYI;
    public bool dead;
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
    public bool PlatBottom() { return R.Plat.Row(y - 1, x - 7, x + 6); }
    public bool PlatBody() { return R.Plat.Box(x - 7, y - top, x + 6, y - 2); }
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

    public void Jump() { yAcc += ija; state = FALLING; jbr = false; jumpTime = 0; }
    void DoubleJump() { yVel = 0; yAcc += djAcc; jumpTime = 3; jbr = false; djc = 0; bounce = 0; }
    void AirDash()
    {
        canAirDash = 0; dmt = ch == 0 ? 22 : 15; dashEnergy -= 2000; yAcc += ija / 2;
        if (adr < 7) adr = 6;
        bounce = 0;
    }
    void DashForward()
    {
        if (ch == 0) { dmt = 13; gdr = 8; bdr = 0; }
        else { dmt = 25; yAcc += ija / 2; state = FALLING; }
        dashEnergy -= 2000;
        xAcc += xVel; xVel = facing * 14;
        jbr = false; jumpTime = 0;
    }
    // stomping a Mario enemy in the air with the jump held (oEMarioBase's collision): up at -13.5, the gravity nearly back,
    // a moment's slow fall, and the double jump and air dash back
    public void Stomp()
    {
        yVel = -13.5 * Slack; if (jumpTime < jtt - 5) jumpTime = jtt - 5;
        if (sft < 5) { sft = 5; sfe = 0.4; }
        canAirDash = 1; djc = 1; state = JUMPING;
    }
    void WallJump(int right)
    {
        jumpTime = 0; jbr = false; kR = false; kRRel = true; kL = false; kLRel = true;
        xAcc = xVel / 4; yAcc += ija; yVel = -0.05; wjt = 3;
        sft = 5; sfe = 0.5; canAirDash = 1; djc = 1;
        xVel = right == 0 ? -6 : 6;
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
        Move(xFric, yFric);
        if (y > R.Data.H + 64) dead = true;
        else if (y < -32) yVel = 4;
        if (x < 0) { xVel = 0; x = 0; } else if (x > R.Data.W) { xVel = 0; x = R.Data.W; }
        t30++;
    }
}

// ---------------------------------------------------------------- one room
// a join between two of a room's nodes (places the player stands, ways in, Strike Chain points...), what it needs and,
// in words, how it's done (the room files' "how": RoomLogic writes them, solve.py doesn't need them)
class Edge { public int From, To; public Req L; public string How; }
class Touch { public int From; public int Kind; public int Index; public Req L; public string How; }   // Kind 0 location, 1 exit

class Room
{
    public RoomData Data;
    public Bits2D SolidC, SolidO, Plat, Haz, Water, GhostB;
    public List<Gate> Gates = new List<Gate>();
    public Dictionary<string, int> GateGroupOf = new Dictionary<string, int>();
    public List<List<Req>> GroupNeed = new List<List<Req>>();
    public List<Spring> Springs = new List<Spring>();
    public List<Exit> Exits = new List<Exit>();          // this room's exits (global index in Exit.Room... see Global)
    public List<int> ExitIds = new List<int>();
    public List<Loc> Locs = new List<Loc>();
    public List<int> LocIds = new List<int>();
    public List<Shape> Elevators = new List<Shape>();
    // moving platforms: the top of each along its path, as jump-through floor (the player waits for it and rides it); which
    // platform each such pixel is
    public Dictionary<long, int> Ghost = new Dictionary<long, int>();
    public int Movers;
    // Strike Chain points (Mega Man's grapple: the player hangs under one, then jumps or drops), and each one's node
    public List<int[]> Points = new List<int[]>();
    public int[] HangNode = new int[0];
    // flying enemies the Mario Ability Set bounces off (where they start)
    public List<int[]> Bouncers = new List<int[]>();
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
    public int Sims;
    // a room with switch states (AnalyzeStates): each state's first node and how many regions it has
    public int[] StateOff, StateRegions;
    public int StateInit;
    // each node in words ("standing at x 590-790, y 593", "hanging from the Strike Chain point at 544,112"...)
    public Dictionary<int, string> NodeName = new Dictionary<int, string>();
    // the ways in that can't be come in at (inside a solid), for the room file
    public List<string> BadEntries = new List<string>();

    public Room(RoomData d) { Data = d; }
}

class Analyzer
{
    Room R;
    HashSet<string> edgeSeen = new HashSet<string>();
    HashSet<string> touchSeen = new HashSet<string>();

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
        foreach (var p in Programs(false, true, true, true, true, true))
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

    public void Build()
    {
        var d = R.Data;
        R.SolidC = new Bits2D(d.W, d.H); R.SolidO = new Bits2D(d.W, d.H); R.Plat = new Bits2D(d.W, d.H);
        R.Haz = new Bits2D(d.W, d.H); R.Water = new Bits2D(d.W, d.H); R.GhostB = new Bits2D(d.W, d.H);
        var falling = new List<Loc>();
        foreach (var it in d.I)
        {
            if (it.K == 'M' || it.K == 'B' || it.K == 'Q') continue;
            if (it.K == 'F') { R.Bouncers.Add(new[] { (int)Math.Round(it.X), (int)Math.Round(it.Y) }); continue; }
            var m = Mask.Get(it.Spr);
            if (m == null) { R.Log.Add("no mask: " + it.Spr); continue; }
            switch (it.K)
            {
                case 'S': m.Stamp(it.X, it.Y, it.XS, it.YS, it.A, (x, y) => { R.SolidC.Set(x, y); R.SolidO.Set(x, y); }); break;
                case 'P': m.Stamp(it.X, it.Y, it.XS, it.YS, it.A, (x, y) => R.Plat.Set(x, y)); break;
                case 'H': m.Stamp(it.X, it.Y, it.XS, it.YS, it.A, (x, y) => R.Haz.Set(x, y)); break;
                case 'W': m.Stamp(it.X, it.Y, it.XS, it.YS, it.A, (x, y) => R.Water.Set(x, y)); break;
                case 'G':
                    {
                        var g = new Gate { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), Need = Req.ParseAlts(it.F[0]), Name = it.F.Length > 1 ? it.F[1] : "" };
                        if (g.S.Empty) break;
                        bool free = g.Need.Count == 1 && g.Need[0].C == 0 && g.Need[0].K == 0;
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
                case 'J': R.Springs.Add(new Spring { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), Large = it.F[0] == "L" }); break;
                case 'X':
                    R.Exits.Add(new Exit { S = new Shape(m, it.X, it.Y, it.XS, it.YS, it.A), To = it.F[0], NX = (int)Math.Round(double.Parse(it.F[1], CultureInfo.InvariantCulture)), NY = (int)Math.Round(double.Parse(it.F[2], CultureInfo.InvariantCulture)), Type = int.Parse(it.F[3]),
                        IX = (int)Math.Round(it.X), IY = (int)Math.Round(it.Y), Obj = it.F.Length > 4 ? it.F[4] : "" });
                    break;
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
                case 'V': R.Elevators.Add(new Shape(m, it.X, it.Y, it.XS, it.YS, it.A)); break;
                case 'K': R.Points.Add(new[] { (int)Math.Round(it.X), (int)Math.Round(it.Y) }); break;
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
    public bool HazardAt(int x, int y, int top) { return R.Haz.Any && R.Haz.Box(x - 7, y - Math.Max(top, 46), x + 6, y - 2); }

    // Gates: bit set of the gates the body is in (open-only places). Cling: beside a wall in the air, where the game has
    // wall jumps (the player climbs any wall there by kicking off it): the side it's on (1 right, -1 left), else 0
    class Pos { public int X, Y; public int Gates; public int Cling; }

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
                }
                else if (wallArea && top == 40 && runC >= top - 1)
                {
                    int side = R.SolidC.Col(x + 7, y - top, y - 2) ? 1 : (R.SolidC.Col(x - 8, y - top, y - 2) ? -1 : 0);
                    if (side != 0 && !HazardAt(x, y, top)) outp.Add(new Pos { X = x, Y = y, Cling = side });
                }
                else if (R.Gates.Count > 0 && runO >= top - 1 && (occO[i] || (R.Plat.Any && R.Plat.Row(yy, x - 7, x + 6) && !R.Plat.Box(x - 7, y - top, x + 6, y - 2)) || R.GhostB.Row(yy, x - 7, x + 6)))
                {
                    if (!HazardAt(x, y, top))
                    {
                        int gs = 0;
                        foreach (var gt in R.Gates) if (gt.Group < 31 && gt.S.Hits(x - 7, y - top, x + 6, y - 2)) gs |= 1 << gt.Group;
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
            AddEdge(a, b, GatesNeed(pb.Gates), "walk from " + pa.X + "," + pa.Y + " to " + pb.X + "," + pb.Y + (pb.Gates != 0 ? " into " + GatesWords(pb.Gates, pb.X, pb.Y) : ""));
            AddEdge(b, a, GatesNeed(pa.Gates), "walk from " + pb.X + "," + pb.Y + " to " + pa.X + "," + pa.Y + (pa.Gates != 0 ? " into " + GatesWords(pa.Gates, pa.X, pa.Y) : ""));
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
        string k = a + ">" + b + ":" + l.C + ":" + l.K;
        if (!edgeSeen.Add(k)) return;
        R.Edges.Add(new Edge { From = a, To = b, L = l, How = how });
    }
    // a move's join (its words are only made for a join that's new): from sx,sy, then (end) 0 lands at ex,ey, 1 clings to
    // the wall at ex,ey, 2 fires the Strike Chain at the point at ex,ey
    void AddEdge(int a, int b, Req l, Prog p, int sx, int sy, int end, int ex, int ey, int gates = 0)
    {
        if (a == b) return;
        string k = a + ">" + b + ":" + l.C + ":" + l.K;
        if (!edgeSeen.Add(k)) return;
        string e = end == 0 ? "lands at " + ex + "," + ey : end == 1 ? "clings to the wall at " + ex + "," + ey : "fires the Strike Chain at the point at " + ex + "," + ey;
        R.Edges.Add(new Edge { From = a, To = b, L = l, How = Describe(p) + ", from " + sx + "," + sy + (gates != 0 ? ", through " + GatesWords(gates, int.MinValue, 0) : "") + "; " + e });
    }
    void AddTouch(int from, int kind, int index, Req l, string how)
    {
        string k = from + ">" + kind + ":" + index + ":" + l.C + ":" + l.K;
        if (!touchSeen.Add(k)) return;
        R.Touches.Add(new Touch { From = from, Kind = kind, Index = index, L = l, How = how });
    }
    void AddTouch(int from, int kind, int index, Req l, Prog p, int sx, int sy, int gates = 0)
    {
        string k = from + ">" + kind + ":" + index + ":" + l.C + ":" + l.K;
        if (!touchSeen.Add(k)) return;
        R.Touches.Add(new Touch { From = from, Kind = kind, Index = index, L = l, How = Describe(p) + ", from " + sx + "," + sy + (gates != 0 ? ", through " + GatesWords(gates, int.MinValue, 0) : "") + "; touches it on the way" });
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
        if (p.FromWall) pre.Add("on the wall to the " + fwd + ":");
        if (p.Morph) pre.Add("as the Morph Ball:");
        if (p.BombJump) s.Add("a bomb jump (a morph bomb under the ball)");
        if (p.DropDown) s.Add("drop down through the platform");
        if (p.RunStart) s.Add("running " + fwd);
        if (p.GdAt >= 0) s.Add(p.Ch == 0 ? "dash " + fwd + " (Jerry)" : "dash-hop " + fwd + " (Claire)");
        if (p.FromWall && p.JumpAt >= 0) s.Add("kick off it (wall jump)");
        else if (p.JumpAt >= 0) s.Add((p.HiJump > 0 ? "jump with High Jump Boots " + p.HiJump : "jump") + " (held " + p.JumpHold + " ticks)");
        else if (!p.FromHang && !p.FromWall && !p.DropDown && !p.BombJump && p.GdAt < 0 && !p.Entering) s.Add(p.Morph ? "roll off the edge" : "walk off the edge");
        if (p.WallMode == 0) s.Add("wall-jump up the same wall");
        if (p.WallMode == 1) s.Add("wall-jump between the walls");
        if (p.AfterBounce) s.Add("onto the spring, holding " + way(p.H1) + " till it bounces, then " + way(p.H2));
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
        if (p.DjAt >= 0) s.Add("double jump at tick " + p.DjAt);
        if (p.AdAt >= 0) s.Add("air dash" + (p.AdDir != 0 && p.AdDir != p.Dir ? " back " + back : "") + " (" + who + ") at tick " + p.AdAt + (p.AdClear ? " or once there's room ahead" : ""));
        return (pre.Count > 0 ? string.Join(" ", pre) + " " : "") + string.Join(", ", s);
    }

    // the touch boxes: sJerryIdle's and sJerryJump's bounding boxes, a few pixels in (nothing counts that the player has
    // to brush with the edge of their sprite)
    static void StandBox(int x, int y, out int x0, out int y0, out int x1, out int y1) { x0 = x - 3; x1 = x + 2; y0 = y - 42; y1 = y - 7; }
    static void AirBox(int x, int y, out int x0, out int y0, out int x1, out int y1) { x0 = x - 2; x1 = x + 2; y0 = y - 36; y1 = y - 13; }

    // a landing the logic counts: with floor (or a wall) 4px to either side, not on the very edge of a ledge
    bool SafeLanding(int lx, int ly, bool morph, bool open)
    {
        var map = morph ? R.MPosRegion : R.PosRegion;
        var solid = open ? R.SolidO : R.SolidC;
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
    bool morphOnly;   // the room has places only the Morph Ball fits
    List<int> normalReg, morphReg;
    Dictionary<int, int> normalGates, morphGates;
    int morphBase;

    public void Analyze()
    {
        Build();
        var d = R.Data;
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
        // normal <-> morph: morphing needs the Morph Ball (Samus 2); unmorphing needs room for the body
        var samus2 = new Req().With(Req.SAMUS, 2);
        var linked = new HashSet<long>();
        for (int i = 0; i < morphPs.Count; i++)
        {
            int nr;
            if (!R.PosRegion.TryGetValue(Shape.Key(morphPs[i].X, morphPs[i].Y), out nr)) continue;
            int mr = morphReg[i];
            if (!linked.Add(((long)nr << 32) | (uint)mr)) continue;
            AddEdge(nr, mr, samus2, "turn into the Morph Ball at " + morphPs[i].X + "," + morphPs[i].Y);
            AddEdge(mr, nr, new Req(), "turn back from the Morph Ball at " + morphPs[i].X + "," + morphPs[i].Y);
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
        // moves from each region
        Launches(normal, normalReg, false);
        Launches(morphPs, morphReg, true);
        Elevators();
        GapSearch();
    }

    // the timings the moves above don't try, where they might matter: from each region to each one near it (up to 200px
    // above it or 100px below, 360px across) it has no move to yet, every combination of how long the jump is held,
    // when the double jump and the air dash come and when to steer, from its two places nearest the other. A move
    // found counts if it lands there with all its timings a tick earlier or later too (nothing frame-perfect)
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
                if (a == b || has.Contains(((long)a << 32) | (uint)b)) continue;
                if (reach[b] != null && reach[b].Any(q => q.C == 0 && q.K == 0)) continue;
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
            for (int j = 0; j < R.Locs.Count; j++) if (R.Locs[j].S.Hits(x0, y0, x1, y1)) AddTouch(reg[i], 0, j, new Req(), (top < 40 ? "as the Morph Ball, " : "") + "standing at " + p.X + "," + p.Y + ", touches it");
            for (int j = 0; j < R.Exits.Count; j++)
            {
                var ex = R.Exits[j];
                bool hit = ex.Type == 3 ? ex.S.Hits(p.X - 7, p.Y - 2, p.X + 6, p.Y + 1) : ex.S.Hits(x0, y0, x1, y1);
                if (hit) AddTouch(reg[i], 1, j, new Req(), (top < 40 ? "as the Morph Ball, " : "") + "standing at " + p.X + "," + p.Y + ", " + ExitAction(ex));
            }
        }
    }

    // how an exit is gone through, in words
    public static string ExitAction(Exit ex)
    {
        if (ex.Obj == "menu") return "chooses it from the menu";
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
    List<Prog> Programs(bool morph, bool platform, bool runL, bool runR, bool spring = false, bool bouncer = false)
    {
        var ps = new List<Prog>();
        var none = new Req();
        var dj = new Req().With(Req.DJUMP, 1);
        var ad = new Req().With(Req.ADASH, 1);
        var gd = new Req().With(Req.GDASH, 1);
        var djad = Req.Max(dj, ad);
        int area = R.Data.Area;
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
            // double jump or air dash
            var djM = new Req().With(Req.DJUMP, 1);
            var adM = new Req().With(Req.ADASH, 1);
            foreach (int d in new[] { -1, 1 })
            {
                bool run = d < 0 ? runL : runR;
                ps.Add(new Prog { Name = "roll-unmorph", Ch = 1, Dir = d, RunStart = run, H1 = 1, H2 = 1, HDelay = 1, NoInputTillAir = true, Morph = true, AutoUnmorph = true, Label = none, MaxT = 80 });
                ps.Add(new Prog { Name = "roll-unmorph-dj", Ch = 1, Dir = d, RunStart = run, H1 = 1, H2 = 1, HDelay = 1, NoInputTillAir = true, Morph = true, AutoUnmorph = true, DjAt = 6, Label = djM, MaxT = 80 });
                ps.Add(new Prog { Name = "roll-unmorph-ad", Ch = 0, Dir = d, RunStart = run, H1 = 1, H2 = 1, HDelay = 1, NoInputTillAir = true, Morph = true, AutoUnmorph = true, AdAt = 6, Label = adM, MaxT = 80 });
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
                }
        // near a flying enemy the Mario Ability Set stomps: jumping, bouncing off it near the top (it can be waited for or
        // led there), on with a double jump or an air dash after (the stomp gives both back)
        if (bouncer)
        {
            var mario = new Req().With(Req.MARIO, 1);
            ps.Add(new Prog { Name = "bounceup", Ch = 1, Dir = 1, JumpAt = 0, JumpHold = 40, BounceAt = 12, H1 = 0, H2 = 0, Label = mario, MaxT = 120 });
            foreach (int d in new[] { -1, 1 })
            {
                ps.Add(new Prog { Name = "bounce", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 40, BounceAt = 12, H1 = 1, H2 = 1, Label = mario, MaxT = 120 });
                ps.Add(new Prog { Name = "bounce-late", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 40, BounceAt = 12, H1 = 0, H2 = 1, HDelay = 22, Label = mario, MaxT = 120 });
                ps.Add(new Prog { Name = "bouncedj", Ch = 1, Dir = d, JumpAt = 0, JumpHold = 40, BounceAt = 12, DjAt = 32, H1 = 0, H2 = 1, HDelay = 22, Label = Req.Max(mario, dj), MaxT = 120 });
                ps.Add(new Prog { Name = "bouncead", Ch = 0, Dir = d, JumpAt = 0, JumpHold = 40, BounceAt = 12, AdAt = 28, H1 = 0, H2 = 1, HDelay = 22, Label = Req.Max(mario, ad), MaxT = 120 });
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
            ps.Add(new Prog { Name = "hangjump-late", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, H1 = 0, H2 = 1, HDelay = 10, Label = none });
            ps.Add(new Prog { Name = "hangjumpdj", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, DjAt = 12, H1 = 0, H2 = 1, HDelay = 12, Label = dj });
            ps.Add(new Prog { Name = "hangjumpdj-across", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, DjAt = 12, H1 = 1, H2 = 1, Label = dj });
            ps.Add(new Prog { Name = "hangjumpad", Ch = 0, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, AdAt = 10, H1 = 1, H2 = 1, Label = ad });
            ps.Add(new Prog { Name = "hangjumpad-early", Ch = 0, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, AdAt = 4, H1 = 1, H2 = 1, Label = ad });
            ps.Add(new Prog { Name = "hangjumpad-claire", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, AdAt = 8, H1 = 1, H2 = 1, Label = ad });
            // (both: an air dash, then a double jump; or the other way round)
            ps.Add(new Prog { Name = "hangjumpaddj", Ch = 0, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, AdAt = 6, DjAt = 16, H1 = 1, H2 = 1, Label = Req.Max(dj, ad) });
            ps.Add(new Prog { Name = "hangjumpdjad", Ch = 1, Dir = d, FromHang = true, JumpAt = 0, JumpHold = 21, DjAt = 10, AdAt = 18, H1 = 1, H2 = 1, Label = Req.Max(dj, ad) });
            ps.Add(new Prog { Name = "hangdrop", Ch = 1, Dir = d, FromHang = true, H1 = 1, H2 = 1, Label = none });
        }
        ps.Add(new Prog { Name = "hangdropdown", Ch = 1, Dir = 1, FromHang = true, H1 = 0, H2 = 0, Label = none });
        return ps;
    }

    class Result { public int LandX = int.MinValue, LandY; public List<int> Locs = new List<int>(); public List<int> Exits = new List<int>(); public List<int> Hangs = new List<int>(); public List<long> Clings = new List<long>(); public int Gates; public bool Morph, Morphed; }

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

    Result Run(Prog p, int sx, int sy, bool open, bool morphStart, bool airStart, bool elevator)
    {
        var s = new Sim { R = R, S = open ? R.SolidO : R.SolidC, Open = open, x = sx, y = sy, ch = p.Ch, facing = p.Dir };
        s.runAcc = p.Ch == 0 ? 6.6 : 7.3;
        s.hasDJ = p.Label.Get(Req.DJUMP) > 0; s.hasAD = p.Label.Get(Req.ADASH) > 0; s.hasGD = p.Label.Get(Req.GDASH) > 0;
        s.wallArea = (R.Data.Area == 29 || R.Data.Area == 91 || R.Data.Area == 104);
        if (p.HiJump == 1) { s.ija = -7.8; s.jtt = 28; }
        else if (p.HiJump == 2) { s.ija = -9.4; s.jtt = 35; }
        s.jumpTime = s.jtt; s.gi = s.grav;
        // jumps, air dashes and springs a bit weaker than the game's (about 10% lower), so nothing the logic counts needs
        // a pixel-perfect jump (and the 60/120fps game's jumps are a pixel or two off the 30fps ones)
        s.ija *= Sim.Slack; s.djAcc *= Sim.Slack;
        if (morphStart) { s.morph = true; s.top = 13; }
        s.state = airStart ? Sim.FALLING : Sim.STANDING;
        if (elevator) { s.ex = true; s.ex0 = sx - 16; s.ex1 = sx + 15; s.ey0 = sy; s.ey1 = sy + 50; }
        if (p.FromWall)
        {
            // (sliding down it: the game's wall grab keeps a double jump or air dash from firing on the kick's press)
            s.state = Sim.FALLING; s.wallGrab = true; s.facing = p.Dir;
            if (p.Dir < 0) { s.kL = true; s.kLSteps = 5; } else { s.kR = true; s.kRSteps = 5; }
        }
        if (p.FromHang)
        {
            s.state = Sim.FALLING; s.canAirDash = 1; s.djc = 1;
            if (p.JumpAt == 0) { s.yAcc += s.ija; s.jbr = false; s.jumpTime = 0; s.kJ = true; }
        }
        if (p.RunStart && !airStart)
        {
            s.xVel = p.Dir * (morphStart ? 7.6 : (p.Ch == 0 ? 6.6 : 7.3)); s.state = Sim.RUNNING;
            if (p.Dir < 0) { s.kL = true; s.kLSteps = 5; } else { s.kR = true; s.kRSteps = 5; }
        }
        var res = new Result();
        bool wasAir = airStart, airborne = airStart, bounced = false;
        int bounceT = 0;
        int airT = 0, wallFlip = 1;
        bool prevJ = false;
        var inp = new In();
        int x0 = s.x, y0 = s.y;
        int roomT = 0;
        bool adDone = false;
        for (int t = 0; t < p.MaxT; t++)
        {
            // the input this tick
            int hs;
            int tt = p.NoInputTillAir ? (airborne ? airT : -1) : t;
            if (p.AfterBounce) hs = bounced ? p.H2 : p.H1;
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
            inp.D = p.DropDown && t == 0;
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
            int px = s.x, py = s.y;
            s.Step(inp);
            if (traceOn) Console.WriteLine("  t{0} {1},{2} state {3} vel {4:F2},{5:F2} keys {6}{7}{8}{9} bounce {10}", t, s.x, s.y, s.state, s.xVel, s.yVel, inp.L ? "L" : "", inp.R ? "R" : "", inp.J ? "J" : "", inp.DL || inp.DR ? "D" : "", s.bounce);
            if (s.InAir) { airborne = true; }
            if (airborne) airT++;
            if (p.WallMode == 1 && s.wjt == 3) wallFlip = -wallFlip;
            // touching things at the end of the tick (the game's collision events)
            int bx0, by0, bx1, by1;
            if (s.OnGround) StandBox(s.x, s.y, out bx0, out by0, out bx1, out by1); else AirBox(s.x, s.y, out bx0, out by0, out bx1, out by1);
            if (s.morph) by0 = s.y - 12;
            if (HazardAt(s.x, s.y, s.top)) return res;
            if (s.dead) return res;
            if (open && R.Gates.Count > 0)
            {
                int ax0 = Math.Min(px, s.x) - 7, ax1 = Math.Max(px, s.x) + 6, ay0 = Math.Min(py, s.y) - s.top, ay1 = Math.Max(py, s.y) - 2;
                foreach (var gt in R.Gates) if (gt.Group < 31 && (res.Gates & (1 << gt.Group)) == 0 && gt.S.Hits(ax0, ay0, ax1, ay1)) res.Gates |= 1 << gt.Group;
            }
            for (int k = 0; k < R.Locs.Count; k++) if (R.Locs[k].S.Hits(bx0, by0, bx1, by1) && !res.Locs.Contains(k)) res.Locs.Add(k);
            for (int k = 0; k < R.Exits.Count; k++)
            {
                var e = R.Exits[k];
                bool hit = e.Type == 3 ? (s.OnGround && e.S.Hits(s.x - 7, s.y - 2, s.x + 6, s.y + 1)) : e.S.Hits(bx0, by0, bx1, by1);
                if (!hit || res.Exits.Contains(k)) continue;
                res.Exits.Add(k);
                if (e.Type == 1 && !e.InRoom) return res;   // walked into: gone at once
            }
            // beside a wall in the air where the game has wall jumps: on that wall (it can be climbed from there)
            if (wallArea && !s.morph && s.InAir && (s.ColRight(1) || s.ColLeft(1)))
            {
                long ck = Shape.Key(s.x, s.y);
                if (R.PosRegion.ContainsKey(ck) && !res.Clings.Contains(ck)) res.Clings.Add(ck);
            }
            if (R.Points.Count > 0 && !s.morph && (s.OnGround || Math.Abs(s.yVel) <= 4))
                foreach (int k in ChainReach(s.x, s.y)) if (!res.Hangs.Contains(k)) res.Hangs.Add(k);
            if (s.yVel > 0)
                foreach (var sp in R.Springs)
                    if (sp.S.Hits(bx0, by0, bx1, by1) && s.bounce <= 0)
                    {
                        s.canAirDash = 1; s.djc = 1;
                        s.yVel = (sp.Large ? -16 : -14) * Sim.Slack; s.bounceVel = s.yVel; s.bounce = sp.Large ? 7 : 3;
                        if (s.OnGround) s.state = Sim.JUMPING;
                        if (!bounced) bounceT = t;
                        bounced = true;
                    }
            if (airborne && s.OnGround && (s.x != x0 || s.y != y0 || t > 0))
            {
                res.LandX = s.x; res.LandY = s.y; res.Morph = s.morph;
                return res;
            }
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
        foreach (int k in res.Locs) foreach (var l in need) AddTouch(from, 0, k, l, p, sx, sy, gates);
        foreach (int k in res.Exits) foreach (var l in need) AddTouch(from, 1, k, l, p, sx, sy, gates);
        foreach (int k in res.Hangs) foreach (var l in need) AddEdge(from, R.HangNode[k], l.With(Req.MEGAMAN, 4), p, sx, sy, 2, R.Points[k][0], R.Points[k][1], gates);
        foreach (long ck in res.Clings) foreach (var l in need) AddEdge(from, R.PosRegion[ck], l, p, sx, sy, 1, (int)(ck >> 32), (int)(uint)ck, gates);
        if (res.LandX != int.MinValue && SafeLanding(res.LandX, res.LandY, res.Morph, open))
        {
            int to = RegionAt(res.LandX, res.LandY, res.Morph);
            if (to >= 0) foreach (var l in need) AddEdge(from, to, l, p, sx, sy, 0, res.LandX, res.LandY, gates);
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
                // (a flying enemy to bounce off within a screen or so)
                bool nearBouncer = !morph && R.Bouncers.Any(b => Math.Abs(b[0] - p.X) <= 320 && Math.Abs(b[1] - p.Y) <= 240);
                foreach (var prog in Programs(morph, onPlat, runL, runR, nearSpring, nearBouncer))
                {
                    // (a move that turns into the Morph Ball where it meets a wall, or back once there's room, and didn't:
                    // the same as the move without)
                    bool auto = prog.AutoMorph || prog.AutoUnmorph;
                    var res = Run(prog, p.X, p.Y, p.Gates != 0, morph, false, false);
                    R.Sims++;
                    if (!auto || res.Morphed) Record(rg, prog, res, p.Gates != 0, p.X, p.Y);
                    if (R.Gates.Count > 0 && p.Gates == 0)
                    {
                        var r2 = Run(prog, p.X, p.Y, true, morph, false, false);
                        R.Sims++;
                        if (r2.Gates != 0 && (!auto || r2.Morphed)) Record(rg, prog, r2, true, p.X, p.Y);
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

    // elevators (oUseElevator): the player rides one up or down its shaft and gets off anywhere along it; it starts at
    // the height the player came into the room at, so it reaches every floor beside its shaft
    void Elevators()
    {
        foreach (var e in R.Elevators)
        {
            int cx = (e.X0 + e.X1) / 2;
            // the shaft: where the elevator's box (-16..15 wide, 51 tall above its y) fits
            int top = e.Y1, bot = e.Y1;
            while (top > -32 && !R.SolidC.Box(cx - 16, top - 51 - 1, cx + 15, top - 1 - 1)) top--;
            while (bot < R.Data.H + 64 && !R.SolidC.Box(cx - 16, bot - 51 + 1, cx + 15, bot - 1 + 1)) bot++;
            int node = R.NNodes++;
            R.NodeName[node] = "riding the elevator at x " + cx + " (its shaft from y " + (top - 51) + " to " + (bot - 51) + ")";
            // onto it from beside the shaft: any standing place whose body is over the shaft's columns
            var seen = new HashSet<int>();
            foreach (var kv in R.PosRegion)
            {
                int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key;
                if (x + 6 < cx - 16 || x - 7 > cx + 15 || y < top - 51 || y > bot + 2) continue;
                if (seen.Add(kv.Value)) { AddEdge(kv.Value, node, new Req(), "step onto the elevator at " + x + "," + y); }
            }
            // off it at any height: the moves from standing on its top
            for (int ey = top; ey <= bot; ey += 8)
            {
                int py = ey - 51;  // the player's y standing on the elevator's top (its top row is ey-51)
                if (!Clear(R.SolidC, cx, py, 40)) continue;
                foreach (var prog in Programs(false, false, false, false))
                {
                    var res = Run(prog, cx, py, false, false, false, true);
                    R.Sims++;
                    if (!(prog.AutoMorph || prog.AutoUnmorph) || res.Morphed) Record(node, prog, res, false, cx, py);
                }
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
            if (f[0] == "R")
            {
                cur = new RoomData { Name = f[1], W = int.Parse(f[2]), H = int.Parse(f[3]), Area = int.Parse(f[4]), AreaName = f.Length > 5 ? f[5] : "" };
                RoomIx[cur.Name] = Rooms.Count; Rooms.Add(cur); continue;
            }
            if (cur == null) continue;
            if (f[0] == "Q") { cur.IsMap = true; continue; }
            if (f[0] == "B") { cur.Boss = true; continue; }
            if (f[0] == "M") continue;
            if (f[0] == "RS") { int gi = cur.Group(f[1]); cur.Initial |= int.Parse(f[2]) << gi; continue; }
            // (a switch: SW, kept as w; a state's solid: T, its group's number in F[0])
            var it = new Inst { K = f[0] == "SW" ? 'w' : f[0][0], Spr = f[1], X = D(f[2]), Y = D(f[3]), XS = D(f[4]), YS = D(f[5]), A = D(f[6]), F = f.Skip(7).ToArray() };
            if (it.K == 'T' || it.K == 'w' || it.K == 'U') it.F[0] = cur.Group(it.F[0]).ToString();
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
        room.Haz = new Bits2D(2000, 400); room.Water = new Bits2D(2000, 400); room.GhostB = new Bits2D(2000, 400);
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
            if (brk >= 0 && brk < 4) rd.KeepSolid = BricksKept(rd, brk);
            int st = si > 0 ? int.Parse(args[si + 1]) : rd.Initial;
            if (st != (rd.Initial & ((1 << Math.Min(rd.Groups.Count, 4)) - 1))) regName = rd.Name + "@" + st;
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
            if (brk >= 0 && brk < 4) rd.KeepSolid = BricksKept(rd, brk);
            rd = StateData(rd, si > 0 ? int.Parse(args[si + 1]) : rd.Initial);
        }
        if (si > 0) args = args.Take(si).ToArray();
        var room = new Room(rd);
        var an = new Analyzer(room);
        an.TraceMove(int.Parse(args[4]), int.Parse(args[5]), args[6], args.Length > 7 ? int.Parse(args[7]) : 1);
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
        new Analyzer(room).Analyze();
        foreach (var kv in room.EntryNode) Console.WriteLine("entry {0},{1} = node {2}", (int)(kv.Key >> 32), (int)(uint)kv.Key, kv.Value);
        foreach (var e in room.Edges.OrderBy(e => e.From).ThenBy(e => e.To)) Console.WriteLine("{0} > {1}: {2}", e.From, e.To, e.L);
        foreach (var t in room.Touches) Console.WriteLine("{0} touches {1} {2}: {3}", t.From, t.Kind == 0 ? "location" : "exit", t.Index, t.L);
        Console.WriteLine("log: " + string.Join(" / ", room.Log));
    }

    static void Main(string[] args)
    {
        if (args.Length > 0 && args[0] == "--test") { Test(); return; }
        if (args.Length > 0 && args[0] == "--edges") { Edges(args); return; }
        if (args.Length > 0 && args[0] == "--draw") { Draw(args); return; }
        if (args.Length > 0 && args[0] == "--trace") { Trace(args); return; }
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
                    rd.Name + (it.F.Length > 4 && it.F[4] == "menu" ? "'s menu" : " out " + (int)Math.Round(it.X) + "," + (int)Math.Round(it.Y)));
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
            room.SolidC = room.SolidO = room.Plat = room.Haz = room.Water = room.GhostB = null;
            // the room's file (its ways through, and how); the words aren't needed after it
            Dictionary<long, List<string>> cf;
            string file = RoomFile(room, cameFrom.TryGetValue(rd.Name, out cf) ? cf : new Dictionary<long, List<string>>());
            if (room.Log.Any(l => l.StartsWith("failed"))) file = "# THE ANALYSIS FAILED (work\\roomlogic_log.txt says why): this file may be missing ways\n" + file;
            File.WriteAllText(Path.Combine(roomsDir, rd.Name + ".txt"), file);
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
            for (int k = 0; k < r.Exits.Count; k++) AddExit(rooms, baseOf, adj, exitBase[ri] + k, r, k, new Req(), attack);
            // a map (an overworld): every entry reaches every exit
            if (r.Data.IsMap)
                foreach (var en in r.EntryNode.Values)
                    for (int k = 0; k < r.Exits.Count; k++) adj[b + en].Add(new KeyValuePair<int, Req>(exitBase[ri] + k, new Req()));
            foreach (var t in r.Touches)
            {
                if (t.Kind == 0) adj[b + t.From].Add(new KeyValuePair<int, Req>(locBase + locIx[r.Locs[t.Index].Type + " " + r.Locs[t.Index].Num], t.L));
                else adj[b + t.From].Add(new KeyValuePair<int, Req>(exitBase[ri] + t.Index, t.L));
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

    // an exit's name in the room files: where it's placed ("menu:<room>" for a menu's choices); a second one at the
    // same place gets (2)
    public static List<string> ExitIds(Room r)
    {
        var ids = new List<string>();
        foreach (var e in r.Exits)
        {
            string id = e.Obj == "menu" ? "menu:" + e.To : e.IX + "," + e.IY;
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
        if (d.Groups.Count > 0)
            sb.AppendLine("# switches: the room is worked out in each of its states, the player coming in in the first: [" + StateWords(d, d.Initial & ((1 << Math.Min(d.Groups.Count, 4)) - 1)) + "]");
        sb.AppendLine();
        sb.AppendLine("# Ways in: where the player appears coming into the room (and, in the game, the exits that lead there)");
        var entries = r.EntryNode.OrderBy(kv => kv.Value).ToList();
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
            sb.AppendLine("out " + exitIds[k] + "   # to " + (e.InRoom ? "this room" : e.To) + " at " + e.NX + "," + e.NY + "; the player " + Analyzer.ExitAction(e));
        }
        sb.AppendLine();
        sb.AppendLine("# Places: the Randomizer's locations (type number, as roomlogic.txt and logic.txt name them)");
        for (int j = 0; j < r.Locs.Count; j++)
        {
            var l = r.Locs[j];
            sb.AppendLine("loc " + l.Type + " " + l.Num + "   # " + l.Label + ", at " + (l.S.X0 + l.S.X1) / 2 + "," + (l.S.Y0 + l.S.Y1) / 2);
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
        foreach (var kv in entries)
        {
            string inId = (int)(kv.Key >> 32) + "," + (int)(uint)kv.Key;
            var steps = new List<Step>[N];
            var q = new Queue<int>(); var inQ = new bool[N];
            steps[kv.Value] = new List<Step> { new Step { L = new Req(), Node = kv.Value, How = null } };
            q.Enqueue(kv.Value); inQ[kv.Value] = true;
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
            // what each way out and place needs from here
            var targets = new List<KeyValuePair<string, List<Step>>>();
            for (int k = 0; k < r.Exits.Count; k++) targets.Add(new KeyValuePair<string, List<Step>>("out " + exitIds[k], new List<Step>()));
            for (int j = 0; j < r.Locs.Count; j++) targets.Add(new KeyValuePair<string, List<Step>>("loc " + r.Locs[j].Type + " " + r.Locs[j].Num, new List<Step>()));
            for (int u = 0; u < N; u++)
            {
                if (steps[u] == null) continue;
                foreach (var t in touchesAt[u])
                {
                    var tl = targets[t.Kind == 1 ? t.Index : r.Exits.Count + t.Index].Value;
                    foreach (var s in steps[u]) if (!s.Dead) AddStep(tl, Req.Max(s.L, t.L), s, -1, t.How, t.L);
                }
            }
            if (d.IsMap)
                for (int k = 0; k < r.Exits.Count; k++)
                    AddStep(targets[k].Value, new Req(), steps[kv.Value][0], -1, "on the map (or menu), choose it", new Req());
            table.AppendLine("from in " + inId);
            if (targets.Count == 0) { table.AppendLine("  (the room has no ways out or places)"); continue; }
            if (bad.Contains(inId)) { table.AppendLine("  (can't be come in at: nothing is reached from here)"); continue; }
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
                    how.AppendLine("     " + (r.NodeName.ContainsKey(kv.Value) ? r.NodeName[kv.Value] : "coming in at " + inId));
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
        sb.AppendLine("#   via <room> out <exit>                     going through that exit is a boss fight (it needs an attack); a room");
        sb.AppendLine("#                                             whose file says boss is one when it's come into from another room");
        sb.AppendLine("# (A way in whose room's file says it can't be come in at reaches nothing: the player would be inside a solid.)");
        sb.AppendLine("start " + StartRoom + " in " + StartX + "," + StartY);
        var via = new StringBuilder();
        foreach (var r in rooms)
        {
            if (r == null) continue;
            var ids = ExitIds(r);
            for (int k = 0; k < r.Exits.Count; k++)
            {
                var e = r.Exits[k];
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
    // an elemental attack (its platforms come out). A switch marked once only opens (a barrier; the ice's platforms)
    // a room in one of its switch states (a bit a group: its solids in that state; groups past the 4th as they start)
    static RoomData StateData(RoomData rd, int s)
    {
        int G = Math.Min(rd.Groups.Count, 4);
        var d2 = new RoomData { Name = rd.Name, W = rd.W, H = rd.H, Area = rd.Area, IsMap = rd.IsMap, Boss = rd.Boss };
        foreach (var it in rd.I)
        {
            if (it.K == 'w') continue;
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
        int G = Math.Min(rd.Groups.Count, 4);
        var w = new List<string>();
        for (int gi = 0; gi < G; gi++)
        {
            bool on = ((s >> gi) & 1) == 1;
            string g = rd.Groups[gi];
            if (g == "rb") w.Add(on ? "red blocks solid" : "blue blocks solid");
            else if (g == "pb") w.Add(on ? "sliding blocks moved" : "sliding blocks as placed");
            else if (g == "ice") w.Add(on ? "ice platforms out" : "no ice platforms");
            else if (g == "brk") w.Add(on ? "bricks broken" : "bricks whole");
            else if (g == "cpm") w.Add(on ? "platform makers' platforms out" : "no platform makers' platforms");
            else if (g.StartsWith("b")) w.Add(on ? "barrier " + g.Substring(1) + " open" : "barrier " + g.Substring(1) + " shut");
            else w.Add(g + (on ? " on" : " off"));
        }
        return string.Join(", ", w);
    }

    static void AnalyzeStates(Room parent)
    {
        var rd = parent.Data;
        int G = Math.Min(rd.Groups.Count, 4);
        int nS = 1 << G;
        int init = rd.Initial & (nS - 1);
        int brk = rd.Groups.IndexOf("brk");
        if (brk >= 0 && brk < G) rd.KeepSolid = BricksKept(rd, brk);
        var subs = new Room[nS];
        var off = new int[nS];
        int total = 0;
        for (int s = 0; s < nS; s++)
        {
            var sub = new Room(StateData(rd, s));
            if (s == init) sub.Entries.AddRange(parent.Entries);
            new Analyzer(sub).Analyze();
            subs[s] = sub; off[s] = total; total += sub.NNodes;
        }
        parent.NNodes = total;
        parent.NRegions = 0;
        parent.StateOff = off; parent.StateRegions = subs.Select(x => x.NRegions).ToArray(); parent.StateInit = init;
        parent.Exits = subs[0].Exits; parent.Locs = subs[0].Locs;
        parent.BadEntries = subs[init].BadEntries;
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
        foreach (var kv in subs[init].EntryNode) parent.EntryNode[kv.Key] = kv.Value + off[init];
        var attack = Req.ParseAlts("attack");
        // (a shot or a thrown weapon reaches further, along a clear line at the chest: the X-Buster, the Arm Cannon, the
        // bow, the dagger)
        var ranged = Req.ParseAlts("megaman:1|samus:1|link:2|belmont:2");
        // (an ice block takes an elemental attack: Shotgun Ice, a shot; Holy Water, thrown close)
        var iceNear = Req.ParseAlts("megaman:2|belmont:3");
        var iceFar = Req.ParseAlts("megaman:2");
        foreach (var sw in rd.I.Where(i => i.K == 'w'))
        {
            int gi = int.Parse(sw.F[0]);
            if (gi >= G) continue;
            var m = Mask.Get(sw.Spr);
            if (m == null) { parent.Log.Add("no mask for a switch: " + sw.Spr); continue; }
            var shape = new Shape(m, sw.X, sw.Y, sw.XS, sw.YS, sw.A);
            bool bump = sw.F[1] == "bump", ice = sw.F[1] == "ice", once = sw.F.Length > 2 && sw.F[2] == "once";
            for (int s = 0; s < nS; s++)
            {
                if (once && ((s >> gi) & 1) == 1) continue;
                int s2 = s ^ (1 << gi);
                var seen = new HashSet<long>();
                int cy = (shape.Y0 + shape.Y1) / 2, cx = (shape.X0 + shape.X1) / 2;
                foreach (var kv in subs[s].PosRegion)
                {
                    int x = (int)(kv.Key >> 32), y = (int)(uint)kv.Key;
                    // (standing there, or at the top of a jump straight up from there: 60px, less any ceiling)
                    int rise = 0;
                    if (!bump) while (rise < 60 && !subs[s].SolidC.Row(y - 41 - rise, x - 7, x + 6)) rise++;
                    bool hit = bump ? (shape.X1 >= x - 7 && shape.X0 <= x + 6 && y - 40 - shape.Y1 >= 1 && y - 40 - shape.Y1 <= 60)
                                    : shape.Hits(x - 48, y - 44 - rise, x + 48, y - 4);
                    bool shot = false;
                    if (!hit && !bump && cy >= y - 28 - rise - 16 && cy <= y - 28 + 16 && Math.Abs(cx - x) <= 320)
                    {
                        int a = Math.Min(x, cx), b = Math.Max(x, cx);
                        shot = !subs[s].SolidC.Row(cy, a, b);
                    }
                    if (!hit && !shot) continue;
                    int r2 = -1;
                    for (int dy = 0; dy <= 2 && r2 < 0; dy++)
                        foreach (int yy in new[] { y - dy, y + dy })
                        {
                            int q;
                            if (subs[s2].PosRegion.TryGetValue(Shape.Key(x, yy), out q)) { r2 = q; break; }
                        }
                    if (r2 < 0 || !seen.Add(((long)kv.Value << 32) | (uint)r2 ^ (hit ? 0L : 1L << 62))) continue;
                    // (in words: what's hit, how, from where, and what it changes)
                    string what = ice ? "the ice block" : (bump ? "the block" : "the switch");
                    string how = bump ? "jump at " + x + "," + y + " and hit " + what + " at " + sw.X + "," + sw.Y + " from below"
                        : (hit ? "hit " + what + " at " + sw.X + "," + sw.Y + " from " + x + "," + y + (rise > 0 ? " (jumping if need be)" : "")
                               : "shoot " + what + " at " + sw.X + "," + sw.Y + " from " + x + "," + y + (cy < y - 28 - 16 ? " (at the top of a jump)" : ""));
                    how += ice ? (hit ? " with Shotgun Ice or Holy Water" : " with Shotgun Ice") : "";
                    how += ": [" + StateWords(rd, s2) + "]";
                    if (bump) parent.Edges.Add(new Edge { From = kv.Value + off[s], To = r2 + off[s2], L = new Req(), How = how });
                    else foreach (var a in (ice ? (hit ? iceNear : iceFar) : (hit ? attack : ranged))) parent.Edges.Add(new Edge { From = kv.Value + off[s], To = r2 + off[s2], L = a, How = how });
                }
            }
        }
        foreach (var sub in subs) sub.SolidC = sub.SolidO = sub.Plat = sub.Haz = sub.Water = sub.GhostB = null;
    }

    static void AddExit(Room[] rooms, int[] baseOf, List<KeyValuePair<int, Req>>[] adj, int from, Room r, int k, Req l, List<Req> attack)
    {
        var e = r.Exits[k];
        int ti;
        if (!RoomIx.TryGetValue(e.To, out ti) || rooms[ti] == null) return;
        int en;
        if (!rooms[ti].EntryNode.TryGetValue(Shape.Key(e.NX, e.NY), out en)) return;
        int to = baseOf[ti] + en;
        // into a boss's room: its fight comes first (the Randomizer starts it), and needs an attack
        if ((rooms[ti].Data.Boss && rooms[ti] != r) || Via.Contains(r.Data.Name + ">" + e.To))
            foreach (var a in attack) adj[from].Add(new KeyValuePair<int, Req>(to, Req.Max(l, a)));
        else adj[from].Add(new KeyValuePair<int, Req>(to, l));
    }
}
