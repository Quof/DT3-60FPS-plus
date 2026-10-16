//Evil Boss Gallery: Evil Death's step. Death's (oDeath's Step: his evil sprites, myHS for oDeathHitSpot), but while
//he's staggered (staggerTime) or doing an evil move (evgMove, user event 3) those take the duel's place, his flying
//scythes resting while he's staggered or vanished; his phases are his own; won, it's back to the evil gallery
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    myHS.bActive=true
    myHS.bShowHealthBar=true
    myHS.showBossHP=instance_create(0,0,oBossLifeDisplay)
    myHS.showBossHP.bossID=myHS.id
    myHS.showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and myHS.life>0
  {
    if superProg<=1
    {
      chkMove=point_distance(x,0,oPlayer1.x,0)
      if bossProgress=0 {distMax=68}
      else if bossProgress=1 {distMax=88}
      else if bossProgress=2 {distMax=114}
      else if bossProgress=3 {distMax=138}
      else {distMax=164}

      if staggerTime>0 //---------- STAGGERED ----------
      {
        staggerTime-=1*gDeltaTime
        xVel=0
        bCanDealDamage=false
        if gDeltaDoTicks and (floor(staggerTime) mod 6)=0
        {
          var tEffect;
          tEffect=instance_create(x-14+random(28),y-70-random(16),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.7; tEffect.image_blend=make_color_rgb(255,220,140)
          tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05
          tEffect.speed=1+random(1); tEffect.fadeSpd=0.03
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
        if staggerTime<=0
        {
          staggerTime=0
          sprite_index=sEvgDeathWalk
          bCanDealDamage=true
          if atkTime>=atkDelay {atkTime=0}
        }
      }
      else if evgMove>0 {event_user(3)} //---------- EVIL MOVES ----------
      else
      {
        //---------- MOVEMENT ----------
        if sprite_index=sEvgDeathWalk
        {
          if x>oPlayer1.x {image_xscale=-1}
          else {image_xscale=1}

          if chkMove<distMax-(distMax/6)
          {
            if image_xscale=1 {xVel=-moveSpd}
            else {xVel=moveSpd}
          }
          else if chkMove>distMax-(distMax/6) and chkMove<distMax {xVel=0}
          else if chkMove>distMax
          {
            if image_xscale=1 {xVel=moveSpd}
            else {xVel=-moveSpd}
          }
        }
        else
        {
          if sprite_index!=sEvgDeathJump and sprite_index!=sEvgDeathRoll
            xVel=0
        }

        //Jumping
        jumpTime+=1*gDeltaTime
        if chkMove>208 {jumpTime+=1*gDeltaTime}
        if jumpTime>=jumpDelay
        {
          if jumpTime<=jumpDelay+100
          {
            if specFSaTime<specFSaDelay and atkTime<atkDelay and shielding=0 //Update check/Jump Back
            {
              sprite_index=sEvgDeathJump
              y-=4
              yVel=-7
              if image_xscale=1
              {
                if chkMove>208 {xVel=4}
                else {xVel=-3}
              }
              else
              {
                if chkMove>208 {xVel=-4}
                else {xVel=3}
              }
              jumpTime=10000
            }
            else {jumpTime=jumpDelay-5}
          }

          if jumpTime>=10001 and jumpTime<=10999 //Dive roll
          {
            if yVel>=-2
            {
              sprite_index=sEvgDeathRoll
              var tDistSpin;
              tDistSpin=chkMove/16
              if tDistSpin>13 {tDistSpin=13}

              if x>oPlayer1.x {xVel=-tDistSpin;image_xscale=-1}
              else {xVel=tDistSpin;image_xscale=1}
              yVel=4
              jumpTime=11000
            }
          }
          if jumpTime>=11001 //Spin
          {
            if oGame.time mod (5/gDeltaTime)=0 {playSound(global.snd_DeathSlash,0,0.95,38000)}
            if xVel>0 {image_angle-=30*gDeltaTime}
            else {image_angle+=30*gDeltaTime}
          }
        }

        //---------- PENTAGRAM SHIELD ----------
        if shielding=0 and sprite_index=sEvgDeathWalk //Check updates
        {
          if instance_exists(oBelmontDagger)
          {
            var tPAtkDist;
            tPAtkDist=point_distance(x,0,oBelmontDagger.x,0)
            if tPAtkDist<80 and oBelmontDagger.y>yGround-48
            {
              if atkTime>atkDelay
              {
                atkSwingNum=0
                atkTime=atkDelay-5
                atkSwingTime=0
                atkSwingType=-1
                bSwing=0
              }
              shielding=1
              sprite_index=sEvgDeathBlock
              var newShield;
              newShield=instance_create(x+(24*image_xscale),y-24,oEvgPentagram)
              newShield.image_xscale=image_xscale
            }
          }
        }
        else if shielding=1 //Check shield status
        {
          if instance_exists(oBelmontDagger)
          {
            var tPAtkDist;
            tPAtkDist=point_distance(x,0,oBelmontDagger.x,0)
            if tPAtkDist>64 {shielding=2}
          }
          else {shielding=2}
        }
        else if shielding>=2
        {
          shielding+=1*gDeltaTime
          if shielding>=30
          {
            sprite_index=sEvgDeathWalk
            with (oEvgPentagram) {atkProg=10}
            shielding=0
          }
        }

        //---------- ATTACK: COMBO SWING ----------
        if atkProg=0 //3 Strike Combo
        {
          atkTime+=1*gDeltaTime
          if atkTime>=atkDelay
          {
            if atkTime<=atkDelay+100 //Check updates
            {
              if sprite_index=sEvgDeathWalk
              {
                if chkMove<distMax*1.5
                {
                  atkTime=10000
                  atkSwingType=1
                  currentAtkSet+=1
                  if currentAtkSet=1 {atkTypeSw[0]=0; atkTypeSw[1]=1; atkTypeSw[2]=2}
                  else if currentAtkSet=2 {atkTypeSw[0]=1; atkTypeSw[1]=2; atkTypeSw[2]=0}
                  else if currentAtkSet=3 {atkTypeSw[0]=2; atkTypeSw[1]=0; atkTypeSw[2]=1}
                  else if currentAtkSet=4 {atkTypeSw[0]=1; atkTypeSw[1]=1; atkTypeSw[2]=2}
                  else if currentAtkSet=5 {atkTypeSw[0]=0; atkTypeSw[1]=0; atkTypeSw[2]=1}
                  else if currentAtkSet=6 {atkTypeSw[0]=2; atkTypeSw[1]=1; atkTypeSw[2]=0; currentAtkSet=0}
                }
                else if chkMove>distMax*2.5
                {
                  atkTime=10000
                  atkSwingType=1
                  atkSwingNum=1
                  currentAtkSet+=1
                  if currentAtkSet=1 {atkTypeSw[0]=1; atkTypeSw[1]=0; atkTypeSw[2]=2}
                  else if currentAtkSet=2 {atkTypeSw[0]=0; atkTypeSw[1]=1; atkTypeSw[2]=2}
                  else if currentAtkSet=3 {atkTypeSw[0]=1; atkTypeSw[1]=0; atkTypeSw[2]=2}
                  else if currentAtkSet=4 {atkTypeSw[0]=0; atkTypeSw[1]=1; atkTypeSw[2]=2}
                  else if currentAtkSet=5 {atkTypeSw[0]=1; atkTypeSw[1]=0; atkTypeSw[2]=2}
                  else if currentAtkSet=6 {atkTypeSw[0]=0; atkTypeSw[1]=1; atkTypeSw[2]=2; currentAtkSet=0}
                }
                else {atkTime=atkDelay-5}
              }
              else {atkTime=atkDelay-5}
            }

            if atkTime>10000 and atkTime<=10100 //Swing
            {
              event_user(atkTypeSw[atkSwingNum])
              if atkSwingType=-1
              {
                atkSwingNum+=1
                if atkSwingNum=3
                {
                  atkSwingNum=0
                  atkTime=0
                }
                else
                {
                  atkSwingType=1
                  atkTime=10000
                }
              }
            }
          }
        }

        //---------- ATTACK: SPECIAL SCYTHE SPAWN ----------
        specFSaTime+=1*gDeltaTime
        if specFSaTime>=specFSaDelay
        {
          if specFSaTime<=specFSaDelay+100 //Check updates
          {
            if atkTime<atkDelay and jumpTime<jumpDelay and shielding=0
            {
              playSound(global.snd_FadeAway,0,0.96,17000)
              sprite_index=sEvgDeathDuck
              specFSaTime=10000
            }
            else {specFSaTime=specFSaDelay-5}
          }
          else if specFSaTime>=10001 and specFSaTime<=10024 and gDeltaDoTicks
          {
            for(i=0;i<8;i+=1)
            {
              tEffect=instance_create(x-20+random(40),y-random(3),oEffectB)
              tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8
              tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05
              tEffect.speed=1+random(2); tEffect.fadeSpd=0.02
              tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
            }
          }
          else if specFSaTime=10025 //End attack
          {
            sprite_index=sEvgDeathWalk
            specFSaTime=0
            specSpawnProg=1
          }
        }

        //---------- EVIL MOVES: one every evgSpecDelay ticks while he's free, in his phase's order ----------
        evgSpecTime+=1*gDeltaTime
        if evgSpecTime>=evgSpecDelay
        {
          if sprite_index=sEvgDeathWalk and atkTime<atkDelay and jumpTime<jumpDelay and shielding=0 and specFSaTime<specFSaDelay and specSpawnProg=0
          {
            var tPat;
            tPat=evgSpecPat[min(bossProgress,5)]
            if evgSpecPos>=string_length(tPat) {evgSpecPos=0}
            evgMove=real(string_char_at(tPat,evgSpecPos+1))
            evgSpecPos+=1
            evgSpecTime=0
            evgStage=0
            evgT=0
            xVel=0
          }
          else {evgSpecTime=evgSpecDelay-5}
        }
      }

      if instance_exists(oDeathPentagramShield)
      {
        resType[0]=1
        myHS.resType[0]=1
      }
      else
      {
        resType[0]=3
        myHS.resType[0]=3
      }

      if staggerTime<=0 and evgMove!=2
      {
        //---------- ATTACK: FLYING SCYTHE ----------
        flyScyTime+=1*gDeltaTime
        if flyScyTime>=flyScyDelay
        {
          var tAtkScythe,tScyY;
          tScyY=96+(bossProgress*12)
          tAtkScythe=instance_create(scythePos,tScyY,oDeathFlyingScythe)
          tAtkScythe.sprite_index=sEvgDeathSpinScythe
          tAtkScythe.atkPower=atkPower
          tAtkScythe.bulletSpeed=2.5
          tAtkScythe._direction=point_direction(scythePos,tScyY,oPlayer1.x,returnPlayerYCenter())
          scythePos+=scytheSpacing
          if scythePos=96+(scytheSpacing*7) {scythePos=96}
          flyScyTime=0
        }

        if specSpawnProg>=1 //Spawn special attack scythes
        {
          specSpawnProg+=1*gDeltaTime
          if specSpawnProg=2
          {
            if random(10)>6
            {
              var newMessage;
              newMessage=instance_create(x-46,y-114,oEnemyChat)
              newMessage.enemyMessage="Perfect night for a curse."
            }
            specSpawnProg=1000+(specFSaProg*1000)
            specFSaProg+=1
            if specFSaProg=1 //Life
            {
              scyPX=70; scyPY=64
            }
            else if specFSaProg=2 //Right
            {
              scyPX=576; scyPY=64
            }
            else if specFSaProg=3 //Top
            {
              scyPX=96; scyPY=0
              specFSaProg=0
            }
          }
          else if specSpawnProg>=1000 and specSpawnProg<=1999 //Left side
          {
            if specSpawnProg mod 4=0
            {
              var tAtkScythe;
              tAtkScythe=instance_create(scyPX,scyPY,oDeathFlyingScythe)
              tAtkScythe.sprite_index=sEvgDeathSpinScythe
              tAtkScythe.atkPower=atkPower
              tAtkScythe.bulletSpeed=2.5
              tAtkScythe._direction=point_direction(scyPX,scyPY,oPlayer1.x,returnPlayerYCenter())
              scyPY+=48
              specSpawnSeq+=1
            }
            if specSpawnSeq=6 {specSpawnProg=10000}
          }
          else if specSpawnProg>=2000 and specSpawnProg<=2999 //Right side
          {
            if specSpawnProg mod 4=0
            {
              var tAtkScythe;
              tAtkScythe=instance_create(scyPX,scyPY,oDeathFlyingScythe)
              tAtkScythe.sprite_index=sEvgDeathSpinScythe
              tAtkScythe.atkPower=atkPower
              tAtkScythe.bulletSpeed=2.5
              tAtkScythe._direction=point_direction(scyPX,scyPY,oPlayer1.x,returnPlayerYCenter())
              scyPY+=48
              specSpawnSeq+=1
            }
            if specSpawnSeq=6 {specSpawnProg=10000}
          }
          else if specSpawnProg>=3000 and specSpawnProg<=3999 //Top side
          {
            if specSpawnProg mod 4=0
            {
              var tAtkScythe;
              tAtkScythe=instance_create(scyPX,100,oDeathFlyingScythe)
              tAtkScythe.sprite_index=sEvgDeathSpinScythe
              tAtkScythe.atkPower=atkPower; tAtkScythe.bulletSpeed=2.5
              tAtkScythe._direction=point_direction(scyPX,100,oPlayer1.x,returnPlayerYCenter())
              scyPX+=scytheSpacing
              specSpawnSeq+=1
            }
            if specSpawnSeq=6 {specSpawnProg=10000}
          }

          if specSpawnProg>=10000 //End attack
          {
            specSpawnSeq=0
            specSpawnProg=0
          }
        }
      }
    }

    //---------- SUPER ATTACK: DEATH'S WRATH ----------
    if superProg=1 //Check updates
    {
      if sprite_index=sEvgDeathWalk and specFSaTime<specFSaDelay and jumpTime<jumpDelay and atkTime<atkDelay and shielding=0 and evgMove=0 and staggerTime<=0
      {
        xVel=0;yVel=0
        sprite_index=sEvgDeathJump
        superProg+=1
      }
    }
    else if superProg=2 //Fly up
    {
      y-=8*gDeltaTime
      if y<=-8
      {
        x=304; y=-8
        sprite_index=sEvgDeathStandBack
        myHS.bCanTakeDamage=false
        bCanDealDamage=false
        if specFSaTime>=specFSaDelay {specFSaTime=specFSaDelay-90}
        superProg+=1
      }
    }
    else if superProg=3 //Wait and fly down
    {
      superTime+=1*gDeltaTime
      if superTime>=15
      {
        y+=4*gDeltaTime
        if y>=224 {superTime=0; superProg+=1}
      }
    }
    else if superProg=4
    {
      superTime+=1*gDeltaTime
      if superTime mod superScyTime=0 and superTime>=1
      {
        playSound(global.snd_OrbThrow,0,0.95,40000)
        var tAtkScythe;
        tAtkScythe=instance_create(x,y,oDeathFlyingScythe)
        tAtkScythe.sprite_index=sEvgDeathSpinScythe
        tAtkScythe.x=x+lengthdir_x(superScyDist,superScyDir); tAtkScythe.y=y+lengthdir_y(superScyDist,superScyDir)
        tAtkScythe.atkPower=atkPower; tAtkScythe.bulletSpeed=superScySpd
        tAtkScythe._direction=point_direction(x+lengthdir_x(superScyDist,superScyDir),y+lengthdir_y(superScyDist,superScyDir),oPlayer1.x,oPlayer1.y-26)
        superScyDir+=superScySpac
      }

      if superScyNum=0 //First Circle
      {
        if superScyDir>=360
        {
          superTime=-30
          superScyTime=10
          superScySpd=8
          superScySpac=22
          superScyDir=0
          superScyNum+=1
        }
      }
      else if superScyNum=1 //Fast Scythe Circle
      {
        if superScyDir>=540
        {
          superTime=-45
          superScyTime=1
          superScyDist=120
          superScySpd=4
          superScySpac=14
          superScyDir=0
          superScyNum+=1
        }
      }
      else if superScyNum=2 //Fast Spawn Circle
      {
        if superScyDir>=360
        {
          superTime=-15
          superScyDir=0
          superScyNum+=1
        }
      }
      else if superScyNum=3 //End
      {
        if superScyDir>=360 {superProg+=1}
      }
    }
    else if superProg=5 //End super attack
    {
      y-=8*gDeltaTime
      if y<=-64
      {
        sprite_index=sEvgDeathRoll
        myHS.bCanTakeDamage=true
        bCanDealDamage=true
        yVel=1
        jumpTime=11000
        superProg=0
      }
    }

    if superProg<=1
      yVel=scrGravAcc(yVel,0.2,1)

    if isCollisionBottom(1)
    {
      if jumpTime>=11000
      {
        jumpTime=0
        xVel=0
        if atkTime<10000 {sprite_index=sEvgDeathWalk}
        image_angle=0
      }
      yVel=0
    }
    if isCollisionLeft(1)
    {
      x+=2
      xVel*=-1
    }
    if isCollisionRight(1)
    {
      x-=2
      xVel*=-1
    }
    if isCollisionSolid()
      y-=2
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)

    //---------- Boss Difficulty Curve (his own: evil moves sooner and bigger as he goes) ----------
    if myHS.lifePercent<=0.85 and bossProgress=0
    {
      jumpDelay-=4
      atkDelay-=1
      atkSwingScale+=0.1
      spinSizeScale+=0.125
      forwardSizeScale+=0.2
      upwardSizeScale+=0.125
      flyScyDelay-=5
      specFSaDelay-=15
      evgSpecDelay=400
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.72 and bossProgress=1
    {
      moveSpd+=0.25
      jumpDelay-=4
      atkDelay-=2
      atkSwingScale+=0.1
      spinSizeScale+=0.125
      forwardSizeScale+=0.2
      upwardSizeScale+=0.125
      flyScyDelay-=5
      specFSaDelay-=15
      evgSpecDelay=380
      sickleNum=7
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.65 and bossProgress=2
    {
      superProg=1
      evgSpecDelay=360
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.5 and bossProgress=3
    {
      jumpDelay-=4
      atkDelay-=1
      atkSwingScale+=0.1
      spinSizeScale+=0.125
      forwardSizeScale+=0.2
      upwardSizeScale+=0.125
      flyScyDelay-=5
      specFSaDelay-=15
      evgSpecDelay=330
      sickleNum=8
      sickleGap=12
      bossProgress+=1
    }
    else if myHS.lifePercent<=0.25 and bossProgress=4 //his last stand
    {
      moveSpd+=0.25
      jumpDelay-=4
      atkDelay-=1
      spinSizeScale+=0.125
      forwardSizeScale+=0.2
      upwardSizeScale+=0.125
      flyScyDelay-=10
      specFSaDelay-=15
      evgSpecDelay=300
      sickleGap=11
      bossProgress+=1
      playSound(global.snd_DemonLaugh,0,0.9,1)
      var newMessage;
      newMessage=instance_create(x-46,y-114,oEnemyChat)
      newMessage.enemyMessage="Enough. Your soul is mine."
    }
  }
  else if myHS.life<=0 //Defeat animation (Death's), then back to the evil gallery at his door
  {
    if deathAnim == 0 {deathAnim = 1-gDeltaTime}; deathAnim+=1*gDeltaTime
    if deathAnim=1
    {
      depth=26
      image_angle=0
      fadeA=1
      staggerTime=0
      with oEProjectileBase {instance_destroy()}
      with oDeathPentagramShield {instance_destroy()}
      with oEvgSickle {instance_destroy()}
      with oEvgSiphon {instance_destroy()}
      sprite_index=sEvgDeathWalk; image_speed=0
      bCanDealDamage=false
    }
    else if deathAnim>1 and deathAnim<=55
    {
      if oGame.time mod (2/gDeltaTime)=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      evgTally(14)
      global.newMapX=2712; global.newMapY=1312; room_goto(rEvgGallery)
      deathAnim=-10000
    }
  }

  if sprite_index=sEvgDeathWalk
  {
    if xVel!=0 {image_index+=(0.06+(moveSpd/25))*gDeltaTime}
  }
  enemyStepEvent()
}
