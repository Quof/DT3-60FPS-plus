if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    //if tauntPlayer>0 {tauntPlayer-=1}
    if tauntPlayer>0 {tauntPlayer-=1*gDeltaTime} //60fps change: scaled (taunt cooldown)
    if initDir=false
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1

      if xVel>0
        image_xscale=1
      else
        image_xscale=-1
      initDir=true
    }
    bobTime+=1*gDeltaTime
    //if bobTime>=1 and bobTime<=20
    if bobTime>0 and bobTime<=20 //60fps change: covers every frame of ticks 1-20 (the bob was 0.35px short and paused for a frame)
      y+=0.7*gDeltaTime
    //else if bobTime>=21 and bobTime<=40
    else if bobTime>20 and bobTime<=40 //60fps change: see above
    {
      y-=0.7*gDeltaTime
      if bobTime=40
        bobTime=0
    }
    x+=xVel*gDeltaTime
    if findTargetX>inactiveDist/2
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
  }
  else if life<=0
  {
    deathAnim+=1*gDeltaTime
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-6,6),y+random_range(-12,12),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04*gDeltaTime
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
