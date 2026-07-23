locationCheck(15)

gameScene=instance_create(0,0,oEvCh6MainA)
var sceneBarr;
sceneBarr=instance_create(-16,0,oBossBarrier)
sceneBarr.image_yscale=5.5
sceneBarr=instance_create(608,0,oBossBarrier)
sceneBarr.image_yscale=5.5

if global.gameProgress>=1520 and global.bBossGallery=0
{
  var tHeartContainer;
  tHeartContainer=instance_create(448,232,oHeartContainer)
  tHeartContainer.objectNum=3
  var newExit;
  newExit=instance_create(560,304,oExit)
  newExit.sprite_index=sWarpGateStand; newExit.bShowArrow=false
  newExit.exitType=0; newExit.newMapX=368; newExit.newMapY=288
  newExit.toRoom=rBelmont3_Gate
}
else
{
  if global.bossTrack!=2
  {
    tile_layer_shift(999998,0,64)
    var i;
    for(i=189167;i<189170;i+=1)
    {
      with (i) {instance_destroy()}
    }
  }
}

if global.bossTrack=1 //Boss Fight: Death
{
  var tempMplay;
  tempMplay=findMusic(806)
  oPlayer1.x=224; oPlayer1.y=304
  storeStatus(1)
  boss=instance_create(384,304,oDeath)
  boss.activateBoss=1
}
else if global.bossTrack=2 //Boss Fight: Death (Legion)
{
  var tempMplay;
  tempMplay=findMusic(806)
  oPlayer1.x=112; oPlayer1.y=304
  storeStatus(1)
  boss=instance_create(304,176,oLegion)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(307)
}
playMusic(tempMplay,0,0)
