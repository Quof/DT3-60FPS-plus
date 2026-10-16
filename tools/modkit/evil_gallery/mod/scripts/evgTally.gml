//Evil Boss Gallery: an evil fight won (argument0: the boss's gallery type), as the boss gallery's bossRoomTally does it:
//its time and its hits taken (oPlayer1.tookHitAmount) are each kept if they're the best yet (global.evgTime, evgHits),
//its wins counted, and the results show back in the evil gallery (oEvBossGallery reads the globals set here). Not on
//Assist Mode (difficulty 1)
var k;
k=argument0-1
global.bossResultNewRecord=0
if global.difficulty=2 or global.bNightmareMode=1
{
  if global.evgWins[k]=0 {global.bossResultNewRecord=1}
  global.evgWins[k]+=1
  if oPlayer1.tookHitAmount<global.evgHits[k] {global.evgHits[k]=oPlayer1.tookHitAmount; global.bossResultNewRecord=1}
  if global.levelTimeSecond<global.evgTime[k] {global.evgTime[k]=global.levelTimeSecond; global.bossResultNewRecord=1}
}
global.bossResultTime=global.levelTimeSecond
global.bossResultHit=oPlayer1.tookHitAmount
global.bBossResultShow=1
