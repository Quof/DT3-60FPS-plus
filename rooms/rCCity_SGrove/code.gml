locationCheck(41)
global.canCharSwap=2
global.challengeRoom=7

backFollow=instance_create(0,0,oBackgroundFollow)
backFollow.type=2
backFollow.backSet=backMeadeland1
backFollow.xMoveScale=0.6
backFollow.yMoveScale=1
backFollow.depth=1499999

gameScene=instance_create(0,0,oEvCh11MainA)

if global.bNightmareMode=1 and global.bBossGallery=0
{
  trialCheck=string_char_at(global.trialMasterQuest,7)
  if trialCheck="1"
  {
    var tHeartContainer;
    tHeartContainer=instance_create(352,136,oHeartContainer)
    tHeartContainer.objectNum=7
  }
}

var tempMplay;
tempMplay=findMusic(2)
playMusic(tempMplay,0,0)
