/*
This script is used for an object dealing insta-kills.
*/
if oPlayer1.bCanTakeHit=true and oPlayer1.bCanTakeDamage=true and oPlayer1.dashInvulnerabilityTime=0
{
  if global.debugInvincible=false
  {
    oPlayer1.bTakingDamage=1
    oPlayer1.damageTime=oPlayer1.flashTime
    oPlayer1.bCanTakeHit=0
    global.recTimesHit+=1
    global.recOneShotted+=1
    oPlayer1.life-=oPlayer1.maxLife
  }
}
