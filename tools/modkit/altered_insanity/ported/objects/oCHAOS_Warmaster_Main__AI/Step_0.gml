if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true

    if room=rBT_WarmasterB
    {
      if y<272 {showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0}
      else {showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=2}
    }
    else
    {
      showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=2
    }
    bCanDealDamage=true; bCanTakeDamage=true
    jeremyText="The Warmaster is able to employ a wide range of close range sword attacks. Which is trouble for you because he's practically immune to most of your projectiles. He's got a standard sword attack that also launches a fairly close range wave. A dash, jump, and dive attack. Jerry, you cover a lot of space with your sword, but Claire, you have good range. Keep that in mind."
    chaoText="There's definitely more to him than this, there has to be. A bot so renown for being unbeatable would have a lot more than this. Also I see he takes double damage from birds? Don't know if that's relevant but I'm sure it's good to know."
    devText="If you've made it to this, then you've been doing well. I hope you enjoyed the game as much as I enjoyed making it. It was a long process, but a lot was learned. This is also my departure from sprite rips. While I enjoy this type of stuff, I've got a lot of other ideas I'd like to explore. Also this guy is really challenging, hope you're up for it."
    
    if global.inBossChallenge
    {
        jeremyText="I've always wanted to fight this guy, you guys made it look too fun. Step back and let me show you how it's done! My Mech's AR vision shows that this form is weak to my flamethrower. Makes sense, it's as close to melee as I get!"
        chaoText="Go brother, you got this! Avoiding attacks is only half the battle here, learn what situations are undodgeable and try to avoid those. A couple changes to your abilities: Combos don't raise your damage here. Also don't forget about your Vertical Shield Technique you conveniently have only in this Virtual Insanity realm! Press Up and B to deploy shields above and below you."
        devText="Jeremy isn't as agile as you're used to, you'll have to find new ways to dodge, and use your shields wisely."
    }
    
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if bGoombaStomp=1 and ATTACK_FORM!=3 //Limited time on achievement after Warmaster swaps
    {
      goombaStompTime-=1*gDeltaTime
      if goombaStompTime<=0 {bGoombaStomp=0}
    }

    timeTillLastHit+=1*gDeltaTime
    //-------------------- Manage form change --------------------
    if superChangeAtk=0
    {
      if atkNum=0
      {
        if shiftType=0 or shiftType=1
        {
          if shiftDamage>=4
          {
            shiftTime+=1*gDeltaTime
            if shiftTime>=shiftMaxTime or shiftDamage>=shiftDmgMax and currentAttack=0 and atkNum=0
            {
              if orderChangeSetting=0
              {
                event_user(7)
                orderChangeSetting=1
              }

              ATTACK_FORM=orderSet[orderNum]
              orderNum+=1
              if orderNum=4 {orderNum=0; event_user(7)}
              event_user(5)
            }
          }
        }
        else
        {
          shiftTime+=1*gDeltaTime
          if shiftTime>=timeTillChange and currentAttack=0
          {
            ATTACK_FORM=orderSet[orderNum]
            orderNum+=1
            if orderNum=4 {orderNum=0; event_user(7)}
            event_user(5)
            timeChangeSet+=1
            if timeChangeSet=1 {timeTillChange=210}
            else if timeChangeSet=2 {timeTillChange=110}
            else if timeChangeSet=3 {timeTillChange=170}
            else if timeChangeSet=4 {timeTillChange=90}
            else if timeChangeSet=5 {timeTillChange=150; timeChangeSet=0}
            if ATTACK_FORM=3 {timeTillChange+=30}
          }
        }
      }
    }

    //-------------------- Facing direction --------------------
    if waitTime<waitDelay or sprite_index=sWarmasterD_Hover
    {
      if x<oPlayer1.x {image_xscale=1.25}
      else {image_xscale=-1.25}
      xVel=0
    }
    if image_xscale>0 {scaleForFacing=1}
    else {scaleForFacing=-1}

    //-------------------- Idle animation speed --------------------
    if sprite_index=sWarmasterA_Idle {image_index+=0.25*gDeltaTime}
    else if sprite_index=sWarmasterA_JumpUp or sprite_index=sWarmasterA_JumpDown {image_index+=0.25*gDeltaTime}
    else if sprite_index=sWarmasterB_Idle or sprite_index=sWarmasterC_Idle or sprite_index=sWarmasterD_Idle {image_index+=0.15*gDeltaTime}

    if sprite_index=sWarmasterA_SwordRoll {swdRollAng-=45*scaleForFacing*gDeltaTime}

    if sprite_index=sWarmasterA_GrappleRopeB //Keep in place when grappled to the rope
    {
      x=ropeX+(10*image_xscale)
      y=yGround-122 //48+96+38 - ceiling_height+rope_length+sprite_height_offset
    }

    //-------------------- Effect timer --------------------
    if dashEfType>0
    {
      dashEfFrm+=0.33*gDeltaTime
      if dashEfFrm>=2.6 {dashEfType=0}
    }

    if sprite_index=sWarmasterB_Dashing //Super dash trail and fire pillars
    {
      if gDeltaDoTicks {var tAfterI;
      tAfterI=instance_create(x,y,oWMB_DashImage)
      tAfterI.image_xscale=image_xscale; tAfterI.image_yscale=image_yscale}

      if actTime mod 3=0 and currentAttack=5
      {
        var tDFPillar;
        tDFPillar=instance_create(x,yGround,oWMB_DashFPillar); tDFPillar.atkPower=atkPower
        tDFPillar.image_xscale=0.6; tDFPillar.image_yscale=0.9
      }
    }

    //Movement - Not linked to attacks
    if ATTACK_FORM=3
    {
      if hoverMode=1 //Follow player, but hover above them
      {
        myDist=player_sprite_center()
        myDist=round(myDist/40)
        if myDist>5 {myDist=5}
        else if myDist<3 {myDist=3}
        maxSpeed=myDist
        //Seek player
        if x>oPlayer1.x
        {
          if currHspd>-maxSpeed {currHspd-=0.15*gDeltaTime}
          else {currHspd=-maxSpeed}
        }
        else if x<oPlayer1.x
        {
          if currHspd<maxSpeed {currHspd+=0.15*gDeltaTime}
          else {currHspd=maxSpeed}
        }
        if y>returnPlayerYCenter()-64
        {
          if currVspd>-maxSpeed {currVspd-=0.15*gDeltaTime}
          else {currVspd=-maxSpeed}
        }
        else if y<returnPlayerYCenter()-64
        {
          if currVspd<maxSpeed {currVspd+=0.15*gDeltaTime}
          else {currVspd=maxSpeed}
        }
        //Keep within room
        if x<xCenter-roomSpan+16 {currHspd=3}
        else if x>xCenter+roomSpan-16 {currHspd=-3}
        if y-50<yGround-roomHeight {currVspd=3}
        else if y>yGround-2 {currVspd=-3}

        if sprite_index=sWarmasterC_JetB {x+=(xVel/1.5)*gDeltaTime} //Atk 2

        x+=currHspd*gDeltaTime; y+=currVspd*gDeltaTime

        if waitTime<waitDelay
        {
          if currVspd<-3.5 {sprite_index=sWarmasterC_HoverB}
          else if currVspd>2.5 {sprite_index=sWarmasterC_HoverC}
          else {sprite_index=sWarmasterC_HoverA}
        }
      }
    }

    if currentAttack=0 //-------------------- Choosing an action --------------------
    {
      if superChangeAtk<10
      {
        waitTime+=1*gDeltaTime
        if superChangeAtk=0 //Standard action
        {
          if waitTime>=waitDelay
          {
            event_user(6)
          }
        }
        else if superChangeAtk>=1 and superChangeAtk<=9 //Wait till other attacks are done
        {
          if waitTime>=waitDelay+5
          {
            bGravity=1; hoverMode=0
            atkNum=0
            waitTime=waitDelay
            prevShTime=shiftTime; prevShDmg=shiftDamage
            superAtkType=superChangeAtk
            previousForm=ATTACK_FORM
            bCanTakeDamage=0
            sprite_index=sWMA_Change; image_index=ATTACK_FORM-1
            playSound(global.snd_Beam,0,1,18000)
            playSound(global.snd_Charge,0,0.9,24000)
            superChangeAtk=10
          }
        }
      }
      else if superChangeAtk>=10 and superChangeAtk<=99 //Charge super attack
      {
        superChangeAtk+=1*gDeltaTime
        //if superChangeAtk>=11 and superChangeAtk<=20
        if superChangeAtk>10 and superChangeAtk<=20 //60fps change: covers every frame of ticks 11-20
        {
          if gDeltaDoTicks {var tAfterI;
          tAfterI=instance_create(x,y,oEnemyAfterImage)
          tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_white
          tAfterI.image_xscale=image_xscale*scaleForFacing; tAfterI.image_yscale=image_yscale; tAfterI.depth=24; tAfterI.imageFade=0.1
          tAfterI.xScaling=0.125; tAfterI.yScaling=0.125; tAfterI.xShift=0; tAfterI.yShift=0
          tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0}

          var tFFScl,tEffect;
          //for(i=0;i<2;i+=1)
          if gDeltaDoTicks for(i=0;i<2;i+=1) //60fps change: 2 fireflies per tick (was 2 per frame, 2x/4x as many at 60/120fps)
          {
            tFFScl=random(0.1)
            tEffect=instance_create(x-random_range(-12,12),y-random(48),oEffectB)
            tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
            tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
            tEffect.direction=random_range(70,110); tEffect.speed=random(1)+1; tEffect.friction=random(0.02)+0.02
            tEffect.fadeSpd=0.01; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          }
        }

        if superChangeAtk>=30
        {
          bCanTakeDamage=1
          superChangeAtk=100
          if superAtkType=1 //Sequence 1
          {
            ATTACK_FORM=3
            event_user(5)
            currentAttack=8
          }
          else if superAtkType=2 //Sequence 2
          {
            ATTACK_FORM=3
            event_user(5)
            currentAttack=9
          }
        }
      }
    }
    else //-------------------- Executing attack --------------------
    {
      actTime+=1*gDeltaTime
      event_user(ATTACK_FORM)
    }

    //-------------------- Collision --------------------
    if bGravity=1
    {
      yVel=scrGravAcc(yVel,0.5,1)
      if yVel>10 {yVel=10}
    }
    if hoverMode=0
    {
      if isCollisionBottom(1) //-------------------- Touch ground --------------------
      {
        if yVel>2
        {
          if sprite_index=sWarmasterA_GroundHit //Form 1, Atk 2
          {
            playSound(global.snd_HardHit1,0,0.97,1)
            playSound(global.snd_HardHit3,0,0.9,17000)
            var tAtk;
            tAtk=instance_create(x+(12*scaleForFacing),y,oWMA_SwordGround)
            tAtk.atkPower=atkPower; tAtk.warTarget=id; tAtk.image_xscale=scaleForFacing*1.5; tAtk.image_yscale=1.5
            if DIFFICULTY=1 {tAtk.type=0}
            else {tAtk.type=1}
            actTime=100
          }
          else if sprite_index=sWarmasterA_SwordRoll //Form 1, Atk 5
          {
            playSound(global.snd_HardHit1,0,0.97,1)
            playSound(global.snd_HardHit3,0,0.9,17000)
            y=yGround
            sprite_index=sWarmasterA_SwingAStrike
            with oWMA_SwordRoll {instance_destroy()}
            var tAtk;
            tAtk=instance_create(x,yGround,oWMA_BombExpWave)
            tAtk.atkPower=atkPower; tAtk.image_xscale=2; tAtk.image_yscale=2
            actTime=100
          }
          else if sprite_index=sWarmasterB_HitGroundB //Form 2, Atk 4
          {
            playSound(global.snd_HardHit1,0,0.97,32000)
            playSound(global.snd_Flame1,0,0.95,34000)
            image_index=1
            var tAtk;
            tAtk=instance_create(x,y,oWMB_FirePillar); tAtk.atkPower=atkPower
            tAtk=instance_create(x+16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"
            tAtk=instance_create(x-16,y,oWMB_FireWave); tAtk.atkPower=atkPower; tAtk.damageType="EXPLOSION"; tAtk.image_xscale=-1
            actTime=200
          }
          else if sprite_index=sWarmasterC_SpearDown //Form 3, Atk 4
          {
            playSound(global.snd_HardHit1,0,0.97,1)
            playSound(global.snd_HardHit3,0,0.9,17000)
            var tAtk;
            tAtk=instance_create(x+(12*scaleForFacing),y,oWMA_SwordGround)
            tAtk.atkPower=atkPower; tAtk.warTarget=id; tAtk.image_xscale=scaleForFacing*1.5; tAtk.image_yscale=1.5
            tAtk.image_blend=c_blue; tAtk.damageType="ELEMENTAL"
            if DIFFICULTY=1 {tAtk.type=0}
            else {tAtk.type=1}
            actTime=100
          }
          else if sprite_index=sWarmasterD_FastDash //Form 4, Atk 5
          {
            playSound(global.snd_HardHit1,0,0.97,1)
            playSound(global.snd_HardHit3,0,0.9,17000)
            var tAtk;
            tAtk=instance_create(x,yGround,oWMD_TornadoB); tAtk.atkPower=atkPower
            actTime=100
          }
          else
          {
            if ATTACK_FORM=1 {sprite_index=sWarmasterA_Idle}
            else if ATTACK_FORM=2 {sprite_index=sWarmasterB_Idle}
            else if ATTACK_FORM=3 {sprite_index=sWarmasterC_Idle}
            else if ATTACK_FORM=4 {sprite_index=sWarmasterD_Idle}
          }
          xVel=0
        }
        if ATTACK_FORM!=3 {bGoombaStomp=0}
        yVel=0
      }
      if isCollisionTop(1) //-------------------- Touch ceiling --------------------
      {
        if sprite_index=sWarmasterB_ZipUpward //Form 2, Atk 4
        {
          playSound(global.snd_Slam,0,0.88,28000)
          playSound(global.snd_HardHit3,0,0.91,26000)
          sprite_index=sWarmasterB_Hang
          yVel=0
          bGravity=0
          var tAtk,tXFireVel,tXOtherVel;
          tXOtherVel=-2
          if DIFFICULTY=1
          {
            tXFireVel=-4
            for(i=0;i<3;i+=1)
            {
              tAtk=instance_create(x,yGround-roomHeight,oGravPassBullet)
              tAtk.sprite_index=sWarmasterB_AtkFireballB; tAtk.atkPower=atkPower; tAtk.grav=0.3; tAtk.xVel=tXFireVel; tAtk.yVel=3
              tXFireVel+=4
            }
          }
          else
          {
            tXFireVel=-6
            for(i=0;i<5;i+=1)
            {
              tAtk=instance_create(x,yGround-roomHeight,oGravPassBullet)
              tAtk.sprite_index=sWarmasterB_AtkFireballB; tAtk.atkPower=atkPower; tAtk.grav=0.3; tAtk.xVel=tXFireVel; tAtk.yVel=3
              tXFireVel+=3
            }
          }
          for(i=0;i<2;i+=1)
          {
            tAtk=instance_create(x,yGround-roomHeight,oGravPassBullet)
            tAtk.sprite_index=sWarmasterB_AtkFireballB; tAtk.atkPower=atkPower; tAtk.grav=0.25; tAtk.xVel=tXOtherVel; tAtk.yVel=1
            tXOtherVel+=4
          }
          actTime=100
        }
      }
      if sprite_index!=sWarmasterA_WallGrabGun
      {
        if isCollisionLeft(1) //-------------------- Left wall --------------------
        {
          if sprite_index=sWarmasterA_Dashing {xVel=dashAcc}
          else if sprite_index=sWarmasterD_Dashing or sprite_index=sWarmasterD_FastDash {xVel=fastDashJumpAcc}
          else {xVel=runAcc}

          if sprite_index=sWarmasterA_JumpUp and currentAttack=6 //Form 1, Atk 6
          {
            sprite_index=sWarmasterA_WallGrabGun
            xVel=0; yVel=0
            bGravity=0
            actTime=100
          }
          else if sprite_index=sWarmasterB_Dashing //Form 2, Atk 5
          {
            if actTime<=100
            {
              playSound(global.snd_HardHit3,0,0.91,17000)
              xVel=0
              actTime=100
            }
          }
          else {image_xscale=1.25}
        }
        if isCollisionRight(1) //-------------------- Right wall --------------------
        {
          if sprite_index=sWarmasterA_Dashing {xVel=-dashAcc}
          else if sprite_index=sWarmasterD_Dashing or sprite_index=sWarmasterD_FastDash {xVel=-fastDashJumpAcc}
          else {xVel=-runAcc}

          if sprite_index=sWarmasterA_JumpUp and currentAttack=6 //Form 1, Atk 6
          {
            sprite_index=sWarmasterA_WallGrabGun
            xVel=0; yVel=0
            bGravity=0
            actTime=100
          }
          else if sprite_index=sWarmasterB_Dashing //Form 2, Atk 5
          {
            if actTime<=100
            {
              playSound(global.snd_HardHit3,0,0.91,17000)
              xVel=0
              actTime=100
            }
          }
          else {image_xscale=-1.25}
        }
      }
      if isCollisionSolid() {y-=2}
      moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
    }

    if backGroundFlash>=1 and backGroundFlash<=99 //Normal background flash
    {
      backGroundFlash+=1*gDeltaTime
      //if backGroundFlash>=2 and backGroundFlash<=24
      if backGroundFlash>1 and backGroundFlash<=24 //60fps change: covers every frame of ticks 2-24
      {
        //if backGroundFlash mod 3=0 {background_blend[0]=make_color_rgb(255,128,128)}
        if ceil(backGroundFlash) mod 3=0 {background_blend[0]=make_color_rgb(255,128,128)} //60fps change: ceil gives the tick number, so the red lasts the whole tick (it was only the last frame of it, a shorter, fainter flash at 60/120fps)
        else {background_blend[0]=c_white}
      }
      //else if backGroundFlash>=25 and backGroundFlash<=50
      else if backGroundFlash>24 and backGroundFlash<=50 //60fps change: covers every frame of ticks 25-50
      {
        //if backGroundFlash mod 5=0 {background_blend[0]=make_color_rgb(255,128,128)}
        if ceil(backGroundFlash) mod 5=0 {background_blend[0]=make_color_rgb(255,128,128)} //60fps change: see above
        else {background_blend[0]=c_white}
      }
      //else if backGroundFlash>=51
      else if backGroundFlash>50 //60fps change: ends on the first frame of tick 51
      {
        background_blend[0]=c_white
        backGroundFlash=0
      }
    }
    if backGroundFlash>=101 and backGroundFlash<=199 //Gray background flash
    {
      backGroundFlash+=1*gDeltaTime
      //if backGroundFlash>=102 and backGroundFlash<=124
      if backGroundFlash>101 and backGroundFlash<=124 //60fps change: covers every frame of ticks 102-124
      {
        //if backGroundFlash mod 3=0 {background_blend[0]=make_color_rgb(120,120,120)}
        if ceil(backGroundFlash) mod 3=0 {background_blend[0]=make_color_rgb(120,120,120)} //60fps change: ceil gives the tick number, so the flash lasts the whole tick
        else {background_blend[0]=make_color_rgb(50,50,50)}
      }
      //else if backGroundFlash>=125 and backGroundFlash<=150
      else if backGroundFlash>124 and backGroundFlash<=150 //60fps change: covers every frame of ticks 125-150
      {
        //if backGroundFlash mod 5=0 {background_blend[0]=make_color_rgb(120,120,120)}
        if ceil(backGroundFlash) mod 5=0 {background_blend[0]=make_color_rgb(120,120,120)} //60fps change: see above
        else {background_blend[0]=make_color_rgb(30,30,30)}
      }
      //else if backGroundFlash>=151
      else if backGroundFlash>150 //60fps change: ends on the first frame of tick 151
      {
        background_blend[0]=make_color_rgb(30,30,30)
        backGroundFlash=0
      }
    }

    //-------------------- Boss Difficulty Curve --------------------
    /*
    --Variable Name: Start value -> End value
    --waitDelay: 60 -> 26
    --atkMax: 2 -> 3
    --orbitNum: 6 -> 10
    --ATTACK_SPEED: 1 -> 3
    --DIFFICULTY: 1 -> 3
    */
    if lifePercent<=0.9 and lifePercent>=0.81 and bossProgress=0
    {
      waitDelay-=3
      if room!=rBT_WarmasterB {backGroundFlash=1}
      bossProgress+=1
    }
    else if lifePercent<=0.8 and lifePercent>=0.71 and bossProgress=1
    {
      waitDelay-=3
      orbitNum+=1
      bChangeSpeed=1
      if room!=rBT_WarmasterB {backGroundFlash=1}
      bossProgress+=1
    }
    else if lifePercent<=0.7 and lifePercent>=0.61 and bossProgress=2
    {
      waitDelay-=4
      bChangeDifficulty=1
      shiftType=1
      superChangeAtk=1
      if room!=rBT_WarmasterB {backGroundFlash=1}
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.51 and bossProgress=3
    {
      waitDelay-=3
      orbitNum+=1
      atkMax+=1
      if room!=rBT_WarmasterB {backGroundFlash=1}
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.41 and bossProgress=4
    {
      waitDelay-=3
      bChangeSpeed=1
      if room!=rBT_WarmasterB {backGroundFlash=1}
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.31 and bossProgress=5
    {
      waitDelay-=4
      orbitNum+=1
      if room!=rBT_WarmasterB {backGroundFlash=1}
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0.21 and bossProgress=6
    {
      waitDelay-=3
      shiftType=2
      bChangeDifficulty=1
      superChangeAtk=2
      if room!=rBT_WarmasterB {backGroundFlash=101}
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0.11 and bossProgress=7
    {
      waitDelay-=8
      orbitNum+=1
      if room!=rBT_WarmasterB {backGroundFlash=101}
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=8
    {
      waitDelay-=3
      if room!=rBT_WarmasterB {backGroundFlash=101}
      bossProgress+=1
    }
  }
  enemyStepEvent()
}

if life<=0 //-------------------- Defeat animation --------------------
{
  if global.alterEquip=1
  {
      tCurseCheck=0
      for (i=0; i<3; i+=1)
      {
          if global.equipJerry[i]=10 {tCurseCheck+=1}
          else if global.equipJerry[i]=11 {tCurseCheck+=1}
          else if global.equipJerry[i]=12 {tCurseCheck+=1}
          
          if global.equipClaire[i]=10 {tCurseCheck+=1}
          else if global.equipClaire[i]=11 {tCurseCheck+=1}
          else if global.equipClaire[i]=12 {tCurseCheck+=1}
      }
      
      if tCurseCheck=3
      {
          var tCheckAchieve;
          tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,15)
          if tCheckAchieve="0"
          {
            var tAchievement;
            tAchievement=instance_create(0,0,oAchievementNoticeSS)
            tAchievement.myAchievement="Incredibler"; tAchievement.checkNum=15
            deathAnim-=30
            global.pLife=global.pMaxLife
          }
      }
  }
  if birdKill=1
  {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,17)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNoticeSS)
        tAchievement.myAchievement="Windward Birds"; tAchievement.checkNum=17
        deathAnim-=30
        global.pLife=global.pMaxLife
      }
  }
  deathAnim+=1*gDeltaTime
  if room!=rBT_WarmasterB
  {
    if deathAnim=1*gDeltaTime
    {
      if global.bBossGallery=1
      {
        if global.activeCharacter=2
        {
          global.levelTimeSecond=2222222
        }
        bossRoomTally(59)
        global.newMapX=1496; global.newMapY=224; room_goto(rBossGallery)
      }
      else if global.inBossChallenge
      {
        bossRoomTally(74)
        global.newMapX=0; global.newMapY=0; room_goto(rBT_Cousinoer5_BossHall2)
      }
      else
      {
        with oWarmasterB_MoltenRock {instance_destroy()}
        with oEProjectileBase {instance_destroy()}
        with oAttackBase {instance_destroy()}
        oEvCh20MainA.sceneProgress=1
      }
    }
  }
  else
  {
    if deathAnim=1
    {
      oWM_B_DmgZone.warmasterCheck+=1
    }
    y=-64
  }
}
correctSpeedDirection(self)
