if global.gamePaused=false
{
  if bSway=1
  {
    moveWave+=(pi/50)*gDeltaTime
    x+=(cos(moveWave)/4)*gDeltaTime
  }

  if myProg=0
  {
    myTime+=1*gDeltaTime
    if myTime>=100
    {
      visible=1
      bCanDealDamage=1; bCanTakeDamage=1
      myTime=0; myProg+=1
    }
  }
  else if myProg=1
  {
    image_xscale+=0.01*gDeltaTime; image_yscale+=0.01*gDeltaTime
    if image_xscale>=0.5
    {
      bCanDealDamage=1
      myProg+=1
    }
  }
  else if myProg=2
  {
    turn_toward_directionUnderscore(point_direction(x+lengthdir_x(44,22+image_angle),y+lengthdir_y(44,22+image_angle),oPlayer1.x,returnPlayerYCenter()),1)
    image_angle=_direction
    fireTime+=1*gDeltaTime

    if fireTime=fireDelay-20 //Attack warning
    {
      var tEffect;
      tEffect=instance_create(x+lengthdir_x(44,22+image_angle),y+lengthdir_y(44,22+image_angle),oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
      tEffect.image_xscale=0.8; tEffect.image_yscale=0.8
    }
    if fireTime>=fireDelay //Fire attack
    {
      if room=rDistortedAbom //spsp ns just in case
      {
        var tNewAttack,tDir;
        tDir=image_angle-30
        for(i=0;i<7;i+=1)
        {
          tNewAtk=instance_create(x+lengthdir_x(44,22+image_angle),y+lengthdir_y(44,22+image_angle),oPassBullet)
          tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=3; tNewAtk.image_speed=0.33
          //tNewAtk.decayTime=-100; tNewAtk.direction=tDir
          tNewAtk.decayTime=-100; tNewAtk._direction=tDir //60fps change: DT3+'s oPassBullet moves by its own _direction
          tDir+=10 //spsp ns
        }
      }
      else
      {
      var tNewAttack,tDir;
      tDir=image_angle-25
      for(i=0;i<3;i+=1)
      {
        tNewAtk=instance_create(x+lengthdir_x(44,22+image_angle),y+lengthdir_y(44,22+image_angle),oPassBullet)
        tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=3; tNewAtk.image_speed=0.33
        tNewAtk.decayTime=-100; tNewAtk._direction=tDir
        tDir+=25
      }
      }
      fireTime=0
    }
  }
  enemyStepEvent()
}
correctSpeedDirection(self)
