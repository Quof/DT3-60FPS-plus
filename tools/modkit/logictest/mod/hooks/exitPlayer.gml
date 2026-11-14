//Logic Test: the player going through an exit (oExit, argument0 its exitType; after the Randomizer's exitPlayer, so
//toRoom, newMapX and newMapY are where it really leads): noted in a run
var s;
if global.ltRun=1
{
  s="?"
  if room_exists(toRoom) {s=room_get_name(toRoom)}
  ltOut("exit "+room_get_name(room)+" "+string(x)+","+string(y)+" -> "+s+" "+string(newMapX)+","+string(newMapY)+" f"+string(global.ltFrame))
}
return 0
