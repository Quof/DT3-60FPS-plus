if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=3
    if atkPhase=1
    {
        jeremyText="He still has the usual Executive rules. Hmmm... It looks like he won't drop hearts at the end of a life bar anymore. This might be tough..."
        chaoText="I can see a few more things. For one, don't worry about the lack of heart drops. When you see an infinity sign pop up, it means that you'll have infinite dash energy for that phase. Having that happen during a boss fight is a little scary... The red cherries are still undashable so don't get overconfident."
        devText="This is for you, Jaimers :3##By the way, each phase is going to have its own scan text."
        for(i=0;i<5;i+=1) {resType[i]=3}
    }
    activateBoss=2
    var tempMplay;
    tempMplay=findMusic(2010+atkPhase)
    playMusic(tempMplay,0,0)
  }

  if bActive=true and life>0
  {
    //if oGame.time mod 3=0
    if oGame.time mod (3/gDeltaTime)=0 //60fps change: every 3 30fps ticks (oGame.time counts frames)
    {
      if image_xscale=1 {image_xscale=-1}
      else {image_xscale=1}
    }

    if grace=0
    {
        for(i=0;i<5;i+=1)
        {
            //atkTime[i]+=1
            atkTime[i]+=1*gDeltaTime //60fps change: per frame
        }
        //ATTACK PHASES
        event_user(atkPhase)
    }
    else
    {
        //grace+=1
        grace+=1*gDeltaTime //60fps change: per frame
        if grace=60
        {
            grace=0
            bCanTakeDamage=1; bCanDealDamage=1
            image_alpha=1
            var tempMplay;
            tempMplay=findMusic(2010+atkPhase)
            playMusic(tempMplay,0,0)
        }
    }

    //---------- Boss Difficulty Curve ----------
    if atkPhase=1 //======================================== PURE DANMAKU HELL
    {
      if bossProgress=0 and life<=maxLife-3000
      {
        bossProgress+=1
        for(i=0;i<5;i+=1)
        {
            atkTime[i]=0
        }
        atkTime[1]=30
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
      }
      else if bossProgress=1 and life<=maxLife-9000
      {
        //resType[1]=1; resType[5]=1
        bossProgress+=1
        cycleCounter=0
        cycleColour=oApRed
        for(i=0;i<5;i+=1)
        {
            atkTime[i]=0
        }
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
      }
      else if bossProgress=2 and life<=maxLife-17000
      {
        //resType[1]=3; resType[5]=3
        bossProgress+=1
        atkTime[0]=0
        atkTime[1]=30
        atkTime[2]=0
        with oEProjectileBase
        {
          tEfCir=instance_create(x,y,oEfCircleBlast)
          tEfCir.image_alpha=0.7; tEfCir.myRad=4; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
          instance_destroy()
        }
        cycleCounter=0
      }
      else if bossProgress=3 and life<=maxLife-30000 // move on to CIRCUS
      {
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        oPlayer1.image_yscale=1
        event_user(8)
        atkProg=0
        cycleCounter=0
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
        tempDir=0
        //create crystal
        /*var Krissi;
        Krissi=instance_create(864,176,oLatchCrystal)
        Krissi.image_xscale=12; Krissi.image_yscale=5*/
        for(i=0;i<6;i+=1) {resType[i]=1}
        resType[0]=3
        jeremyText="This is a Claire phase, Jerry can't deal damage to him. He bounces around the room and does his slash attack every so often. When he bounces, he'll spawn some apples as well. Note that the bounces off the top aren't entirely based on physics."
        chaoText="There's not much to say. Just keep cool and roast him."
        devText="Executive is the only thing I haven't achilles'd in vanilla, and for good reason. Namely that every attempt at this guy takes a good five minutes, so my motivation drops faster than birdshit. It doesn't help that the hardest part to no-hit (avoidance) is towards the end. I'm sure the fangamers can sympathise."
      }
    }
    else if atkPhase=2 //======================================== CIRCUS
    {
      if bossProgress=0 and life<=maxLife-10000
      {
        bossProgress+=1
        //teleport with grace period + new direction
        //bCanTakeDamage=0; bCanDealDamage=0
        //x=864
        //y=64
        //direction=215
      }
      else if bossProgress=1 and life<=maxLife-20000 //move on to DANCE-OFF
      {
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        event_user(8)
        x=912
        y=64
        //direction=0
        _hspeed=0 //60fps change: the boss moves by _hspeed/_vspeed now (correctHSpeedVSpeed, below)
        //speed=0
        _vspeed=0 //60fps change: see above
        atkProg=0
        for(i=0;i<6;i+=1) {resType[i]=1}
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
        cycleCounter=0
        tempFlag=0
        global.hasShoes[0]=1 //no walking
        global.hasShoes[1]=1 //no jumping
        oPlayer1.image_xscale=1 //facing right
        //jeremyText="Ohhh man. Make sure to only press the button you're supposed to. You won't take damage or anything but you don't want to risk messing with the input recognition."
        jeremyText="Alright, so. Your parry and character switch cooldowns have been reduced to almost nothing. Your position has been locked and I can't be bothered to fix that, and you can't walk or jump anyway. Keep in mind that dashing is still useful, but also remember that guarding will kill your iframes. The boss seems to be exhausting himself by dancing so all you need to do is survive."
        //chaoText="No wonder Sephiroth didn't want to do a dance-off, if my boss did this I'd never want to dance again either."
        chaoText="Sephiroth is cheering you on guys, don't disappoint him!#####Oh and I guess Jeremy missed that your dash energy won't recharge."
        devText="If you think about it, this is really just Helmethead 2.2.3.2 with the directional inputs removed and using parry, dash and charcter switching instead."
      }
    }
    else if atkPhase=3 //======================================== DANCE-OFF
    {
      if bossProgress=0 and life<=maxLife-20000
      {
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        //tile_layer_hide(999998)
        //with midPlatA {instance_destroy()}; with midPlatB {instance_destroy()};
        event_user(8)
        //resType[1]=3; resType[5]=3
        atkProg=0
        x=864
        y=64
        image_angle=0
        tempSeph=-1
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
        cycleCounter=0
        tempFlag=0
        lastParryChar=1 //Start with torus apples.
        global.hasShoes[0]=2 //walking is back
        global.hasShoes[1]=2 //jumping is back

        //restore dash energy and regen
        oPlayer1.dashEnergy=9999
        oPlayer1.dashRecovery=24+(global.skillTree[22]*2)
        if global.activeCharacter=0
        {
            for(i=0;i<3;i+=1)
              if global.equipJerry[i]=25
                oPlayer1.dashRecovery+=4
        }
        else
        {
            for(i=0;i<3;i+=1)
              if global.equipClaire[i]=25
                oPlayer1.dashRecovery+=4
        }

        for(i=0;i<6;i+=1) {resType[i]=1}
        jeremyText="Okay, in this phase he can only be damaged for a short while after a parry, and only by basic attacks (no specials). His attacks always come with the same timing but there are no visual tells, so I suggest using Jerry here.#Once his health gets lower he will start to curve his movement."
        chaoText="Uh oh, he has some code to mess with your coordinates. It'll only happen if you're near the borders of the arena, so you can avoid triggering it if you want to. But maybe you can take advantage of it...?"
        devText="If you are a true gamer you don't need me to tell you that you have infinite double jumps here."
      }
    }
    else if atkPhase=4 //======================================== MIXED
    {
      if bossProgress=1 and life<=maxLife-10000  //starts at 1 due to initialization
      {
        bossProgress+=1
      }
      else if bossProgress=2 and life<=maxLife-20000 //move on to WASHING MACHINE
      {
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        oPlayer1.y=312
        oPlayer1.waveOfAwesomeScale=4
        oPlayer1.image_yscale=0.5
        event_user(8)
        //MOVE TO RIGHT SPOT
        x=864
        y=80
        //DESTROY FIRES
        with oExe_SideFire {if y>270 or y<120 {instance_destroy()}}
        with oInvisibleSolid {x-=10000}
        with oInvisibleSlimSolid {x-=10000}
        tile_layer_show(1000000)
        instance_create(0,0,oInfiniteDash)
        atkProg=0
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        for(i=0;i<6;i+=1) {resType[i]=3}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
        jeremyText="Oh hey, this kind of reminds me of a washing machine... kind of. Speaking of, I should go polish my mech."
        chaoText="This is getting boring so if you don't mind I'll go pratice my DT4 lines.#-Chao##P.S.: Looks like the infinite dash phase went unused.#P.P.S.: The line about DT4 was written way before the reveal."
        devText=":3  :3  :3##When in doubt, wiggle back and forth and pretend you're dodging."
      }
    }
    else if atkPhase=5 //======================================== WASHING MACHINE
    {
      /*if bossProgress=0 and life<=maxLife-20000
      {
        var tFlash; tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        maxLife=30000
        event_user(8)
        for(i=0;i<6;i+=1) {resType[i]=1}
        atkProg=0
        for(i=0;i<5;i+=1) {atkTime[i]=0}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        moveTime=0; moveProg=0; bossProgress=0; atkPhase+=1
        jeremyText="Oh hey, this kind of looks like a washing machine... kind of. Speaking of, I should go polish my mech."
        chaoText="This is getting boring so if you don't mind I'll go pratice my DT4 lines. Make sure to remember what I told you in the first phase's scan or you won't be able to figure out what the flashing green infinity sign means.#-Chao"
        devText="Aaaaand we're back to danmaku. This exists half because I wanted to try and recreate the pattern and half because I thought it might be interesting with dashing.#Have fun, Jaimers.#To everyone else, good luck."
      }*/
    }
    else if atkPhase=6 //========================================
    {
      /*if bossProgress=0 and life<=maxLife-2000
      {
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        bossProgress+=1
      }
      else if bossProgress=1 and life<=maxLife-5000
      {
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        bossProgress+=1
      }
      else if bossProgress=6 and life<=maxLife-20000
      {
        life=maxLife-20000
        phase6_phase=7
        moveTime=0; moveProg=1
        for(i=0;i<6;i+=1) {resType[i]=1}
        for(i=0;i<5;i+=1) {atkTime[i]=-1}
        for(i=0;i<3;i+=1) {exVal[i]=0}
        bossProgress+=1
        jeremyText=""
        chaoText=""
        devText=""
      }*/
    }
  }
  else if life<=0
  {
    with oApRed
    {
        tMoneyDrop=instance_create(x,y,oMoneyPickup)
        tMoneyDrop.moneyType=20; tMoneyDrop.moneyWorth=999
        instance_destroy()
    }
    with oApGreen
    {
        tMoneyDrop=instance_create(x,y,oMoneyPickup)
        tMoneyDrop.moneyType=1; tMoneyDrop.moneyWorth=9
        instance_destroy()
    }
    with oApBlue
    {
        tMoneyDrop=instance_create(x,y,oMoneyPickup)
        tMoneyDrop.moneyType=5; tMoneyDrop.moneyWorth=99
        instance_destroy()
    }
    //deathAnim+=1
    deathAnim+=1*gDeltaTime //60fps change: per frame

    if frac(deathAnim)=0 //60fps change (added): the flashing and explosions once per 30fps tick, counted from deathAnim
    {
    if image_blend=c_white {image_blend=c_red}
    else {image_blend=c_white}

    if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
    tEffect=instance_create(x+random_range(-17,17),y+random_range(-34,34),oEffect); tEffect.sprite_index=sShipExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5+random(0.5)
    } //60fps change (added)

    if deathAnim>=60
    {
      playSound(global.snd_HardHit1,0,1,14000)
      for(i=0;i<32;i+=1)
      {
        tEffect=instance_create(x+random_range(-34,34),y+random_range(-68,68),oEffect); tEffect.sprite_index=sShipExplosion
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5+random(0.5)
      }
      /*if global.bBossGallery=1
      {
        bossRoomTally(63)
        global.newMapX=2776; global.newMapY=224; room_goto(rBossGallery)
      }*/
      //else
      //{
        //oEvAltAbomEnding.sceneProgress=1
        global.currentBoss=""
        global.bossTrack=0
        var tempMplay,tFlash;
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.1; tFlash.image_alpha=0.5
        with oExit
        {
          bShowArrow=true
          y-=1000
          arrowX=x+8
          arrowY=y-24
        }
        instance_destroy()
      //}
    }
  }
  enemyStepEvent()
}
//else {speed=0}
else {_hspeed=0; _vspeed=0} //60fps change: the boss moves by _hspeed/_vspeed
correctHSpeedVSpeed(self) //60fps change (added): moves it by _hspeed/_vspeed, per frame
