locationCheck(99)
background_alpha[1]=0
background_alpha[2]=0

if global.gameProgress>=5260 and global.bBossGallery=0
{
  abilSetRemove(1)
  global.hasShoes[0]=2; global.hasShoes[1]=2
  global.canCharSwap=2; global.canDoubleJump=2
  global.hasAbilToken[0]=2
}
else {abilSetRemove(0)}
global.partySplit=1

gameScene=instance_create(0,0,oEvCh20MainA)
mapScene=instance_create(0,0,oEvCh20SideA)

var tempMplay;
if global.bossTrack=0 {tempMplay=findMusic(1001)}
else if global.bossTrack=1 //Boss Fight: Hex Final
{
  with oMisc {instance_destroy()}
  var tCamera,enemyBarrier,boss;
  tCamera=instance_create(448,304,oGameCamera); tCamera.type=0
  oPlayer1.x=320; oPlayer1.y=288
  oPlayerIdle.x=272; oPlayerIdle.y=288
  view_xview[0]=208
  enemyBarrier=instance_create(192,192,oEnemyBarrier); enemyBarrier.image_yscale=4
  enemyBarrier=instance_create(688,176,oEnemyBarrier); enemyBarrier.image_yscale=4
  if global.gateHProg=200
  {
    tempMplay=findMusic(830)
    boss=instance_create(448,160,oHex_Final_Main)
  }
  else
  {
    tempMplay=findMusic(807)
    boss=instance_create(448,160,oHex_Final_BadEnd)
  }
  boss.activateBoss=1
  storeStatus(1)
}
playMusic(tempMplay,0,0)
