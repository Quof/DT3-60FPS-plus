#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Checkpoint script.
*/
if global.gamePaused=false
{
  if checkpointX!=global.newMapX
  {
    instance_create(0,0,oCheckpointNotice)
    writeToPlayerGlobals()
    global.newMapX=checkpointX
    global.newMapY=checkpointY
  }
  instance_destroy()
}
