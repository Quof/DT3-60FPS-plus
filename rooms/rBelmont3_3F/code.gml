locationCheck(15)

backFollowA=instance_create(32,64,oBackgroundFollow) //360 x center
backFollowA.type=4; backFollowA.backSet=backCV_DraculaRm
backFollowA.image_xscale=1.28; backFollowA.image_yscale=1.28; backFollowA.depth=1499999
backFollowB=instance_create(686,64,oBackgroundFollow)
backFollowB.type=4; backFollowB.backSet=backCV_DraculaRm
backFollowB.image_xscale=-1.28; backFollowB.image_yscale=1.28; backFollowB.depth=1499999

gameScene=instance_create(0,0,oEvCh6MainA)

if global.gameProgress>=1320 and global.bBossGallery=0
{
  instance_create(360,288,oCV_SwordKnight)
}

if global.bossTrack=0 and global.gameProgress=1280
{
  boss=instance_create(360,208,oDracula)
  boss.image_xscale=-1
  var tempMplay;
  tempMplay=findMusic(303)
}

if global.bossTrack=1 //Boss Fight: Dracula
{
  var tempMplay,bBarrier;
  tempMplay=findMusic(804)
  bBarrier=instance_create(16,224,oBossBarrier)
  bBarrier=instance_create(688,224,oBossBarrier)
  oPlayer1.x=256; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(360,208,oDracula)
  boss.activateBoss=1
  boss.image_xscale=-1
}
else
{
  var tempMplay;
  tempMplay=findMusic(303)
}
playMusic(tempMplay,0,0)
