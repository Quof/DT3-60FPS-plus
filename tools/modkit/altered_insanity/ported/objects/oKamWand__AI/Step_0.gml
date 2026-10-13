if global.gamePaused=false
{
  if life>0
  {
    if hitStateTime>0
    {
      hitStateTime-=1*gDeltaTime
      //if hitStateTime mod 2=0 {image_alpha=0.5}
      if floor(hitStateTime) mod 2=0 {image_alpha=0.5} //60fps change: floor, so it alternates per 30fps tick
      else {image_alpha=0.75}
      if hitStateTime=0
      {
        image_alpha=1
        bCanDealDamage=true
        bCanTakeDamage=true
      }
    }
    atkTime+=1*gDeltaTime
    if atkSequence=0 //---------- Start sequence ----------
    {
      if atkTime>=45 {image_angle+=10*gDeltaTime}
      if atkTime>=60
      {
        image_blend=c_white
        bCanDealDamage=true
        bCanTakeDamage=true
        atkTime=0; atkSequence+=1
      }
    }
    else if atkSequence=1 //---------- Wander back and forth ----------
    {
      image_angle+=10*gDeltaTime
      //if x>oPlayer1.x and xVel>-3 {xVel-=0.2}
      //else if x<oPlayer1.x and xVel<3 {xVel+=0.2}
      if x>oPlayer1.x and xVel>-3 {xVel-=0.2*gDeltaTime} //60fps change: scaled
      else if x<oPlayer1.x and xVel<3 {xVel+=0.2*gDeltaTime} //60fps change: scaled
      x+=xVel*gDeltaTime
      if atkTime>=60 {atkTime=0; atkSequence+=1}
    }
    else if atkSequence=2 //---------- Attack: Wand projectile toward player ----------
    {
      if atkTime>=1 and atkTime<=30 {image_angle=player_sprite_center()}
      else if atkTime=40
      {
        playSound(global.snd_Magic,0,0.98,1)
        var tAtk,tMax,tAng;
        if oKamek.life=4 or oKamek.life=2 {tMax=1}
        else {tMax=3}
        tAng=image_angle
        if tMax=3 {tAng-=25}
        for(i=0;i<tMax;i+=1)
        {
          tAtk=instance_create(x+lengthdir_x(10,image_angle),y+lengthdir_y(10,image_angle),oKamBounceBall)
          tAtk.sprite_index=sKamekShape; tAtk._direction=tAng; tAtk.atkPower=atkPower; tAtk.projType=1; tAtk.bulletSpeed=5
          if tMax=1 {tAtk.image_index=irandom_range(0,2)}
          else {tAtk.image_index=i}
          tAng+=25
        }
      }
      else if atkTime=50 //End attack
      {
        atkTime=0
        atkNum+=1
        if atkNum=2 {atkNum=0; atkSequence+=1}
        else {atkSequence=1}
      }
    }
    else if atkSequence=3 //---------- Attack: Lightning ----------
    {
      //image_angle+=10
      image_angle+=10*gDeltaTime //60fps change: scaled
      if atkTime>=1 and atkTime<=197 //Hover to sides
      {
        if x<=oKamek.xCenter
        {
          x-=2*gDeltaTime
          if x<=oKamek.xCenter-oKamek.roomSpan {atkTime=198}
        }
        else
        {
          x+=2*gDeltaTime
          if x>=oKamek.xCenter+oKamek.roomSpan {atkTime=198}
        }
      }
      else if atkTime=199
      {
        image_angle=90
        var tAtkLight;
        tAtkLight=instance_create(oPlayer1.x,oKamek.yGround,oCackLightning)
        tAtkLight.type=0; tAtkLight.warnTime=35; tAtkLight.decay=15
        atkTime=200
      }
      //else if atkTime>=201 and atkTime<=220 //Wand sparkles
      else if atkTime>=201 and atkTime<=220 and gDeltaDoTicks //Wand sparkles. 60fps change: once per 30fps tick
      {
        var tEffect;
        tEffect=instance_create(x,y-10,oEffect)
        tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.2+random(0.1); tEffect.newBlend=-1
        tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
      }
      else if atkTime>=221 {atkTime=0; atkSequence+=1}
    }
    else if atkSequence=4 //---------- Attack: Swoop down ----------
    {
      if atkTime=1
      {
        if x<oKamek.xCenter {xVel=2.5} else {xVel=-2.5}
        yVel=5
      }
      else if atkTime>=15 and atkTime<=199 //Swoop
      {
        image_angle+=10*gDeltaTime
        //x+=xVel*gDeltaTime; y+=yVel*gDeltaTime
        //if yVel>-5 {yVel-=0.1}
        //60fps change: moves, then slows its descent / speeds its climb by 0.1 per tick (scrTickAcc, scrTickAccBPre: moves first)
        if gDeltaTime!=1 {yVel=scrTickAcc(yVel,-0.1*(yVel>-5),0)}
        x+=xVel*gDeltaTime; y+=(yVel+scrTickAccBPre(0))*gDeltaTime
        if gDeltaTime==1 {if yVel>-5 {yVel-=0.1}}
        if yVel<0 and y<=oKamek.yGround-158
        {
          y=oKamek.yGround-158
          atkTime=0; atkSequence=1
        }
      }
    }
    else if atkSequence=5 //---------- Float back up (after getting hit) ----------
    {
      //y-=2
      y-=2*gDeltaTime //60fps change: scaled
      if y<=oKamek.yGround-158
      {
        y=oKamek.yGround-158
        atkTime=0; atkSequence=1
      }
    }
  }
  else if life<=0 //Defeat animation
  {
    oKamek.wandState=1
    oKamek.bCanTakeDamage=true
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sWitchFire; tEffect.image_speed=0.25
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
