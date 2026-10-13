/*
mods change (added): how a 30fps mod's event runs (scrModRun's mode): every-frame events (step, collision, held keys and
buttons, outside the room/view, trigger) only on 30fps ticks; draw events every frame; the rest (create, destroy,
alarms, presses, user events, room start...) whenever they happen. All but draw with gDeltaTime at 1.
argument0: event type
argument1: event number
*/
var t,n;
t=argument0; n=argument1
if t=ev_step or t=ev_collision or t=ev_keyboard or t=ev_trigger {return 2}
if t=ev_draw {return 3}
if t=ev_mouse {if n<=3 or (n>=50 and n<=52) {return 2}}
if t=ev_other {if n<=1 or (n>=40 and n<=57) {return 2}}
return 1
