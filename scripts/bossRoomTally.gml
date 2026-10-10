//This saves the results of the boss room
var tBossIndex;
tBossIndex=argument0

if global.difficulty=2 or global.bNightmareMode=1
{
  //normalized gallery change (added): a fight with a normalized build (gallery lever on) is scored by the hits taken
  //(oPlayer1.tookHitAmount: counted from the start of the fight, Retry starts it over); fewest hits is the record. Its
  //best time is kept too, the same way as the normal one
  if global.normActive=1
  {
    if global.bossGalleryHitsN[tBossIndex]>oPlayer1.tookHitAmount
    {
      global.bossGalleryHitsN[tBossIndex]=oPlayer1.tookHitAmount
      global.bossResultNewRecord=1
    }
    if global.bossGalleryTimeN[tBossIndex]>global.levelTimeSecond
    {
      global.bossGalleryTimeN[tBossIndex]=global.levelTimeSecond
      global.bossResultNewRecord=1
    }
    //dark omen change (added): a win without a hit with the New Dark Omen on (scrOmenState) earns the platinum medal
    //(oBossGalleryDoor and oBossBoard show it). Only the new one: not with the dipswitch off
    if global.newDarkOmen=1 and global.omenActive=1 and oPlayer1.tookHitAmount=0 and global.bossGalleryPlatN[tBossIndex]=0
    {
      global.bossGalleryPlatN[tBossIndex]=1
      global.bossResultNewRecord=1
    }
  }
  //if global.bossGalleryTime[tBossIndex]>global.levelTimeSecond
  else if global.bossGalleryTime[tBossIndex]>global.levelTimeSecond //normalized gallery change
  {
    global.bossGalleryTime[tBossIndex]=global.levelTimeSecond
    global.bossResultNewRecord=1
  }
}

global.bossResultTime=global.levelTimeSecond
global.bossResultHit=oPlayer1.tookHitAmount

global.bBossResultShow=1
