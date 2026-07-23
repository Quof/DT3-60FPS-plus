locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}
global.partySplit=0

gameScene=instance_create(0,0,oEvCh10MainA)
instance_create(0,0,oVaultVisualControl)

if global.gameProgress=2410 {global.gameProgress=2420}

if global.bossTrack=0 and global.gameProgress=2420
{
  tHex=instance_create(448,96,oMisc)
  tHex.sprite_index=sHex_A_Hang; tHex.type=1; tHex.image_speed=0
  tChain=instance_create(tHex.x+10,tHex.y+3,oMisc)
  tChain.sprite_index=sHexChainA; tChain.type=1
  tChain=instance_create(tHex.x-10,tHex.y+3,oMisc)
  tChain.sprite_index=sHexChainA; tChain.type=1; tChain.image_xscale=-1
  tChain=instance_create(tHex.x+5,tHex.y-9,oMisc)
  tChain.sprite_index=sHexChainB; tChain.type=1
  tChain=instance_create(tHex.x-5,tHex.y-9,oMisc)
  tChain.sprite_index=sHexChainB; tChain.type=1; tChain.image_xscale=-1
  var tempMplay;
  tempMplay=findMusic(11)
}

if global.bossTrack=1 //Boss Fight: Hex
{
  var tempMplay,bBarrier,tCamera,enemyBarrier;
  tempMplay=findMusic(807)
  oPlayer1.x=384; oPlayer1.y=304
  tCamera=instance_create(448,0,oGameCamera); tCamera.type=0
  enemyBarrier=instance_create(192,192,oEnemyBarrier); enemyBarrier.image_yscale=7
  enemyBarrier=instance_create(688,192,oEnemyBarrier); enemyBarrier.image_yscale=7
  storeStatus(1)
  boss=instance_create(448,96,oHex_First_Main)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(11)
}
playMusic(tempMplay,0,0)
