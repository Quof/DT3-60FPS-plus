// DT3+ Randomizer trackers: what checks.html and items.html share. The game writes state.js (the mod's rndTrackWrite:
// window.DT3_STATE, what the player has and has taken, the seed's options and shuffles) whenever it changes; the pages
// load it again every second. data.js (rndgen.py's tracker.py) has the checks, the room logic's tables, the items and
// the bosses.
(function () {
  "use strict";
  var DT3 = window.DT3 = {};
  DT3.TAKEN = 2; DT3.IN_LOGIC = 1; DT3.OUT_OF_LOGIC = 0;

  // ---------------------------------------------------------------- the room logic's reach
  // tools/modkit/randomizer/roomlogic/erflat.py's Reach (the mod's rndERReach scripts) over the same tables: from the
  // start, every way the items let through, the carried states (rb, water, the Forest Palace's crystals) taken along,
  // the events happening as their rooms are got into. part: each door end's partner (Entrance Rando; -1 the game's
  // own), fight: the boss fought at each boss's places (Boss Rando), ir: Instrument Randomization, follow: the exits
  // that follow an end lead where it does (a shuffle made with this build's doors; the mod's rndERLayout). The Program
  // Chips: each Access Gate's portal (and the Nightmare Gate's beside it) takes its chip, in its exit's extra; roomChips
  // (a game made before that: the state's chipportals 0) has them as that game was made, going into a gate's rooms from
  // outside it taking its chip and the portals none. Returns the places got to, the rooms got into, the bosses' places
  // whose fight was got through, and have with the events.
  // known (the Check Tracker's Entrance Tracker, or null): {seen, exited}, the state's erseen and erexit (the mod's
  // rndERSeenArrive: a character each, "1" the doors' ends found, and the exits that aren't doors' ends gone through; ""
  // from a build before them). Then the reach goes through the shuffled doors found (either way: both ends of one gone
  // through are found) and every exit that isn't a shuffled door, as the logic does, and stops at the shuffled doors not
  // found yet: it gets to all the logic does that's on this side of them, and the ones it gets to (unexplored) are every
  // door that can be gone through but hasn't been, so while the logic has the game won there's always a check got to or
  // a door unexplored. The exits out of a room it goes through that haven't been gone through are unexplored too (a door
  // the shuffle left where the game has it: its ends found; another exit, a pipe or a drop: erexit's, or the way in it
  // leads to visited when nothing else leads there and it isn't the start), but a map's encounters and the ways back
  // from their fights (data.js's exitNotDoor). It also returns, for each way in got to, the way in and exit it was got
  // to from (parent: e -> [e, x], the start's null).
  // visit (or ""): the state's ervisit, the ways into rooms the player has come in by (the mod's rndVisitArrive, every
  // game): once the start's reach is done, each of those it didn't get to is gone on from too (the player got there,
  // however), with the start's carried states (a parent of null: where its way there starts).
  // warps (or null): the state's Teleporting Stones activated, a string each network (0 the main world, 1-6 a gate:
  // the game's warpMain, warpGate1-6), a character each stone: one got to (its room's rows of kind 4, tracker.py's
  // stone_tables) is warped from to each other one of its network activated, into that one's own way in (the ways in
  // after the logic's own, L.nEntries on: a parent of [e, -2], the way in it was touched from)
  // live (or null): {e, gs}, the way in the player is in their room by (the state's erin) and the carried states they
  // came in with (its carry: the water's level, the red and blue switches', the crystals), as a state: gone on from too
  // once the rest is done, whatever state the start's reach got there in (it can have got there another way). With
  // live.only, from there alone and in that room alone (its own exits into itself gone through, the others not): then
  // unexplored is the doors out of it got to from there that haven't been gone through (known's, as for the rest)
  DT3.reach = function (L, part, have0, fight, ir, follow, roomChips, known, visit, warps, live) {
    var have = {}, k;
    for (k in have0) { have[k] = have0[k]; }
    var gN = L.gN, gmult = L.gmult, scoped = L.scoped, gsN = L.gsN, EV = L.EV;
    var only = !!(live && live.only);
    var skip = ir ? 1 : 2;
    function gval(gs, gi) { return Math.floor(gs / gmult[gi]) % gN[gi]; }
    function gset(gs, gi, v) { return gs + (v - gval(gs, gi)) * gmult[gi]; }
    function park(gs) {
      for (var j = 0; j < scoped.length; j++) { gs = gset(gs, scoped[j], gN[scoped[j]] - 1); }
      return gs;
    }
    function scode(gs) {
      var c = 0, m = 1;
      for (var j = 0; j < scoped.length; j++) { c += gval(gs, scoped[j]) * m; m *= gN[scoped[j]]; }
      return c;
    }
    function unpark(gs, code) {
      for (var j = 0; j < scoped.length; j++) {
        var n = gN[scoped[j]];
        gs = gset(gs, scoped[j], code % n); code = Math.floor(code / n);
      }
      return gs;
    }
    // (chipsHad: the Program Chips counted as had, for a portal's extra in a roomChips game)
    function ok(first, count, chipsHad) {
      if (first < 0) { return true; }
      for (var a = first; a < first + count; a++) {
        var good = true, q1 = L.altFirst[a] + L.altCount[a];
        for (var q = L.altFirst[a]; q < q1; q++) {
          var r = L.reqIx[q];
          if (chipsHad && r > L.chipBase && r <= L.chipBase + 6) { continue; }
          if ((have[r] || 0) < L.reqC[q]) { good = false; break; }
        }
        if (good) { return true; }
      }
      return false;
    }
    var seen = new Set(), queue = [], qi = 0, roomIn = new Set(), places = new Set(), parked = new Set(), cross = [];
    var fought = new Set(), done = new Set(), blocked = [], evAdded = false;
    var parent = new Map(), unexplored = new Set(), entryIn = new Set();
    var nE = L.nEntries || L.entryRoom.length;
    // (known's: whether an exit the reach goes through is a door not gone through yet. Not a map's encounter or the way
    // back from its fight: L.exitNotDoor)
    var arrivals = known ? arrivalsOf(L) : null;
    function notThrough(x) {
      if (L.exitNotDoor && L.exitNotDoor.charAt(x) === "1") { return false; }
      var d = L.exitEnd[x];
      if (d < 0 && follow) { d = L.exitFollow[x]; }
      if (d >= 0) { return known.seen.charAt(d) !== "1"; }
      if (known.exited.charAt(x) === "1") { return false; }
      var ds = L.exitSg[x] >= 0 ? L.exitSdest[x] : [L.exitDest[x]];
      for (var j = 0; j < ds.length; j++) {
        var w = ds[j];
        if (w >= 0 && w !== L.start && arrivals[w] === 1 && (visit || "").charAt(w) === "1") { return false; }
      }
      return true;
    }
    // (from: the way in and exit it's got to by, for known's parent)
    function go(e, gs, from) {
      var node = e * gsN + gs;
      if (seen.has(node)) { return; }
      seen.add(node); entryIn.add(e); roomIn.add(L.entryRoom[e]); queue.push(node);
      if (known && !parent.has(e)) { parent.set(e, from || null); }
    }
    // (-2: a shuffled door not found yet, known's)
    function dest(x, gs) {
      var d = L.exitEnd[x];
      if (d < 0 && follow) { d = L.exitFollow[x]; }
      if (d >= 0 && part[d] >= 0) {
        if (known && known.seen.charAt(d) !== "1") { return -2; }
        return L.endBack[part[d]];
      }
      if (L.exitSg[x] >= 0) { return L.exitSdest[x][gval(gs, L.exitSg[x])]; }
      return L.exitDest[x];
    }
    function tryRow(e, gs, q) {
      var key = q * gsN + gs;
      if (done.has(key)) { return; }
      var ri = L.entryRoom[e], kind = L.rowKind[q], t = L.rowTarget[q], af = L.rowAlts[2 * q], ac = L.rowAlts[2 * q + 1];
      var j, b;
      if (kind === 1) {
        var g2 = gs, leave = L.rowLeave[q], rc = L.roomCarried[ri];
        for (j = 0; j < rc.length; j++) {
          var n = gN[rc[j]];
          g2 = gset(g2, rc[j], leave % n); leave = Math.floor(leave / n);
        }
        var to = dest(t, g2);
        // (a shuffled door not found yet: unexplored, if what gets to it and through it is had)
        if (to === -2) {
          if (ok(af, ac) && ok(L.exitExtra[2 * t], L.exitExtra[2 * t + 1], roomChips)) { done.add(key); unexplored.add(t); }
          else { blocked.push(e, gs, q); }
          return;
        }
        if (to < 0) { return; }
        var tr = L.entryRoom[to], bf = -1, bc = 0, xf, xc, rs = -1, xs = L.exitSlot[t];
        // (a boss's room come into, or its via exit: the fight of the boss fought there)
        if (tr !== ri) {
          rs = L.roomSlot[tr];
          if (rs >= 0) { b = fight[rs]; bf = L.bossReq[2 * b]; bc = L.bossReq[2 * b + 1]; }
          else { bf = L.roomBoss[2 * tr]; bc = L.roomBoss[2 * tr + 1]; }
        }
        if (xs >= 0) { b = fight[xs]; xf = L.bossReq[2 * b]; xc = L.bossReq[2 * b + 1]; }
        else { xf = L.exitExtra[2 * t]; xc = L.exitExtra[2 * t + 1]; }
        // (a roomChips game: into an Access Gate's rooms from outside it, its Program Chip)
        var g = L.roomGate[tr], chipOk = !roomChips || !(g && g !== L.roomGate[ri]) || (have[L.chipBase + g] || 0) >= 1;
        // (known's: an exit out of the room not gone through yet is unexplored too, the reach going on through it; marked
        // once the door itself can be got to and gone through, as a shuffled door is, whether or not the boss fight past
        // it is in logic)
        if (known && tr !== ri && ok(af, ac) && ok(L.exitExtra[2 * t], L.exitExtra[2 * t + 1], roomChips) && chipOk &&
            notThrough(t)) { unexplored.add(t); }
        // (live.only: an exit out of the room is marked, not gone through)
        if (only && tr !== ri) {
          if (ok(af, ac) && ok(L.exitExtra[2 * t], L.exitExtra[2 * t + 1], roomChips) && chipOk) { done.add(key); }
          else { blocked.push(e, gs, q); }
          return;
        }
        if (!ok(af, ac) || !ok(bf, bc) || !ok(xf, xc, roomChips) || !chipOk) { blocked.push(e, gs, q); return; }
        done.add(key);
        if (rs >= 0) { fought.add(rs); }
        if (xs >= 0) { fought.add(xs); }
        enter(to, g2, ri, tr, [e, t]);
        return;
      }
      if (!ok(af, ac)) { blocked.push(e, gs, q); return; }
      done.add(key);
      if (kind === 4) { warpFrom(t, e, gs); return; }
      if (kind === 2) {
        if (t >= 0) { places.add(t); }
      } else if ((have[EV + t] || 0) < 1) {
        have[EV + t] = 1; evAdded = true;
      }
    }
    // (into way in to of room tr from room ri, in state g2. The Forest Palace's crystals: left with, parked; gone back
    // into, each value they were left with)
    function enter(to, g2, ri, tr, from) {
      var aIn = L.roomScope[ri], bIn = L.roomScope[tr], j;
      if (aIn && !bIn) {
        var c = scode(g2);
        if (!parked.has(c)) {
          parked.add(c);
          for (j = 0; j < cross.length; j += 2) { go(cross[j], unpark(cross[j + 1], c)); }
        }
        go(to, park(g2), from);
      } else if (bIn && !aIn) {
        cross.push(to, g2);
        parked.forEach(function (c2) { go(to, unpark(g2, c2), from); });
      } else {
        go(to, g2, from);
      }
    }
    // (a Teleporting Stone touched from way in e: if activated, warped from to each other one of its network
    // activated, its own way in)
    function stoneOn(st) { return !!warps && (warps[st[0]] || "").charAt(st[1] - 1) === "1"; }
    function warpFrom(s, e, gs) {
      var st = L.stones[s];
      if (!stoneOn(st)) { return; }
      for (var k = 0; k < L.stones.length; k++) {
        var s2 = L.stones[k];
        if (k !== s && s2[0] === st[0] && stoneOn(s2)) { enter(s2[3], gs, L.entryRoom[e], s2[2], [e, -2]); }
      }
    }
    function expand(node) {
      var e = Math.floor(node / gsN), gs = node % gsN, ri = L.entryRoom[e], rs = L.roomResets[ri], j;
      for (j = 0; j < rs.length; j += 2) { gs = gset(gs, rs[j], rs[j + 1]); }
      var stc = 0, m = 1, rc = L.roomCarried[ri];
      for (j = 0; j < rc.length; j++) { stc += gval(gs, rc[j]) * m; m *= gN[rc[j]]; }
      var w0 = L.entryWays[2 * e], w1 = w0 + L.entryWays[2 * e + 1];
      for (var wy = w0; wy < w1; wy++) {
        if (L.waySt[wy] !== stc) { continue; }
        var q1 = L.wayRows[2 * wy] + L.wayRows[2 * wy + 1];
        for (var q = L.wayRows[2 * wy]; q < q1; q++) { tryRow(e, gs, q); }
      }
      // (the Teleporting Stones its way in gets to: rows of their own, in the same state as its ways')
      var es = warps && L.entryStone ? L.entryStone[e] : null;
      if (es) { for (j = 0; j < es.length; j += 2) { if (es[j + 1] === stc) { tryRow(e, gs, es[j]); } } }
    }
    // till nothing new: everything queued gone on from, then the events that now happen, then the rows that were
    // stopped tried again (only an event can let one through now: the items don't change)
    function run() {
      for (;;) {
        while (qi < queue.length) { expand(queue[qi++]); }
        var areas = new Set();
        roomIn.forEach(function (r) { areas.add(L.roomArea[r]); });
        for (var v = 0; v < L.evWays.length; v++) {
          var ways = L.evWays[v];
          if (!ways.length || (have[EV + v] || 0) >= 1) { continue; }
          for (var w = 0; w < ways.length; w += 5) {
            if (ways[w + 4] === skip) { continue; }
            // (1 a room got into, 2 an area, 3 that many places got to: a share of the checks, a boss fight's)
            var hit = ways[w] === 1 ? roomIn.has(ways[w + 1]) : ways[w] === 3 ? places.size >= ways[w + 1] : areas.has(ways[w + 1]);
            if (hit && ok(ways[w + 2], ways[w + 3])) { have[EV + v] = 1; evAdded = true; break; }
          }
        }
        if (!evAdded) { break; }
        evAdded = false;
        var bl = blocked;
        blocked = [];
        for (var z = 0; z < bl.length; z += 3) { tryRow(bl[z], bl[z + 1], bl[z + 2]); }
      }
    }
    // (the start is outside the Forest Palace: its crystals parked. Not with live.only, from the player's way in alone)
    parked.add(scode(L.startGs));
    if (!only) {
      go(L.start, park(L.startGs));
      run();
    }
    // (the ways in the player has come in by that the start's reach didn't get to: gone on from too, a Forest Palace
    // one with its crystals as a new game has them)
    if (visit && !only) {
      var more = false, n = Math.min(visit.length, nE);
      for (var e2 = 0; e2 < n; e2++) {
        if (visit.charAt(e2) !== "1" || entryIn.has(e2)) { continue; }
        go(e2, L.roomScope[L.entryRoom[e2]] ? L.startGs : park(L.startGs), null);
        more = true;
      }
      if (more) { run(); }
    }
    // (the way in the player is in their room by, in the states they came in with: live's)
    if (live && live.e >= 0 && live.e < nE) {
      go(live.e, L.roomScope[L.entryRoom[live.e]] ? live.gs : park(live.gs), null);
      run();
    }
    return {places: places, roomIn: roomIn, fought: fought, have: have, parent: parent, unexplored: unexplored,
            known: !!known};
  };

  // (how many ways lead into each way in: the exits that aren't doors' ends, into each of the ways in they lead to, and
  // the doors' ends, into their ways back in; DT3.reach's known)
  function arrivalsOf(L) {
    if (L.arrivals) { return L.arrivals; }
    var n = [], x, j;
    for (j = 0; j < L.entryRoom.length; j++) { n.push(0); }
    for (x = 0; x < L.exitRoom.length; x++) {
      if (L.exitEnd[x] >= 0) { continue; }
      var ds = L.exitSg[x] >= 0 ? L.exitSdest[x] : [L.exitDest[x]];
      for (j = 0; j < ds.length; j++) { if (ds[j] >= 0) { n[ds[j]]++; } }
    }
    for (j = 0; j < L.endBack.length; j++) { if (L.endBack[j] >= 0) { n[L.endBack[j]]++; } }
    L.arrivals = n;
    return n;
  }

  // the Check Tracker's Entrance Tracker, from a known reach (DT3.reach's known): the way into one of some rooms (a
  // screen's, by their names), through the ways in it got to, the shortest of them: {names: the rooms' names in order
  // (where the way starts first, the room got into last; a room's several ways in after each other once; a Teleporting
  // Stone warped to "Warp to [its number] <its room>"), fromStart: whether it starts at the start (else at a way in the
  // player has come in by that the start's reach didn't get to)}, or null when it got into none of them
  DT3.pathToRooms = function (D, R, rooms) {
    var L = D.logic, want = {}, best = null, bestStart = false;
    if (!R.parent) { return null; }
    rooms.forEach(function (r) { want[r] = true; });
    // (a way from the start before any shorter one from a way in the player has come in by: that one isn't in logic
    // from the start, and a screen's other room or way in can have one that is)
    R.parent.forEach(function (p, e) {
      if (!want[L.rooms[L.entryRoom[e]]]) { return; }
      var chain = [], x = e, guard = 0;
      while (x !== null && x !== undefined && guard++ < 10000) {
        chain.push(x);
        var q = R.parent.get(x);
        x = q ? q[0] : null;
      }
      var st = chain[chain.length - 1] === L.start;
      if (!best || (st && !bestStart) || (st === bestStart && chain.length < best.length)) { best = chain; bestStart = st; }
    });
    if (!best) { return null; }
    var names = [], last = null;
    for (var i = best.length - 1; i >= 0; i--) {
      var x = best[i], p = R.parent.get(x), rn = L.rooms[L.entryRoom[x]], nm = (D.roomName && D.roomName[rn]) || rn;
      if (p && p[1] === -2) {
        var num = "?";
        (L.stones || []).forEach(function (s) { if (s[3] === x) { num = s[1]; } });
        names.push("Warp to [" + num + "] " + nm);
      } else if (last !== nm) { names.push(nm); }
      last = nm;
    }
    return {names: names, fromStart: best[best.length - 1] === L.start};
  };

  // the Check Tracker's Entrance Tracker: the ways in got to from the start through the doors found and the exits that
  // aren't shuffled doors (known, as DT3.reach's), whatever getting through each room takes (its ways' needs left out):
  // where the player has got through once, in logic or not, for a way there out of logic. With the Teleporting Stones activated
  // (warps, as DT3.reach's): one its room's way in gets to warped from to each other of its network activated.
  // {parent} as DT3.reach's (DT3.pathToRooms)
  DT3.knownWays = function (L, part, follow, known, warps) {
    var parent = new Map(), queue = [L.start], qi = 0, nE = L.nEntries || L.entryRoom.length;
    parent.set(L.start, null);
    function stoneOn(st) { return !!warps && (warps[st[0]] || "").charAt(st[1] - 1) === "1"; }
    // (where an exit leads: a shuffled door only once found; one whose place depends on a carried state, each)
    function dests(x) {
      var d = L.exitEnd[x];
      if (d < 0 && follow) { d = L.exitFollow[x]; }
      if (d >= 0 && part[d] >= 0) { return known.seen.charAt(d) === "1" ? [L.endBack[part[d]]] : []; }
      if (L.exitSg[x] >= 0) { return L.exitSdest[x]; }
      return [L.exitDest[x]];
    }
    while (qi < queue.length) {
      var e = queue[qi++], w0 = L.entryWays[2 * e], w1 = w0 + L.entryWays[2 * e + 1];
      for (var wy = w0; wy < w1; wy++) {
        var q1 = L.wayRows[2 * wy] + L.wayRows[2 * wy + 1];
        for (var q = L.wayRows[2 * wy]; q < q1; q++) {
          if (L.rowKind[q] !== 1) { continue; }
          var x = L.rowTarget[q], ds = dests(x);
          for (var j = 0; j < ds.length; j++) {
            var to = ds[j];
            if (to < 0 || parent.has(to)) { continue; }
            parent.set(to, [e, x]);
            queue.push(to);
          }
        }
      }
      var es = warps && L.entryStone && e < nE ? L.entryStone[e] : null;
      for (var k = 0; es && k < es.length; k += 2) {
        var st = L.stones[L.rowTarget[es[k]]];
        if (!stoneOn(st)) { continue; }
        for (var s = 0; s < L.stones.length; s++) {
          var s2 = L.stones[s];
          if (s2 === st || s2[0] !== st[0] || !stoneOn(s2) || parent.has(s2[3])) { continue; }
          parent.set(s2[3], [e, -2]);
          queue.push(s2[3]);
        }
      }
    }
    return {parent: parent};
  };

  // and the shuffled doors not found yet that the known reach got to, by room: {room's name: how many}
  DT3.unexploredByRoom = function (D, R) {
    var L = D.logic, out = {};
    if (!R.unexplored) { return out; }
    R.unexplored.forEach(function (x) {
      var rn = L.rooms[L.exitRoom[x]];
      out[rn] = (out[rn] || 0) + 1;
    });
    return out;
  };

  // ---------------------------------------------------------------- what the state says
  function ch(s, i) { return (s || "").charAt(i); }

  // the progression the player has, as the logic counts it: {number: count} (rndgen.py's PROG: 1-11 the abilities
  // and sets, 12 the Varia Suit, 13 the cursed equipment, 14 the instruments; KB+objectNum a door's key; chipBase+gate
  // a Program Chip: a state from before them has them all, as with Chip Randomizer off)
  DT3.haveOf = function (D, S) {
    var have = {}, i, n;
    for (i = 1; i <= 12; i++) {
      n = parseInt(ch(S.own, i), 10);
      if (n > 0) { have[i] = n; }
    }
    n = 0;
    for (i = 10; i <= 12; i++) { if (ch(S.equip, i - 1) === "1") { n++; } }
    if (n) { have[13] = n; }
    n = 0;
    for (i = 0; i < 8; i++) { if (ch(S.gate, i) === "9") { n++; } }
    if (n) { have[14] = n; }
    // (the Air Upgrades got: the underwater rooms need some, requirement 15; the state's au, the game's own string,
    // marked one a pickup)
    n = 0;
    for (i = 0; i < (S.au || "").length; i++) { if (S.au.charAt(i) === "1") { n++; } }
    if (n) { have[15] = n; }
    for (i = 0; i < D.doors.length; i++) {
      if (ch(S.keys, D.doors[i] - 1) === "1") { have[D.logic.KB + D.doors[i]] = 1; }
    }
    var chips = S.chips === undefined ? "111111" : S.chips;
    for (i = 1; i <= 6; i++) { if (ch(chips, i - 1) === "1") { have[D.logic.chipBase + i] = 1; } }
    return have;
  };

  // each check's status (TAKEN, IN_LOGIC, OUT_OF_LOGIC) with the state's items and the seed's shuffles. cache (an
  // object, optional): the reach is worked out again only when what it depends on has changed. ent: the Check
  // Tracker's Entrance Tracker, in a game with Entrance Rando: in logic only what the logic gets to without going
  // through a shuffled door not found yet (DT3.reach's known; cache.R has the way to each check and the doors not found
  // yet that can be gone through, cache.K the ways in got to through the doors found whatever each room takes:
  // DT3.knownWays, cache.H the doors of the player's room got to from the way in they came in by and not gone through:
  // a Set of exits, or null)
  DT3.evaluate = function (D, S, cache, ent) {
    ent = !!ent && S.er > 0;
    var key = [S.own, S.equip, S.gate, S.keys, S.chips, S.chipportals, S.boss, S.er, S.erpart, S.erfollow, S.br, S.brfight,
               S.ir, ent, ent ? S.erseen : "", ent ? S.erexit : "", S.ervisit, (S.warps || []).join("/"), S.erin,
               JSON.stringify(S.carry || null)].join("|");
    if (!cache || cache.key !== key) {
      var r = evalReach(D, S, ent);
      cache = cache || {};
      cache.key = key; cache.R = r.R; cache.every = r.every; cache.K = r.K; cache.H = r.H;
    }
    var L = D.logic, R = cache.R, status = [], i;
    for (i = 0; i < D.locs.length; i++) {
      var loc = D.locs[i], ok;
      if (ch(S.got, i) === "1") { status.push(DT3.TAKEN); continue; }
      // (tower defense's reward, with Skip Tower Defense: there from the start, a place the room logic gets to)
      if (loc.rule === 0 || (loc.td && S.skiptd > 0)) { ok = R.places.has(i); }
      else if (loc.rule === 1) { ok = (R.have[L.EV + loc.ev] || 0) >= 1 || ch(S.gate, loc.gate - 1) >= "8"; }
      else if (loc.rule === 2) { ok = R.places.has(i) && (R.fought.has(loc.slot) || ch(S.boss, loc.slot) === "1"); }
      else { ok = cache.every; }
      status.push(ok ? DT3.IN_LOGIC : DT3.OUT_OF_LOGIC);
    }
    return status;
  };

  function evalReach(D, S, ent) {
    var L = D.logic, i, nEnds = L.endBack.length;
    var have = DT3.haveOf(D, S);
    var part = [], fight = [];
    for (i = 0; i < nEnds; i++) { part.push(-1); }
    if (S.er > 0 && S.erpart && S.erpart.length === nEnds * 4) {
      for (i = 0; i < nEnds; i++) {
        var p = parseInt(S.erpart.substr(i * 4, 4), 10) - 1;
        part[i] = p >= 0 && p < nEnds ? p : -1;
      }
    }
    fight = DT3.fights(D, S);
    var ir = S.ir > 0;
    var known = ent ? {seen: S.erseen || "", exited: S.erexit || ""} : null;
    // (and from the ways in the player has come in by: where they've been is in logic; and the Teleporting Stones they've
    // activated, warped between)
    var warps = S.warps && S.warps.length ? S.warps : null;
    var follow = S.er > 0 && S.erfollow > 0, roomChips = S.chipmode > 0 && S.chipportals !== 1;
    var R = DT3.reach(L, part, have, fight, ir, follow, roomChips, known, S.ervisit || "", warps, liveOf(L, S));
    // (the Entrance Tracker: the doors of the room the player is in that they can get to from the way in they came in
    // by, in the states they came in with, and haven't been through: DT3.reach's live.only, with what the reach has, its
    // events too)
    var H = null, live = liveOf(L, S);
    if (known && live && L.rooms[L.entryRoom[live.e]] === S.room) {
      live.only = true;
      H = DT3.reach(L, part, R.have, fight, ir, follow, roomChips, known, S.ervisit || "", null, live).unexplored;
    }
    // (every progression item: what a check the logic gives no progression to is in logic with)
    var every = true, list = D.everything.concat(ir ? D.everythingIR : []);
    for (i = 0; i < list.length; i++) { if ((have[list[i][0]] || 0) < list[i][1]) { every = false; } }
    var K = known ? DT3.knownWays(L, part, S.er > 0 && S.erfollow > 0, known, warps) : null;
    return {R: R, every: every, K: K, H: H};
  }

  // (DT3.reach's live, from the state's erin and carry: the start's carried states with the ones the player came in
  // with; null without them, from a build before them)
  function liveOf(L, S) {
    if (typeof S.erin !== "number" || S.erin < 0 || !S.carry || !L.gNames) { return null; }
    var gs = L.startGs;
    for (var gi = 0; gi < L.gNames.length; gi++) {
      var v = S.carry[L.gNames[gi]];
      if (v === undefined) { continue; }
      var k = L.gVals[gi].indexOf(String(v));
      if (k >= 0) { gs += (k - Math.floor(gs / L.gmult[gi]) % L.gN[gi]) * L.gmult[gi]; }
    }
    return {e: S.erin, gs: gs};
  }

  // the boss fought at each boss's place (Boss Rando's shuffle; else each its own)
  DT3.fights = function (D, S) {
    var n = D.logic.bossN, fight = [], i;
    for (i = 0; i < n; i++) { fight.push(i); }
    if (S.br > 0 && S.brfight && S.brfight.length === n * 2) {
      for (i = 0; i < n; i++) {
        var b = parseInt(S.brfight.substr(i * 2, 2), 10);
        if (b >= 0 && b < n) { fight[i] = b; }
      }
    }
    return fight;
  };

  // whether each of the Item Tracker's bosses (data.js's bosses) is beaten: a boss, when the place it was fought at
  // is (rndBossDone: the places, the boss fought there by Boss Rando's shuffle); the Abomination, by gateHProg
  DT3.bossesBeaten = function (D, S) {
    var fight = DT3.fights(D, S), beaten = {}, out = [], i;
    for (i = 0; i < fight.length; i++) { if (ch(S.boss, i) === "1") { beaten[fight[i]] = true; } }
    for (i = 0; i < D.bosses.length; i++) {
      var slot = D.bosses[i].slot;
      out.push(slot >= 0 ? !!beaten[slot] : (S.gateh || 0) >= 200);
    }
    return out;
  };

  // ---------------------------------------------------------------- the state file
  // onState(state or null) whenever it changes; null while there's none (the game hasn't written one yet)
  DT3.watch = function (onState) {
    var last = "", el = null, got = false;
    window.DT3_onState = function () {
      var s = window.DT3_STATE, key = JSON.stringify(s);
      got = true;
      if (key !== last) { last = key; onState(s); }
    };
    function poll() {
      if (el && el.parentNode) { el.parentNode.removeChild(el); }
      el = document.createElement("script");
      el.src = "state.js?t=" + Date.now();
      el.onerror = function () { if (!got) { onState(null); } };
      document.head.appendChild(el);
    }
    poll();
    setInterval(poll, 1000);
  };

  // the seed's options, as the new game's options window names them
  DT3.modes = function (S) {
    var out = [];
    if (S.er > 0) { out.push("Entrance Rando: " + (["Off", "Gate Swap", "Area", "Chaos"][S.er] || S.er)); }
    if (S.br > 0) { out.push("Boss Rando"); }
    if (S.ir > 0) { out.push("Instrument Randomization"); }
    if (S.chipmode > 0) { out.push("Chip Randomizer"); }
    if (S.skiptd > 0) { out.push("Skip Tower Defense"); }
    if (S.ap > 0) { out.push("Archipelago"); }
    return out;
  };

  // a problem with the data and the state together, or ""
  DT3.mismatch = function (D, S) {
    if (S.build !== D.build) {
      return "The game's Randomizer build (" + S.build + ") isn't this tracker's (" + D.build + "): open the tracker " +
        "from the mod folder the game runs (Mods\\Randomizer\\tracker).";
    }
    return "";
  };

  // the problem to show now: one is shown for its first WARN_SECONDS, then not again (till another one comes). The
  // pages draw only when the state changes, so redraw is called once its time is up
  var WARN_SECONDS = 10, warnSeen = {};
  DT3.mismatchShown = function (D, S, redraw) {
    var m = S ? DT3.mismatch(D, S) : "";
    if (!m) { return ""; }
    if (warnSeen[m] === undefined) {
      warnSeen[m] = Date.now();
      setTimeout(redraw, WARN_SECONDS * 1000 + 50);
    }
    return Date.now() - warnSeen[m] < WARN_SECONDS * 1000 ? m : "";
  };

  // URL options: ?bg=<colour or transparent>&scale=<n>
  DT3.params = function () {
    var out = {}, q = location.search.replace(/^\?/, "").split("&");
    for (var i = 0; i < q.length; i++) {
      var kv = q[i].split("=");
      if (kv[0]) { out[decodeURIComponent(kv[0])] = decodeURIComponent(kv[1] || ""); }
    }
    return out;
  };
})();
