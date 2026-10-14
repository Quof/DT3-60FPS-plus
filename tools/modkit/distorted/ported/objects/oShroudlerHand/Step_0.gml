if global.gamePaused=false
{
  //---------- "Movement" ----------
  x=oREX.x+88*image_xscale
  y=oREX.y-4

  /*if oREX.bossProgress>=6
  {
    for(i=0;i<2;i+=1)
    {
      resType[i*3]=2
    }
  }*/
  //bossProg=oREX.bossProgress

  //handLaserTime+=1
  handLaserTime+=1*gDeltaTime //60fps change: per frame
  if handLaserTime>=handLaserDelay-15
  {
    if myType=0
    {
      if instance_exists(oREX)
      {
        if image_xscale=1 {oREX.handA=1}
        else if image_xscale=-1 {oREX.handB=1}
      }
      if handLaserTime=handLaserDelay-15
      {
        var tEffect;
        tEffect=instance_create(x+12*image_xscale,y-32,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=2; tEffect.image_yscale=2
      }
      if handLaserTime=handLaserDelay+10 //Create laser
      {
        handLaserL=instance_create(x+12*image_xscale,y-32,oFNHandLaser)
        handLaserL.atkPower=10; handLaserL.image_angle=270; handLaserL.image_yscale=4
      }
      else if handLaserTime>handLaserDelay+10 and handLaserTime<handLaserDelay+80//Update lasers (Forever)
      {
        //handLaserTime=200
        handLaserL.x=x+12*image_xscale; handLaserL.y=y-32

        var tEffect,i;
        //for(i=0;i<2;i+=1)
        for(i=0;i<2*(gDeltaDoTicks>0);i+=1) //60fps change: 2 sparks per 30fps tick, not per frame
        {
          tEffect=instance_create(x+12*image_xscale+(-8+random(16)),y-32+(-8+random(16)),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sBelmontWepEffect; tEffect.image_speed=0.33
          tEffect.direction=random(360); tEffect.speed=random(0.5)+0.5
          tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.035
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
      }
      else if handLaserTime>=handLaserDelay+80
      {
        if instance_exists(handLaserL) {with handLaserL {instance_destroy()}}
        handLaserTime=0
      }
    }
    else if myType=1
    {
      if instance_exists(oREX)
      {
        if image_xscale=1 {oREX.handC=1}
        else if image_xscale=-1 {oREX.handD=1}
      }
      if handLaserTime=handLaserDelay+45 //Check updates
      {
        var tEffect;
        tEffect=instance_create(x+4*image_xscale,y+36,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.depth=0
      }
      if handLaserTime=handLaserDelay+70 //Create laser
      {
        handLaserL=instance_create(x+4*image_xscale,y+36,oFNHandLaser)
        handLaserL.atkPower=10; handLaserL.image_angle=270-50*image_xscale; handLaserL.image_yscale=4
      }
      else if handLaserTime>handLaserDelay+70 and handLaserTime<handLaserDelay+85 //Update lasers (Forever)
      {
        //handLaserTime=200
        handLaserL.x=x+4*image_xscale; handLaserL.y=y+36

        var tEffect,i;
        //for(i=0;i<2;i+=1)
        for(i=0;i<2*(gDeltaDoTicks>0);i+=1) //60fps change: 2 sparks per 30fps tick, not per frame
        {
          tEffect=instance_create(x+4*image_xscale+(-8+random(16)),y+36+(-8+random(16)),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sBelmontWepEffect; tEffect.image_speed=0.33
          tEffect.direction=random(360); tEffect.speed=random(0.5)+0.5
          tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.035
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
      }
      else if handLaserTime>=handLaserDelay+85
      {
        if instance_exists(handLaserL) {with handLaserL {instance_destroy()}}
        handLaserTime=-45
      }
    }
  }

  enemyStepEvent()
  if life<=0
  {
    if myType=0 and handLaserTime>=handLaserDelay+10
    {
        with handLaserL {instance_destroy()}
    }
    else if myType=1 and handLaserTime>=handLaserDelay+70
    {
        with handLaserL {instance_destroy()}
    }
    if myType=0
    {
        if image_xscale=1 {oREX.handA=RESPAWN}
        else if image_xscale=-1 {oREX.handB=RESPAWN}
    }
    else if myType=1
    {
        if image_xscale=1 {oREX.handC=RESPAWN_diag}
        else if image_xscale=-1 {oREX.handD=RESPAWN_diag}
    }
    instance_destroy()
  }
}

/*
    if oREX.bossProgress>=0 and oREX.bossProgress<=3
    {
      if life<=4400
      {
        life=maxLife
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        myBarrier=0
      }
    }
    else if oREX.bossProgress=4
    {
      if life<=4600
      {
        life=maxLife
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        extraBullet=0
        bArcExtraBullet=0
        tinyArcDown=100
        myBarrier=0
      }
    }
    else if oREX.bossProgress=11
    {
      if life<=4400
      {
        life=maxLife
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        myBarrier=0
      }
    }
*/
