if global.gamePaused=false
{
  if solidIsNearPlayers=1 //Kill player if crushed
  {
    if xVel!=0
    {
      if mstXPrev=x
      {
        deathCheck+=1
        if deathCheck>=3
        {
          for(i=0;i<40;i+=1)
          {
            if xVel>0 {tEffect=instance_create(oPlayer1.x-11,oPlayer1.y-3-random(46),oEffect)}
            else {tEffect=instance_create(oPlayer1.x+11,oPlayer1.y-3-random(46),oEffect)}
            tEffect.sprite_index=sBelmontWepEffect; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
            tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2); tEffect.image_speed=0.25
          }
          oPlayer1.life-=oPlayer1.maxLife
        }
      }
      else {deathCheck=0}
    }
    if yVel!=0
    {
      if mstYPrev=y
      {
        deathCheck+=1
        if deathCheck>=3
        {
          for(i=0;i<40;i+=1)
          {
            if yVel>0 {tEffect=instance_create(oPlayer1.x+random_range(-12,12),oPlayer1.y-3,oEffect)}
            else {tEffect=instance_create(oPlayer1.x+random_range(-12,12),oPlayer1.y-49,oEffect)}
            tEffect.sprite_index=sBelmontWepEffect; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
            tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2); tEffect.image_speed=0.25
          }
          oPlayer1.life-=oPlayer1.maxLife
        }
      }
      else {deathCheck=0}
    }
  }
  else {deathCheck=0}
}
