/*
Checkpoint script.
*/
if global.gamePaused=false
{
  if checkpointX!=global.newMapX
  {
    if room!=rReckoningOne and room!=rHPF_P {instance_create(0,0,oCheckpointNotice)} //spsp DDLC/ns
    writeToPlayerGlobals()
    global.newMapX=checkpointX
    global.newMapY=checkpointY
  }
  instance_destroy()
}
