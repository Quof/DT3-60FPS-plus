//Evil Boss Gallery: an evil fight in the game's room won (argument0: its type): the results bossRoomTally has just
//worked out (global.bossResultTime, bossResultHit) kept as the evil fight's records, as evgTally does
var k;
k=argument0-1
global.bossResultNewRecord=0
if global.difficulty=2 or global.bNightmareMode=1
{
  if global.evgWins[k]=0 {global.bossResultNewRecord=1}
  global.evgWins[k]+=1
  if global.bossResultHit<global.evgHits[k] {global.evgHits[k]=global.bossResultHit; global.bossResultNewRecord=1}
  if global.bossResultTime<global.evgTime[k] {global.evgTime[k]=global.bossResultTime; global.bossResultNewRecord=1}
}
global.bBossResultShow=1
