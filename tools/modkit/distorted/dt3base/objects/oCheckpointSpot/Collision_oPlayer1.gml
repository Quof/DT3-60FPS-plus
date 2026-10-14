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
