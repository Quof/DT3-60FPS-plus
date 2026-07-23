locationCheck(49)

gameScene=instance_create(0,0,oEvCh13MainA)

if global.gameProgress=3030
{
  instance_create(0,0,oCheckpointNotice)
  global.metCheckpoint[0]=room
  global.metCheckpoint[1]=160
  global.metCheckpoint[2]=64
  global.gameProgress=3040
}

if global.gameProgress>=3070
{
  var newExit;
  newExit=instance_create(192,208,oExit)
  newExit.sprite_index=sWarpGateStand
  newExit.bShowArrow=false
  newExit.exitType=0
  newExit.newMapX=144
  newExit.newMapY=320
  newExit.toRoom=rSamus5_Lv4_A
}

if global.gameProgress<=3060
{
  var tempMplay;
  tempMplay=findMusic(816)
  if oPlayer1.x<512
  {
    oPlayer1.life=oPlayer1.maxLife
    global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
  }
  else
  {
    instance_create(0,0,oEvG5EscapeEffects)
    var tTimer;
    tTimer=instance_create(412,8,oScreenTimer)
    tTimer.type=3; tTimer.mainColor=c_white; tTimer.shadowColor=c_black
  }
}
else
{
  var tempMplay;
  tempMplay=findMusic(505)
}
playMusic(tempMplay,0,0)
