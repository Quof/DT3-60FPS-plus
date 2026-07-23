//This saves the results of the boss room
var tBossIndex;
tBossIndex=argument0

if global.difficulty=2 or global.bNightmareMode=1
{
  if global.bossGalleryTime[tBossIndex]>global.levelTimeSecond
  {
    global.bossGalleryTime[tBossIndex]=global.levelTimeSecond
    global.bossResultNewRecord=1
  }
}

global.bossResultTime=global.levelTimeSecond
global.bossResultHit=oPlayer1.tookHitAmount

global.bBossResultShow=1
