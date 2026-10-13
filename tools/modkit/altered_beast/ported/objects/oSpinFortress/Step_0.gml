if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    initSeq+=1*gDeltaTime
    if initSeq>=1 and initSeq<=99
    {
      image_alpha+=0.025*gDeltaTime
      for(i=0;i<8;i+=1)
      {
        shieldPart[i].image_alpha+=0.025*gDeltaTime
      }
      shieldDist-=8*gDeltaTime
      if shieldDist<=40
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=2; tEffect.image_yscale=2
        tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        for(i=0;i<8;i+=1)
        {
          if instance_exists(shieldPart[i])
          {
            shieldPart[i].image_alpha=1
            shieldPart[i].bCanTakeDamage=true
            shieldPart[i].bCanDealDamage=true
          }
        }
        image_alpha=1
        bCanDealDamage=true
        bCanTakeDamage=true
        initSeq=100
      }
    }
    else if initSeq>=110
    {
      shieldDir-=6*gDeltaTime
      mDir=player_sprite_center()
      moveTo((runAcc*gDeltaTime)*cos(degtorad(mDir)),-(runAcc*gDeltaTime)*sin(degtorad(mDir)))
    }

    for(i=0;i<8;i+=1)
    {
      if instance_exists(shieldPart[i])
      {
          if (i < 4)
          {
              shieldPart[i].x=x+lengthdir_x(shieldDist,shieldDir+(i*90))
              shieldPart[i].y=y+lengthdir_y(shieldDist,shieldDir+(i*90))
              shieldPart[i].image_angle=shieldDir+(i*90)
          }
          else
          {
              shieldPart[i].x=x+lengthdir_x(shieldDist*2,shieldDir+(i*90+45))
              shieldPart[i].y=y+lengthdir_y(shieldDist*2,shieldDir+(i*90+45))
              shieldPart[i].image_angle=shieldDir+(i*90+45)
          }
      }
    }

    //---------- ATTACK: Shot ----------
    shotTime+=1*gDeltaTime
    if shotTime>=shotDelay
    {
      if shotTime>=shotDelay and shotTime<=shotDelay+29 //spin
      {
        image_angle-=20*gDeltaTime
      }
      else if shotTime=shotDelay+30 //Fire shot
      {
        //(the mod: a shot from each shield part, moving by xVel/yVel, instead of one bullet)
        for(i=0;i<8;i+=1)
        {
          if instance_exists(shieldPart[i])
          {
            tNewAttack=instance_create(shieldPart[i].x,shieldPart[i].y,oMMWC_Shot)
            tNewAttack.atkPower=atkPower; tNewAttack.xVel= (shieldPart[i].x - x) / shieldDist*1.5; tNewAttack.yVel= (shieldPart[i].y - y)*1.5 / shieldDist; tNewAttack.direction=mDir
        image_angle=0
        shotTime=0
          }
        }
        
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1*gDeltaTime
    if deathAnim=1*gDeltaTime
    {
      for(i=0;i<8;i+=1)
      {
        shieldPart[i].bCanDealDamage=false
        shieldPart[i].bCanTakeDamage=false
      }
      playSound(global.snd_BombExplode,0,0.9,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    //if deathAnim mod (4/gDeltaTime)=0
    if deathAnim mod 4=0 //60fps change: deathAnim already counts 30fps ticks (+=gDeltaTime), so dividing by gDeltaTime too made the explosions every 8/16 ticks at 60/120fps instead of every 4
    {
      //if deathAnim mod (8/gDeltaTime)=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)} //60fps change: see above
      tEffect=instance_create(x+random_range(-12,12),y+random_range(-12,12),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.image_xscale=0.4; tEffect.image_yscale=0.4; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    y+=0.5*gDeltaTime
    for(i=0;i<8;i+=1)
    {
      if instance_exists(shieldPart[i])
      {
        shieldPart[i].x+=shdVelX[i]*gDeltaTime
        shieldPart[i].y+=shdVelY[i]*gDeltaTime
        shdVelY[i]+=0.3*gDeltaTime
        shieldPart[i].image_angle+=shdVelTurn[i]*gDeltaTime
      }
    }
    image_alpha-=0.03*gDeltaTime
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
