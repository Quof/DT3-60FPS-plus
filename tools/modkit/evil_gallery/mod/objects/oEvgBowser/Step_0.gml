//Evil Boss Gallery: Evil Bowser's step: Bowser's (oBowser), with his evil moves (see Create). atkProg: 0 stand (hops
//and fireballs), 1-4 Bowser's stomp (jump, air time, fall, landing), 10-12 hammers, 20-23 meteor (then the fall and the
//landing are the stomp's, 3 and 4, faster: meteorFall), 30-32 inferno
if global.gamePaused=false
{
  if activateBoss=1
  {
    bActive=true
    activateBoss=2
  }

  if bActive=true and stunnedTime=0
  {
    if atkProg=0 //---------- Stand: hops and fireballs, till his next move ----------
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      atkTime+=1*gDeltaTime
      if atkTime>=jumpDelay
      {
        if isCollisionBottom(1)
        {
          //the next move: the next of his pattern for the row he's on (a double stomp's second stomp comes first)
          var tPat;
          if forceStomp=1 {evgMove="S"; forceStomp=0}
          else
          {
            tPat=evgPat[min(bossProgress,3)]
            if evgPatPos>=string_length(tPat) {evgPatPos=0}
            evgMove=string_char_at(tPat,evgPatPos+1)
            evgPatPos+=1
          }
          evgTime=0
          atkTime=0
          xVel=0
          if evgMove="H" //---- hammers: one held up first ----
          {
            sprite_index=sEvgBowserStand; image_index=2
            playSound(global.snd_KnightSwordSwing,0,0.85,1)
            atkProg=10
          }
          else if evgMove="M" //---- meteor: a crouch first ----
          {
            sprite_index=sEvgBowserStomp; image_index=0
            atkProg=20
          }
          else if evgMove="I" //---- inferno: the roar ----
          {
            sprite_index=sEvgBowserStand; image_index=3
            atkProg=30
          }
          else //---- stomp: Bowser's jump, a fireball as he goes ----
          {
            if fireTime>=fireDelay-1 {evgBowserFire(0)}
            xDropSpot=oPlayer1.x
            xSpd=point_distance(x,0,xDropSpot,0)
            xSpd/=12
            if xSpd<2 {xSpd=2}
            else if xSpd>8 {xSpd=8}
            sprite_index=sEvgBowserStand; image_index=1
            atkProg=1; jumpTk=0
          }
        }
      }
      else //Hop
      {
        hopTime-=1*gDeltaTime
        if hopTime<=0 and yVel=0
        {
          y-=2
          yVel-=1.5
          hopTime=30
        }

        //Fireball (from the second row down, more after it: fireBurst)
        fireTime+=1*gDeltaTime
        if fireTime>=fireDelay and y<328
        {
          if fireTime=fireDelay
          {
            sprite_index=sEvgBowserStand
            image_index=2
          }
          else if fireTime=fireDelay+4
          {
            sprite_index=sEvgBowserStand
            image_index=3
          }
          else if fireTime>=fireDelay+8
          {
            evgBowserFire(0)
            fireBurst=min(bossProgress,2)
            fireBurstT=0
            fireBurstK=0
            sprite_index=sEvgBowserStand; image_index=0
            fireTime=0
          }
        }
        else
        {
          if isCollisionBottom(1) //Animation
          {
            sprite_index=sEvgBowserStand
            image_index=0
          }
          else
          {
            sprite_index=sEvgBowserStand
            image_index=1
          }
        }
      }
    }
    else if atkProg=1 //---------- Jump (Bowser's) ----------
    {
      //(once per 30fps tick of the jump: still rising? which way? and the found-spot check, as Bowser's)
      if frac(jumpTk)=0 {jumpRise=(y>144); jumpRight=(x<xDropSpot)}
      if jumpRise {y-=12*gDeltaTime}
      if jumpRight
      {
        image_xscale=1
        x+=xSpd*gDeltaTime
      }
      else
      {
        image_xscale=-1
        x-=xSpd*gDeltaTime
      }
      jumpTk+=gDeltaTime
      if frac(jumpTk)=0 and point_distance(x,0,xDropSpot,0)<12 //found spot
      {
        move_snap(16,1)
        sprite_index=sEvgBowserStomp; image_index=0
        atkProg+=1
      }
    }
    else if atkProg=2 //---------- Slight air time ----------
    {
      atkTime+=1*gDeltaTime
      if atkTime>=12
      {
        atkTime=0
        atkProg+=1
      }
      else {y-=0.5*gDeltaTime}
    }
    else if atkProg=3 //---------- Butt stomp (the meteor's faster) ----------
    {
      if meteorFall=1 {yVel=14}
      else {yVel=10}
    }
    else if atkProg=4 //---------- Break block check ----------
    {
      atkTime+=1*gDeltaTime
      if atkTime>=8
      {
        if meteorFall=1 //(a meteor's landing: a longer rest after it)
        {
          meteorFall=0
          atkTime=-24
          atkProg=0
        }
        else
        {
          jumpNum+=1
          if jumpNum>=2 //Double stomp
          {
            jumpNum=-1
            forceStomp=1
            atkTime=jumpDelay-6
            atkProg=0
          }
          else
          {
            atkTime=0
            atkProg=0
          }
        }
      }
    }
    else if atkProg=10 //---------- Hammers: one held up ----------
    {
      evgTime+=1*gDeltaTime
      xVel=0
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
      if evgTime>=20
      {
        evgTime=0
        hammerNum=0
        atkProg=11
      }
    }
    else if atkProg=11 //---------- Hammers: the volley, one every 5 ticks ----------
    {
      evgTime+=1*gDeltaTime
      if evgTime>=5
      {
        evgTime-=5
        var tHam;
        tHam=instance_create(x+(10*image_xscale),y-36,oGravityBullet)
        tHam.sprite_index=sHammerBHam; tHam.atkPower=atkPower
        tHam.xVel=evgHamX[hammerNum mod 6]*image_xscale; tHam.yVel=-7
        playSound(global.snd_OrbThrow,0,0.9,1)
        sprite_index=sEvgBowserStand; image_index=2+(hammerNum mod 2)
        hammerNum+=1
        if hammerNum>=hammerMax
        {
          evgTime=0
          atkProg=12
        }
      }
    }
    else if atkProg=12 //---------- Hammers: done ----------
    {
      evgTime+=1*gDeltaTime
      if evgTime>=15
      {
        sprite_index=sEvgBowserStand; image_index=0
        atkTime=0
        atkProg=0
      }
    }
    else if atkProg=20 //---------- Meteor: the crouch ----------
    {
      evgTime+=1*gDeltaTime
      xVel=0
      if evgTime>=12
      {
        playSound(global.snd_SpringJump,0,0.8,1)
        sprite_index=sEvgBowserStand; image_index=1
        evgTime=0
        atkProg=21
      }
    }
    else if atkProg=21 //---------- Meteor: up to the ceiling ----------
    {
      xVel=0; yVel=0
      y-=12*gDeltaTime
      if y<=meteorY
      {
        y=meteorY
        evgTime=0
        atkProg=22
      }
    }
    else if atkProg=22 //---------- Meteor: following the player along the ceiling ----------
    {
      evgTime+=1*gDeltaTime
      xVel=0; yVel=0
      var tStep;
      tStep=meteorSpd*gDeltaTime
      if oPlayer1.x>x {x+=min(tStep,oPlayer1.x-x); image_xscale=1}
      else if oPlayer1.x<x {x-=min(tStep,x-oPlayer1.x); image_xscale=-1}
      if x<592 {x=592}
      if x>848 {x=848}
      if evgTime>=meteorHunt
      {
        playSound(global.snd_DashWarn,0,1,1)
        evgTime=0
        atkProg=23
      }
    }
    else if atkProg=23 //---------- Meteor: locked on (flashing) ----------
    {
      evgTime+=1*gDeltaTime
      xVel=0; yVel=0
      if evgTime>=16
      {
        move_snap(16,1)
        y=meteorY
        sprite_index=sEvgBowserStomp; image_index=0
        meteorFall=1
        evgTime=0
        atkProg=3
      }
    }
    else if atkProg=30 //---------- Inferno: the roar (the first two Paratroopas fly in) ----------
    {
      evgTime+=1*gDeltaTime
      xVel=0
      if evgTime=1
      {
        playSound(global.snd_KraidRoarA,0,0.9,1)
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_blend=make_color_rgb(150,40,90); tFlash.image_alpha=0.5; tFlash.fadeSpeed=0.04
        paraNum=0
        evgSpawnPara()
        evgSpawnPara()
        shakeTime=12
      }
      if evgTime>=30
      {
        evgTime=0
        atkProg=31
      }
    }
    else if atkProg=31 //---------- Inferno: embers rising from the floor ----------
    {
      evgTime+=1*gDeltaTime
      xVel=0
      if gDeltaDoTicks
      {
        var tEffect;
        tEffect=instance_create(584+random(272),272-random(4),oEffect)
        tEffect.sprite_index=sEvgPoeFlame; tEffect.image_speed=0.3; tEffect.image_xscale=0.4; tEffect.image_yscale=0.4
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1-random(1)
      }
      if evgTime>=40
      {
        evgTime=0
        paraTime=0
        playSound(global.snd_Flame1,0,0.8,1)
        evgInfernoLight()
        atkProg=32
      }
    }
    else if atkProg=32 //---------- Inferno: burning (more Paratroopas, and his fireballs, slower) ----------
    {
      evgTime+=1*gDeltaTime
      xVel=0
      paraTime+=1*gDeltaTime
      if paraTime>=35
      {
        paraTime-=35
        evgSpawnPara()
      }
      fireTime+=1*gDeltaTime
      if fireTime>=fireDelay+20
      {
        evgBowserFire(0)
        fireTime=0
      }
      if evgTime>=infernoLen
      {
        with (oEvgParatroopa) {leaving=1}
        sprite_index=sEvgBowserStand; image_index=0
        atkTime=0
        atkProg=0
      }
    }

    //---------- A fireball burst's next fireballs (16 ticks apart: foot high, then chest high) ----------
    if fireBurst>0
    {
      fireBurstT+=1*gDeltaTime
      if fireBurstT>=16
      {
        fireBurstT-=16
        fireBurstK+=1
        fireBurst-=1
        evgBowserFire(fireBurstK mod 2)
      }
    }

    //Gravity (on the ground, not in the stomp's jump and fall or the meteor's leap)
    if atkProg=0 or atkProg=4 or (atkProg>=10 and atkProg<=12) or atkProg=20 or atkProg>=30
      yVel=scrGravAcc(yVel,0.2,1)

    if isCollisionSolid()
      y-=2
    if isCollisionBottom(1)
    {
      yVel=0
      if atkProg=3
      {
        playSound(global.snd_ThwompHit,0,1,1)
        var tEffect;
        tEffect=instance_create(x+12,bbox_bottom,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=1; tEffect.ySpd=0
        tEffect=instance_create(x-12,bbox_bottom,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_xscale=-1; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=-1; tEffect.ySpd=0
        if meteorFall=1
        {
          playSound(global.snd_Earthquake,0,1,1)
          shakeTime=10
        }
        stompId+=1
        evgBowserWaves()
        sprite_index=sEvgBowserStomp; image_index=1
        atkProg+=1
        y+=1
      }
    }

    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
    if y>room_height+48 //---------- End fight: back to the evil gallery, at his door ----------
    {
      with oEProjectileBase {instance_destroy()}
      with oEvgParatroopa {instance_destroy()}
      with oEvgBulletBill {instance_destroy()}
      evgTally(1)
      global.newMapX=264; global.newMapY=1376; room_goto(rEvgGallery)
      instance_destroy()
    }

    //----- Last block phase (Bowser's: the bottom blocks lower, the switches come up; both switches pressed, the bottom
    //blocks go back up and break away) -----
    if bottomBlocks>=0 and bottomBlocks<=99
    {
      bottomBlocks+=1*gDeltaTime
      if bottomBlocks>0 and bottomBlocks<=16 //Move bottom blocks down
      {
        for(i=0;i<8;i+=1) //455498 - 455505
        {
          (GID(455498+i)).y+=1*gDeltaTime
        }
      }
      if bottomBlocks=20
      {
        (GID(122344)).bTellMeToExplode=1
        (GID(122345)).bTellMeToExplode=1
        (GID(122358)).bTellMeToExplode=1
        (GID(122359)).bTellMeToExplode=1
        instance_create(608,288,oBowSwitch)
        instance_create(832,288,oBowSwitch)
        bottomBlocks=100
      }
    }
    else if bottomBlocks=100 //Check for one switch destroyed
    {
      if instance_number(oBowSwitch)=1
      {
        topFire=1
        bottomBlocks=150
      }
    }
    else if bottomBlocks=150 //Check for both switches destroyed
    {
      if instance_number(oBowSwitch)=0
      {
        bottomBlocks=200
      }
    }
    else if bottomBlocks>=200 and bottomBlocks<=400
    {
      bottomBlocks+=1*gDeltaTime
      if bottomBlocks>280 and bottomBlocks<=296 //Move bottom blocks up
      {
        for(i=0;i<8;i+=1) //455498 - 455505
        {
          (GID(455498+i)).y-=1*gDeltaTime
        }
      }
      else if bottomBlocks=300
      {
        var tEffect;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(664+(i*16),328,oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.image_speed=0.2+random(0.2); tEffect.xSpd=0; tEffect.ySpd=-1-random(2)
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
        }
        with oBowBottomBlock {instance_destroy()}
      }
    }

    if topFire>=1 //Fire from the top (more often than Bowser's)
    {
      topFire+=1*gDeltaTime
      if topFire mod 50=0
      {
        var tNewAttack;
        tNewAttack=instance_create(oPlayer1.x,0,oPassBullet)
        tNewAttack.sprite_index=sEvgBowserFire1; tNewAttack.atkPower=3; tNewAttack.bulletSpeed=2.5
        tNewAttack._direction=270; tNewAttack.decayTime=-100; tNewAttack.damageType="ELEMENTAL"
      }
    }

    //---------- Bullet Bills, in the last phase till the floor opens: from each side in turn, low then high ----------
    if bossProgress>=3 and bottomBlocks<200
    {
      billTime+=1*gDeltaTime
      if billTime>=75
      {
        billTime-=75
        var tBill,tSide,tHigh;
        tSide=billNum mod 2
        tHigh=(billNum div 2) mod 2
        if tSide=0
        {
          tBill=instance_create(566,258-(tHigh*32),oEvgBulletBill)
          tBill.bulletSpeed=3; tBill.image_xscale=1
        }
        else
        {
          tBill=instance_create(874,258-(tHigh*32),oEvgBulletBill)
          tBill.bulletSpeed=-3; tBill.image_xscale=-1
        }
        playSound(global.snd_MarioCannon,0,1,1)
        billNum+=1
      }
    }

    //---------- Boss Difficulty Curve (Bowser's rows: faster now, with fire rain at each, and the last phase) ----------
    //(each row's pattern starts from its first move: evgPatPos)
    if bossProgress=0 and y>=280
    {
      jumpDelay=70
      fireDelay=36
      waveSpd=4
      meteorSpd=4
      evgPatPos=0
      bossProgress+=1
    }
    else if bossProgress=1 and y>=296
    {
      jumpDelay=64
      fireDelay=32
      waveSpd=4.5
      meteorHunt=44
      evgPatPos=0
      playSound(global.snd_Fireball,0,0.99,1)
      for(i=0;i<5;i+=1)
      {
        var tNewAttack;
        tNewAttack=instance_create(592+(i*64),0,oPassBullet)
        tNewAttack.sprite_index=sEvgBowserFire1; tNewAttack.atkPower=3; tNewAttack.bulletSpeed=3
        tNewAttack._direction=270; tNewAttack.decayTime=-100
      }
      bossProgress+=1
    }
    else if bossProgress=2 and y>=312
    {
      bottomBlocks=0
      instance_create(656,320,oBowBottomBlock)
      var tEffect;
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(664+(i*16),328,oEffect)
        tEffect.sprite_index=sMMSmokeCloud
        tEffect.image_speed=0.2+random(0.2); tEffect.xSpd=0; tEffect.ySpd=-1-random(2)
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
      }
      jumpDelay=60
      fireDelay=30
      meteorSpd=4.5
      meteorHunt=38
      evgPatPos=0
      playSound(global.snd_Fireball,0,0.99,1)
      for(i=0;i<5;i+=1)
      {
        var tNewAttack;
        tNewAttack=instance_create(592+(i*64),0,oPassBullet)
        tNewAttack.sprite_index=sEvgBowserFire1; tNewAttack.atkPower=3
        tNewAttack.bulletSpeed=3; tNewAttack._direction=270; tNewAttack.decayTime=-100
      }
      bossProgress+=1
    }

    //---------- The view shaking (a meteor's landing, the roar) ----------
    if shakeTime>0
    {
      shakeTime-=1*gDeltaTime
      if instance_exists(viewFix)
      {
        if shakeTime<=0 {viewFix.x=720}
        else if gDeltaDoTicks {viewFix.x=720+3*(1-2*((floor(shakeTime) mod 2)=0))}
      }
    }
  }
  enemyStepEvent()
}
