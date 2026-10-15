//Randomizer: an exit (this instance: oExit, oAccessGate, oDistortionGate, oMMBossDoor, oMetEleExit, oZeldaMapExit,
//oGameMapExit) sent where the entrance randomizer's shuffle has it lead, if it's one of its doors' ends (rndERMapBuild:
//found by its room and where it's placed). The roomStart hook does it to every exit as a room starts, and the exitPlayer
//hook again as the player goes through an oExit (one a room's code makes later)
var k;
if global.rndERMode=0 {exit}
k=string(room)+":"+string(round(x))+","+string(round(y))
if !ds_map_exists(global.rndERMapR,k) {exit}
toRoom=ds_map_find_value(global.rndERMapR,k)
newMapX=ds_map_find_value(global.rndERMapX,k)
newMapY=ds_map_find_value(global.rndERMapY,k)
//(a Zelda II map exit's other ways in, by the way the icon walks onto it: all the new one)
if variable_local_exists("newMapXUp") {newMapXUp=newMapX; newMapYUp=newMapY}
if variable_local_exists("newMapXDown") {newMapXDown=newMapX; newMapYDown=newMapY}
if variable_local_exists("newMapXLeft") {newMapXLeft=newMapX; newMapYLeft=newMapY}
if variable_local_exists("newMapXRight") {newMapXRight=newMapX; newMapYRight=newMapY}
