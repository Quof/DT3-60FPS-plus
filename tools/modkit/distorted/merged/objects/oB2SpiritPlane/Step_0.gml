if global.gamePaused=false
{
  makeEnemyActive(0)
  if room=rGame6_CoDR {bActive=true} //spsp ns
  if bActive=true and stunnedTime=0 and life>0
  {
    //movement
    if initDir=false
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=true
    }
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    x+=xVel*gDeltaTime
    //shoot
    bombTime+=1*gDeltaTime
    if bombTime>=bombWait
    {
      playSound(global.snd_BombLaunch,0,0.85,36000)
      var tNewAtk;
      tNewAtk=instance_create(x,y+8,oB2Bomb)
      tNewAtk.atkPower=atkPower; tNewAtk.depth=26
      if image_xscale=1
      {
        tNewAtk._direction=350
        tNewAtk.image_angle=350
      }
      else
      {
        tNewAtk._direction=190
        tNewAtk.image_angle=190
      }
      tNewAtk.bulletSpeed=4
      bombTime=0
    }

    if findTargetX>inactiveDist/1.5 and room!=rGame6_CoDR //spsp ns
    {
      if questType>0 {enemyQuest(questType)}
      instance_destroy()
    }
  }
  else if life<=0
  {
    x+=2*image_xscale*gDeltaTime; y+=2*gDeltaTime
    if image_xscale=1 {image_angle-=2*gDeltaTime}
    else {image_angle+=2*gDeltaTime}
    if oGame.time mod (5/gDeltaTime)=0
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      tEffect=instance_create(x+random_range(-32,32),y+random_range(-24,24),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }

    image_alpha-=0.035*gDeltaTime
    if image_alpha<0
    {
      playSound(global.snd_HardHit1,0,0.98,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sShipExplosion; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
  enemyStepEvent()
}
