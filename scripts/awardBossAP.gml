/*
This script is used to give AP to the player after a boss fight
argument0: AP awarded
*/
if global.difficulty=2 //Bosses do not award AP if on easy mode
{
  var tAPaward;
  tAPaward=argument0

  awardAP(tAPaward)
  if global.optShowPointsEarned=true
  {
    newAward=instance_create(oPlayer1.x,oPlayer1.y-26,oKillAward)
    newAward.pointValue=tAPaward
  }
}
