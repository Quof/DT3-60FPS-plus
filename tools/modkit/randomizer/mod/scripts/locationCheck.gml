//Randomizer: the mod's version of the game's locationCheck (a room's creation code giving its area: the area's name
//shows when it's a new one), which runs in its place (one of the scripts a mod can replace: Mods\README.txt). When an
//exit put the new room's area in global.location ahead of the room (rndLocAhead), the area left is put back first, so
//the game's own script still sees the change and shows the name. The game's script does the rest: this version stands
//aside for it (global.modOvr; "locationCheck (" with the space is the game's script, scrModFixCode), and what it
//returns (the area's name: the title screen's save slots show it) is this one's
var tOvr,tName;
if variable_global_exists("rndLocPre")
{
  if global.rndLocPre=1 {global.location=global.rndLocOld; global.rndLocPre=0}
}
tOvr=global.modOvr[locationCheck]
global.modOvr[locationCheck]=-1
tName=locationCheck (argument0)
global.modOvr[locationCheck]=tOvr
return tName
