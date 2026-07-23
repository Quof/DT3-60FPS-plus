locationCheck(10)
secondaryLocCheck(2,12)

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backZeldaForestTrees
backFollow.xMoveScale=0.6
backFollow.yMoveScale=0.9
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh4MainA)
sideChat=instance_create(0,0,oEvCh4SideA)

if global.bossTrack=1 //Boss Fight: Dead Hand
{
  var tempMplay,viewFix,bossBarr;
  tempMplay=findMusic(802)
  viewFix=instance_create(240,176,oMisc)
  viewFix.type=0
  viewFix.sprite_index=sNull
  view_object[0]=viewFix
  bossBarr=instance_create(80,224,oBossBarrier)
  bossBarr=instance_create(384,224,oBossBarrier)
  oPlayer1.x=160; oPlayer1.y=288
  storeStatus(1)
  boss=instance_create(320,288,oDeadHand)
  boss.activateBoss=1
}
else
{
  var tempMplay;
  tempMplay=findMusic(209)
}
playMusic(tempMplay,0,0)
