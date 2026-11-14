//Logic Test: every room's start (oGame, after the patches and the Randomizer's own roomStart: this mod loads after it).
//The runner is made if it isn't there. In a run, the room is noted, the run's game speed is put back (oGame sets it to
//1 in every room), and a new game the run started skips the Randomizer's options window: its game starts with the
//options as they are (the run's set commands) and the run's seed (rndNewGame, as the window's Start Game does)
var o;
if !instance_exists(oLTRunner) {instance_create(0,0,oLTRunner)}
if global.ltRun=0 {exit}
global.modSpeedMul=global.ltSpeed
global.ltArrived=1
ltOut("room "+room_get_name(room)+" "+string(global.newMapX)+","+string(global.newMapY)+" f"+string(global.ltFrame))
if global.ltNewGame=1 and room=rBeginning
{
  global.ltNewGame=2
  o=scrModFind("oRndOptions","obj")
  if o>=0 {with (o) {instance_destroy()}}
  ltRnd("rndNewGame")
}
