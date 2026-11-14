// Phase F.9 (trackerplay.py writes seeds.js): each seed played through with only what the Check Tracker shows. From
// the start, again and again: every check in logic (DT3.reach with the Entrance Tracker's known doors, as
// DT3.evaluate's rules have it) that holds a progression item taken; with none, an unexplored door gone through, at
// random (a shuffled door: both its ends found; another exit: gone through). It must get every progression item without
// being left with nothing in logic and nothing unexplored. window.TP_RESULT has the results when it's done.
(function () {
  "use strict";
  function rng(seed) {
    var s = seed >>> 0;
    return function () { s = (s * 1664525 + 1013904223) >>> 0; return s / 4294967296; };
  }
  function setChar(s, i, c) { return s.substr(0, i) + c + s.substr(i + 1); }
  function play(D, sd, runSeed) {
    var L = D.logic, nEnds = L.endBack.length, nX = L.exitRoom.length, i;
    var fight = sd.fight || null;
    if (!fight) { fight = []; for (i = 0; i < L.bossN; i++) { fight.push(i); } }
    var have = {}, k;
    for (k in sd.start) { have[k] = sd.start[k]; }
    var at = {};
    sd.placed.forEach(function (p) { at[p[0]] = p[1]; });
    var total = sd.placed.length, got = new Set(), doors = 0, steps = 0;
    var known = {seen: new Array(nEnds + 1).join("0"), exited: new Array(nX + 1).join("0"), boss: new Array(L.bossN + 1).join("0")};
    var visit = new Array(L.entryRoom.length + 1).join("0");
    var r = rng(runSeed), lastDoor = -1;
    for (;;) {
      if (++steps > 5000) { return {ok: false, why: "too many steps", got: got.size, total: total, doors: doors}; }
      var R = DT3.reach(L, sd.part, have, fight, sd.ir, false, false, known, visit, null, null);
      R.fought.forEach(function (s) { known.boss = setChar(known.boss, s, "1"); });
      var take = [];
      for (var loc in at) {
        var li = +loc;
        if (got.has(li)) { continue; }
        var d = D.locs[li], ok;
        if (d.rule === 0 || (d.td && sd.td)) { ok = R.places.has(li); }
        else if (d.rule === 1) { ok = (R.have[L.EV + d.ev] || 0) >= 1; }
        else if (d.rule === 2) { ok = R.places.has(li) && R.fought.has(d.slot); }
        else { ok = false; }
        if (ok) { take.push(li); }
      }
      if (take.length) {
        lastDoor = -1;
        take.forEach(function (li) { got.add(li); var p = at[li]; if (p > 0) { have[p] = (have[p] || 0) + 1; } });
        continue;
      }
      if (got.size === total) { return {ok: true, got: got.size, total: total, doors: doors}; }
      var un = Array.from(R.unexplored);
      if (!un.length) {
        return {ok: false, why: "nothing in logic, nothing unexplored", got: got.size, total: total, doors: doors,
                left: Object.keys(at).filter(function (l) { return !got.has(+l); }).slice(0, 8).map(function (l) { return D.locs[+l].id + " (" + D.locs[+l].room + ")"; })};
      }
      // (a door gone through last time still unexplored: the tracker would show it for ever)
      if (lastDoor >= 0 && R.unexplored.has(lastDoor)) {
        return {ok: false, why: "exit " + lastDoor + " (" + L.rooms[L.exitRoom[lastDoor]] + ") still unexplored once gone through", got: got.size, total: total, doors: doors};
      }
      var x = un[Math.floor(r() * un.length)], e = L.exitEnd[x];
      lastDoor = x;
      doors++;
      if (e >= 0 && sd.part[e] >= 0) {
        known.seen = setChar(setChar(known.seen, e, "1"), sd.part[e], "1");
        visit = setChar(visit, L.endBack[sd.part[e]], "1");
      } else if (e >= 0) {
        // (a door the shuffle left where the game has it: both its ends found, as the game's rndERSeenArrive has them)
        known.seen = setChar(known.seen, e, "1");
        var y = L.exitTwin ? L.exitTwin[x] : -1;
        if (y >= 0 && L.exitEnd[y] >= 0) { known.seen = setChar(known.seen, L.exitEnd[y], "1"); }
        known.exited = setChar(known.exited, x, "1");
        if (L.exitDest[x] >= 0) { visit = setChar(visit, L.exitDest[x], "1"); }
      } else {
        known.exited = setChar(known.exited, x, "1");
        var ds = L.exitSg[x] >= 0 ? L.exitSdest[x] : [L.exitDest[x]];
        ds.forEach(function (w) { if (w >= 0) { visit = setChar(visit, w, "1"); } });
      }
    }
  }
  // (runs: each seed played that many times; from, to: the seeds' range, all by default)
  window.TP_RUN = function (runs, from, to) {
    var D = window.DT3_DATA, out = {seeds: 0, ok: 0, bad: [], doors: 0, byLabel: {}};
    window.TP_SEEDS.forEach(function (sd, si) {
      if (si < (from || 0) || si >= (to === undefined ? window.TP_SEEDS.length : to)) { return; }
      for (var t = 0; t < (runs || 1); t++) {
        var res = play(D, sd, 1000 * si + t + 1);
        out.seeds++; out.doors += res.doors;
        var b = out.byLabel[sd.label] = out.byLabel[sd.label] || {runs: 0, ok: 0};
        b.runs++;
        if (res.ok) { out.ok++; b.ok++; }
        else { out.bad.push({label: sd.label, seed: sd.seed, run: t, why: res.why, got: res.got, total: res.total, left: res.left}); }
      }
    });
    window.TP_RESULT = out;
    return out;
  };
})();
