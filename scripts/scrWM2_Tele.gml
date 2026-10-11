/*
Warmaster II: a warning drawn where an attack is about to land (oWM2_Tele), so every hit can be read before it comes.
argument0: type -- 0: a column at x1 (x2 = half its width), 1: a band across the arena from y1 to y2,
           2: a line from x1,y1 to x2,y2, 3: a target ring at x1,y1
argument1..argument4: x1, y1, x2, y2
argument5: how long it shows (30fps ticks)
argument6: colour
Returns the warning (its follow/owner settings can be changed after this).
*/
var tT;
tT=instance_create(argument1,argument2,oWM2_Tele)
tT.type=argument0
tT.x1=argument1; tT.y1=argument2; tT.x2=argument3; tT.y2=argument4
tT.dur=argument5
tT.col=argument6
return tT
