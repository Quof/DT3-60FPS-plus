/*
This script is used for objects dealing damage through a dash.
argument0: Damage method
*/
var tHitType;
tHitType=argument0

if bCanDealDamage=true and global.gamePaused=false
{
  if global.debugInvincible=false
  {
    if tHitType=0 //Normal
    {
      with other
      {
        if oPlayer1.bCanTakeHit=true and oPlayer1.bCanTakeDamage=true
        {
          if oPlayer1.dashInvulnerabilityTime>0 {global.recDashInterruptedRed+=1}
          takeDamage(other)
        }
      }
    }
    else if tHitType=1 //1-hit kill
    {
      if oPlayer1.bCanTakeHit=true and oPlayer1.bCanTakeDamage=true
      {
        oPlayer1.bTakingDamage=1
        oPlayer1.damageTime=oPlayer1.flashTime
        oPlayer1.bCanTakeHit=0
        if oPlayer1.dashInvulnerabilityTime>0 {global.recDashInterruptedRed+=1}
        global.recTimesHit+=1
        global.recOneShotted+=1
        oPlayer1.life-=oPlayer1.maxLife
      }
    }
  }
}
