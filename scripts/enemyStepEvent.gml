/*
This script is called in the enemy step event.
*/
if global.modOvr[enemyStepEvent]>=0 {var __n; __n=0; repeat (argument_count) {global.modArg[__n]=argument[__n]; __n+=1}; return scrModOverride(enemyStepEvent,argument_count)} //mods change (added): a mod's own version of this script runs instead (scrModOverride)
lifePercent=life/maxLife
//stun time
if stunnedTime>0
{
  if stunnedTime=10
    image_blend=baseColor
  stunnedTime-=1*gDeltaTime
}

//damage time
if bTakingDamage=1
{
  damageTime-=1*gDeltaTime
  if damageTime<=0
  {
    if stunnedTime>30
      image_blend=c_purple
    else
      image_blend=baseColor
    bTakingDamage=0
  }
}
