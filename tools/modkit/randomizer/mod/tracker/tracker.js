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
  // own), fight: the boss fought at each boss's places (Boss Rando), ir: Instrument Randomization. Returns the places
  // got to, the rooms got into, the bosses' places whose fight was got through, and have with the events
  DT3.reach = function (L, part, have0, fight, ir) {
    var have = {}, k;
    for (k in have0) { have[k] = have0[k]; }
    var gN = L.gN, gmult = L.gmult, scoped = L.scoped, gsN = L.gsN, EV = L.EV;
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
    function ok(first, count) {
      if (first < 0) { return true; }
      for (var a = first; a < first + count; a++) {
        var good = true, q1 = L.altFirst[a] + L.altCount[a];
        for (var q = L.altFirst[a]; q < q1; q++) {
          if ((have[L.reqIx[q]] || 0) < L.reqC[q]) { good = false; break; }
        }
        if (good) { return true; }
      }
      return false;
    }
    var seen = new Set(), queue = [], qi = 0, roomIn = new Set(), places = new Set(), parked = new Set(), cross = [];
    var fought = new Set(), done = new Set(), blocked = [], evAdded = false;
    function go(e, gs) {
      var node = e * gsN + gs;
      if (seen.has(node)) { return; }
      seen.add(node); roomIn.add(L.entryRoom[e]); queue.push(node);
    }
    function dest(x, gs) {
      var d = L.exitEnd[x];
      if (d >= 0 && part[d] >= 0) { return L.endBack[part[d]]; }
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
        if (!ok(af, ac) || !ok(bf, bc) || !ok(xf, xc)) { blocked.push(e, gs, q); return; }
        done.add(key);
        if (rs >= 0) { fought.add(rs); }
        if (xs >= 0) { fought.add(xs); }
        // (the Forest Palace's crystals: left with, parked; gone back into, each value they were left with)
        var aIn = L.roomScope[ri], bIn = L.roomScope[tr];
        if (aIn && !bIn) {
          var c = scode(g2);
          if (!parked.has(c)) {
            parked.add(c);
            for (j = 0; j < cross.length; j += 2) { go(cross[j], unpark(cross[j + 1], c)); }
          }
          go(to, park(g2));
        } else if (bIn && !aIn) {
          cross.push(to, g2);
          parked.forEach(function (c2) { go(to, unpark(g2, c2)); });
        } else {
          go(to, g2);
        }
        return;
      }
      if (!ok(af, ac)) { blocked.push(e, gs, q); return; }
      done.add(key);
      if (kind === 2) {
        if (t >= 0) { places.add(t); }
      } else if ((have[EV + t] || 0) < 1) {
        have[EV + t] = 1; evAdded = true;
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
    }
    // (the start is outside the Forest Palace: its crystals parked)
    parked.add(scode(L.startGs));
    go(L.start, park(L.startGs));
    // till nothing new: everything queued gone on from, then the events that now happen, then the rows that were
    // stopped tried again (only an event can let one through now: the items don't change)
    for (;;) {
      while (qi < queue.length) { expand(queue[qi++]); }
      var areas = new Set();
      roomIn.forEach(function (r) { areas.add(L.roomArea[r]); });
      for (var v = 0; v < L.evWays.length; v++) {
        var ways = L.evWays[v];
        if (!ways.length || (have[EV + v] || 0) >= 1) { continue; }
        for (var w = 0; w < ways.length; w += 5) {
          if (ways[w + 4] === skip) { continue; }
          var hit = ways[w] === 1 ? roomIn.has(ways[w + 1]) : areas.has(ways[w + 1]);
          if (hit && ok(ways[w + 2], ways[w + 3])) { have[EV + v] = 1; evAdded = true; break; }
        }
      }
      if (!evAdded) { break; }
      evAdded = false;
      var bl = blocked;
      blocked = [];
      for (var z = 0; z < bl.length; z += 3) { tryRow(bl[z], bl[z + 1], bl[z + 2]); }
    }
    return {places: places, roomIn: roomIn, fought: fought, have: have};
  };

  // ---------------------------------------------------------------- what the state says
  function ch(s, i) { return (s || "").charAt(i); }

  // the progression the player has, as the logic counts it: {number: count} (rndgen.py's PROG: 1-11 the abilities
  // and sets, 12 the Varia Suit, 13 the cursed equipment, 14 the instruments; KB+objectNum a door's key)
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
    for (i = 0; i < D.doors.length; i++) {
      if (ch(S.keys, D.doors[i] - 1) === "1") { have[D.logic.KB + D.doors[i]] = 1; }
    }
    return have;
  };

  // each check's status (TAKEN, IN_LOGIC, OUT_OF_LOGIC) with the state's items and the seed's shuffles. cache (an
  // object, optional): the reach is worked out again only when what it depends on has changed
  DT3.evaluate = function (D, S, cache) {
    var key = [S.own, S.equip, S.gate, S.keys, S.boss, S.er, S.erpart, S.br, S.brfight, S.ir].join("|");
    if (!cache || cache.key !== key) {
      var r = evalReach(D, S);
      cache = cache || {};
      cache.key = key; cache.R = r.R; cache.every = r.every;
    }
    var L = D.logic, R = cache.R, status = [], i;
    for (i = 0; i < D.locs.length; i++) {
      var loc = D.locs[i], ok;
      if (ch(S.got, i) === "1") { status.push(DT3.TAKEN); continue; }
      if (loc.rule === 0) { ok = R.places.has(i); }
      else if (loc.rule === 1) { ok = (R.have[L.EV + loc.ev] || 0) >= 1 || ch(S.gate, loc.gate - 1) >= "8"; }
      else if (loc.rule === 2) { ok = R.places.has(i) && (R.fought.has(loc.slot) || ch(S.boss, loc.slot) === "1"); }
      else { ok = cache.every; }
      status.push(ok ? DT3.IN_LOGIC : DT3.OUT_OF_LOGIC);
    }
    return status;
  };

  function evalReach(D, S) {
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
    var R = DT3.reach(L, part, have, fight, ir);
    // (every progression item: what a check the logic gives no progression to is in logic with)
    var every = true, list = D.everything.concat(ir ? D.everythingIR : []);
    for (i = 0; i < list.length; i++) { if ((have[list[i][0]] || 0) < list[i][1]) { every = false; } }
    return {R: R, every: every};
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
    if (S.er > 0) { out.push("Entrance Rando: " + (["Off", "Gate Swap", "Overworld", "Chaos"][S.er] || S.er)); }
    if (S.br > 0) { out.push("Boss Rando"); }
    if (S.ir > 0) { out.push("Instrument Randomization"); }
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
