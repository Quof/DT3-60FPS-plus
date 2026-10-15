//Randomizer: a boss beaten (rndBossEnd; the Abomination: oRndWatcher, its fight the game's own), the player back in a
//room from its fight (the roomStart hook): the AP the story gives after that boss's fight (rndBossAP, by the game's
//own awardBossAP, with its notice), then a level's worth on top: as much as the level the player is at by then takes
//(pAPNext), so a boss is always a level up at least. On Normal only, as the game's own boss AP (none on Easy)
var b,tNext;
b=global.rndBossAPPending
global.rndBossAPPending=-1
if global.difficulty!=2 {exit}
if b>=0 {if global.rndBossAP[b]>0 {awardBossAP(global.rndBossAP[b])}}
if global.pAPLevel<40
{
  tNext=global.pAPNext
  awardAP(tNext)
  if global.optShowPointsEarned=true
  {
    newAward=instance_create(oPlayer1.x,oPlayer1.y-40,oKillAward)
    newAward.pointValue=tNext
  }
}
