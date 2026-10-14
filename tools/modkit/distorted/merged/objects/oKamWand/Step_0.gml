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
        atkTime=0; atkSequence+=100
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
        if yVel<0 and y<=oKamek.yGround-wandHeight
        {
          y=oKamek.yGround-wandHeight
          atkTime=0; atkSequence=1
        }
      }
    }
    else if atkSequence=5 //---------- Float back up (after getting hit) ----------
    {
      //y-=2
      y-=2*gDeltaTime //60fps change: scaled
      if y<=oKamek.yGround-wandHeight  //spsp
      {
        y=oKamek.yGround-wandHeight   //spsp
        atkTime=0; atkSequence=100
        atkList[0]=true
        if life=maxLife-1      //3xM
        {
            atkList[2]=true //3x
            atkList[3]=false
            atkList[5]=true
            atkList[6]=false
            Mmax=3
        }
        else if life=maxLife-2 //3xM L
        {
            atkList[2]=true //3x
            atkList[3]=true
            atkList[5]=false
            atkList[6]=true
            Mmax=3
        }
        else if life=maxLife-3 //2xM Ll
        {
            atkList[2]=true //2x
            atkList[3]=true
            atkList[5]=false
            atkList[6]=true
            Mmax=2
            Ldelay=60
        }
        else if life=maxLife-4 //LL
        {
            atkList[2]=false
            atkList[3]=true //fast here
            atkList[5]=true
            atkList[6]=false
            Ldelay=30
        }
        else if life=maxLife-5 //5xM
        {
            atkList[2]=true //5x
            atkList[3]=false
            atkList[5]=true
            atkList[6]=false
            Ldelay=90
            Mmax=5
            swooptime=420
        }
        else if life=maxLife-6 //4xM L
        {
            atkList[2]=true //4x
            atkList[3]=true
            atkList[4]=true //fire
            atkList[5]=true
            atkList[6]=false
            Mmax=4
        }
      }
    }
    else
    {   
        //spsp ns
        if atkList[0]=true and atkTime>=swooptime //"swoop"
        {
            if atkTime=swooptime
            {
                fanTime=fanMax //used in draw event
                //MM charge effect
                //velocities set to zero
            }
            //angle, visual indicators, 3s total until attack?
            //if fanTime>0 {fanTime-=1; image_angle=player_sprite_center()}
            if fanTime>0 {fanTime-=1*gDeltaTime; image_angle=player_sprite_center()} //60fps change: per frame
            else if fanTime=0
            {
                //attack velocities
                xVel=swoopSpd*cos(2*pi*image_angle/360)
                yVel=-swoopSpd*sin(2*pi*image_angle/360)
                Bleft=Wleft+abs(xVel)*16/swoopSpd
                Bright=Wright-abs(xVel)*16/swoopSpd
                Bground=oKamek.yGround-abs(yVel)*16/swoopSpd
                fanTime=-1
            }
            else if fanTime=-1
            {
                //boundaries: left: 128, right: 416, top: 64, bottom: 288
                if (x>Bright and xVel>0) or (x<Bleft and xVel<0) {xVel=-xVel; playSound(global.snd_RupeeBounce,0,0.95,10000)}
                if y>Bground {y=Bground; xVel=0; yVel=-2; playSound(global.snd_RupeeBounce,0,0.95,10000)}
                //x+=xVel
                //y+=yVel
                x+=xVel*gDeltaTime //60fps change: per frame
                y+=yVel*gDeltaTime //60fps change: per frame
                if y<=oKamek.yGround-wandHeight {y=oKamek.yGround-wandHeight; xVel=0; yVel=-2; fanTime=-2}
                if gDeltaDoTicks //60fps change (added): one trail particle per 30fps tick
                {
                var tEffect;
                tEffect=instance_create(x,y-10,oEffect)
                tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.2+random(0.1); tEffect.newBlend=-1
                tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
                } //60fps change (added)
            }
            else if fanTime=-2
            {
                //y+=yVel
                y+=yVel*gDeltaTime //60fps change: per frame
                if y<=oKamek.yGround-wandHeight {y=oKamek.yGround-wandHeight; atkTime=0; Ltime=0; Mtime=0; Btime=0; fanTime=0}
            }
        }
        if atkList[1]=true //balls
        {
            //Btime+=1
            Btime+=1*gDeltaTime //60fps change: per frame
            if Btime>=Bdelay
            {
                var tEffect,tAtk;
                tEffect=instance_create(x,y,oEffect)
                tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
                tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
                for(i=0;i<maxBalls;i+=1)
                {
                    tAtk=instance_create(x,y,oKamBounceBall)
                    tAtk.atkPower=atkPower; tAtk.type=i; tAtk.myDir=i*360/maxBalls; tAtk.xOrig=x; tAtk.yOrig=y; tAtk.projType=0
                }
                Btime=0
            }
        }
        if atkList[2]=true //magic
        {
            //if atkTime<swooptime {Mtime+=1}
            if atkTime<swooptime {Mtime+=1*gDeltaTime} //60fps change: per frame
            else {Mtime=0}
            
            if Mtime>=20 and Mtime<=30
            {
                image_angle=player_sprite_center()
                if frac(Mtime)=0 //60fps change (added): one particle per 30fps tick, counted from Mtime
                {
                var tEffect;
                tEffect=instance_create(x,y-10,oEffect)
                tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.2+random(0.1); tEffect.newBlend=-1
                tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
                } //60fps change (added)
            }
            else if Mtime=40
            {
                playSound(global.snd_Magic,0,0.98,1)
                var tAtk,tMax,tAng;
                tMax=Mmax
                tAng=image_angle
                if tMax=3 {tAng-=25}
                else if tMax=5 {tAng-=50}
                else if tMax=2 {tAng-=12.5}
                else if tMax=4 {tAng-=37.5}
                for(i=0;i<tMax;i+=1)
                {
                    tAtk=instance_create(x+lengthdir_x(10,image_angle),y+lengthdir_y(10,image_angle),oKamBounceBall)
                    //tAtk.sprite_index=sKamekShape; tAtk.direction=tAng; tAtk.atkPower=atkPower; tAtk.projType=1; tAtk.bulletSpeed=5
                    tAtk.sprite_index=sKamekShape; tAtk._direction=tAng; tAtk.atkPower=atkPower; tAtk.projType=1; tAtk.bulletSpeed=5 //60fps change: DT3+'s oKamBounceBall moves by its own _direction
                    tAtk.image_index=irandom_range(0,2)
                    tAng+=25
                }
            }
            else if Mtime>=Mdelay {Mtime=0}
        }
        if atkList[3]=true //lightning
        {
            //to be adjusted
            //Ltime+=1
            Ltime+=1*gDeltaTime //60fps change: per frame
            if Ltime>=Ldelay
            {
                //image_angle=90
                var tAtkLight;
                tAtkLight=instance_create(oPlayer1.x,oKamek.yGround,oCackLightning) //at player
                tAtkLight.type=0; tAtkLight.warnTime=30; tAtkLight.decay=10
                //tAtkLight=instance_create(x,oKamek.yGround,oCackLightning) //at self
                //tAtkLight.type=0; tAtkLight.warnTime=30; tAtkLight.decay=10
                Ltime=0
            }
            /*else if atkTime>=201 and atkTime<=220 //Wand sparkles
            {
                var tEffect;
                tEffect=instance_create(x,y-10,oEffect)
                tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.2+random(0.1); tEffect.newBlend=-1
                tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
            }*/
        }
        if atkList[4]=true //fire - only using side
        {
            /*if atkTime>=10
            {
                var tEffect;
                tEffect=instance_create(x,y-10,oEffect)
                tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.2+random(0.1); tEffect.newBlend=-1
                tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1.5,1.5); tEffect.ySpd=random_range(-1.5,1.5)
            }*/
            if atkTime mod 25=0
            {
                event_user(0) //use top fire (Kamek user event 1)
                meteorSeq+=1
            }
        }
        if atkList[5]=true //movement - follow
        {
            if atkTime<swooptime and (Mtime<20 or Mtime>40) //not during swoops or magic aiming
            {
                //basic animation, rot direction based on movement direction
                //image_angle+=10*sign(x-oPlayer1.x)
                //if x>oPlayer1.x and xVel>-3 {xVel-=0.2}
                //else if x<oPlayer1.x and xVel<3 {xVel+=0.2}
                //x+=xVel
                image_angle+=10*sign(x-oPlayer1.x)*gDeltaTime //60fps change: per frame
                var tAccW; tAccW=0 //60fps change (added): the speed-up, decided once per 30fps tick (scrTickAcc), so the speed cap lands as at 30fps
                if x>oPlayer1.x and xVel>-3 {tAccW=-0.2} //60fps change
                else if x<oPlayer1.x and xVel<3 {tAccW=0.2} //60fps change
                xVel=scrTickAcc(xVel,tAccW,1) //60fps change (added)
                x+=(xVel+scrTickAccB(1))*gDeltaTime //60fps change: per frame
            }
        }
        else if atkList[6]=true //movement - fixed
        {
            if atkTime<swooptime and (Mtime<20 or Mtime>40) //not during swoops or magic aiming
            {
                //basic animation, rot direction based on movement direction
                //bounce between left and right of the "meteor shaft" -> 184 to 360
                //choose starting speed to go across the centre
                //image_angle+=10*sign(-xVel)
                image_angle+=10*sign(-xVel)*gDeltaTime //60fps change: per frame
                if xVel=0 {xVel=3-6*(x>=oKamek.xCenter)} // INITIAL: move right if left of centre, else left
                else if xVel>0 and x>=360 {xVel=-xVel} //turnarounds; no lingering at the edges
                else if xVel<0 and x<=184 {xVel=-xVel}
                //x+=xVel
                x+=xVel*gDeltaTime //60fps change: per frame
            }
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
