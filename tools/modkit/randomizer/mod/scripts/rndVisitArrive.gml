//Randomizer: the way into this room the player has come in by (the one at where they're put, global.newMapX/Y: the
//room logic's ways in, rndVisitData's rndVisitOf) is visited from now on (rndERVisit, a character each), in every
//game: the Check Tracker counts what the ways in they've used get to as in logic (they've got there, however), and its
//Entrance Tracker goes only into those. The roomStart hook; the save keeps them (Entrance Rando's rndERSeenArrive also
//finds the doors gone through)
var k,e;
k=room_get_name(room)+":"+string(round(global.newMapX))+","+string(round(global.newMapY))
if !ds_map_exists(global.rndVisitOf,k) {exit}
e=ds_map_find_value(global.rndVisitOf,k)
if string_length(global.rndERVisit)<global.rndVisitN {global.rndERVisit+=string_repeat("0",global.rndVisitN-string_length(global.rndERVisit))}
if string_char_at(global.rndERVisit,e+1)!="1" {global.rndERVisit=rndSetChar(global.rndERVisit,e+1,"1"); global.rndTrackDirty=1}
