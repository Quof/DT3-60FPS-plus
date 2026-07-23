locationCheck(70)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backLavaCave
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.6
backFollow.depth=1499999

backFore=instance_create(0,0,oBackSpriteStaticRepeat)
backFore.sprite_index=sCh18AnimFore; backFore.depth=0; backFore.image_speed=0.2; backFore.image_alpha=0.15
backFore.xRepeat=round((room_width+128)/128); backFore.yRepeat=round((room_height+128)/128)

gameScene=instance_create(0,0,oEvCh18MainA)
mapScene=instance_create(0,0,oEvCh18SideA)

instance_create(0,304,oCh18LavaFloor)
instance_create(0,0,oCh18LavaCaveEffects)

if global.bossTrack=1 //Boss Fight: Giant Blarg
{
  var tempMplay;
  tempMplay=findMusic(801)
  var enemyBarrier,boss;
  enemyBarrier=instance_create(144,48,oEnemyBarrier); enemyBarrier.image_yscale=20
  enemyBarrier=instance_create(736,48,oEnemyBarrier); enemyBarrier.image_yscale=20
  oPlayer1.x=448; oPlayer1.y=256
  storeStatus(1)
  boss=instance_create(664,room_height+160,oGiantBlarg)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  if global.gameProgress>=4490 {tempMplay=findMusic(0)}
  else {tempMplay=findMusic(23)}
}
playMusic(tempMplay,0,0)
SS_SetSoundFreq(global.msc_BowserFight,22050)
