/*
This script is called in the enemy step event.
*/
lifePercent=life/maxLife
//stun time
if stunnedTime>0
{
  if stunnedTime=10
    image_blend=baseColor
  stunnedTime-=1
}

//damage time
if bTakingDamage=1
{
  damageTime-=1
  if damageTime<=0
  {
    if stunnedTime>30
      image_blend=c_purple
    else
      image_blend=baseColor
    bTakingDamage=0
  }
}
