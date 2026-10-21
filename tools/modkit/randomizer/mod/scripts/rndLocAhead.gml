//Randomizer: Entrance Rando, an exit about to take the player into the room argument0 (the exitPlayer hook, the
//exit's toRoom as it ends up): when that room is another area's (rndLocData's rndLocOf, the area its creation code
//gives locationCheck), global.location is that area's from now on, before the room's instances are made. Some of them
//pick their look and strength by it in their Create event, which runs before the room's code sets the area, so coming
//in from another area made them that area's (from the Warship, Robot Factory 2's lightning was Warship spike balls).
//The area left is kept (rndLocOld) and put back when the room's locationCheck runs (the mod's locationCheck), so the
//new area's name still shows; the roomStart hook clears it (rndLocPre)
var l;
if global.rndActive=0 or global.rndERMode<=0 {exit}
if !ds_map_exists(global.rndLocOf,argument0) {exit}
l=ds_map_find_value(global.rndLocOf,argument0)
if l=global.location {exit}
if global.rndLocPre=0 {global.rndLocOld=global.location}
global.location=l
global.rndLocPre=1
