#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-13,-56,13,-1)
image_speed=0

//Enemy base statistics
eName="Overdrive Ostrich"
eLevel=17
maxLife=2800
life=maxLife
atkPower=6
resType[0]=2
resType[1]=2
resType[2]=2
resType[5]=4
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
actionState=0
atkProg=0
bHover=0
turnTime=0
turnMax=40

downWaveAmt=6
forwardWaveAmt=4

specialAttack=0
specProg=0

//Misc Data
xCenter=432
yGround=272
roomSpan=336

runAcc=6
maxSlope=runAcc+1
maxDownSlope=runAcc

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    global.recBirdsSeen+=1
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=1; showBossHP.lifeFill=1000
    jeremyText="The oversized bird has a very set sequence of attacks. First he'll jump up and fire a bunch of energy based projectiles down. Once he lands, he'll run toward you, and when he gets past you, he'll turn around. From here, he'll hop low and fire more wave like attacks. I can't see to read into his behavior any further though, so you'll just have to observe for yourself."
    chaoText="Ooh, a Maverick encounter outside! I bet this guy can take advantage of looping routines to try and trick you, but if you put your mind to it, you can predict when he's going to do that. I advise using your dash when he's skipping around the field since he might hop into you during a standard jump. Oh yeah, I think during a Maverick's desperation attack, you can't dash through them."
    devText="This boss I wanted to make much harder than the original. I wanted a mix of traditional dodging and Jerry's dash mechanics for this encounter. Though despite making him a bit more difficult than the original, for the Mavericks, I wanted to keep them fairly close to how they were."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if specialAttack!=2
    {
      if sprite_index!=sOOstrich_Run and sprite_index!=sOOstrich_Skip and sprite_index!=sOOstrich_Jumping and sprite_index!=sOOstrich_Falling and sprite_index!=sOOstrich_WaveThrow
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
      }

      atkProg+=1
      if actionState=0 //----- Jump and shoot downward wave attack -----
      {
        if atkProg=1
        {
          if specialAttack=1
          {
            atkProg=0
            specialAttack=2
          }
        }

        if atkProg=10 {sprite_index=sOOstrich_JumpStance}
        else if atkProg=18
        {
          sprite_index=sOOstrich_Jumping
          y-=2
          yVel=-10
          xVel=6*image_xscale
        }
        else if atkProg>=19 and atkProg<=99
        {
          if yVel>=0
          {
            sprite_index=sOOstrich_WaveThrow
            xVel=0; yVel=0
            bHover=1
            atkProg=100
          }
        }
        else if atkProg=110
        {
          playSound(global.snd_WindBlow,0,1,31000)
          sprite_index=sOOstrich_Jumping
          var tWaveDir;
          tWaveDir=90-((downWaveAmt/2)*10)
          for(i=0;i<downWaveAmt;i+=1)
          {
            var tNewAttack;
            tNewAttack=instance_create(x,y-50,oPassBullet)
            tNewAttack.sprite_index=sOOstrichDownWave; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11
            tNewAttack.decayTime=-100; tNewAttack.direction=tWaveDir
            tWaveDir+=10
          }
          xAtkDrop=x
        }
        else if atkProg=115
        {
          sprite_index=sOOstrich_Falling
          xVel=6*image_xscale
          yVel=1
          bHover=0
        }
        else if atkProg=124
        {
          var tAtkSpc;
          tAtkSpc=xAtkDrop-(((downWaveAmt/2)*(72-downWaveAmt)))
          for(i=0;i<downWaveAmt;i+=1)
          {
            var tNewAttack;
            tNewAttack=instance_create(tAtkSpc,0,oPassBullet)
            tNewAttack.sprite_index=sOOstrichDownWave; tNewAttack.direction=270
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11; tNewAttack.decayTime=-100
            tAtkSpc+=72-downWaveAmt
          }
        }
        else if atkProg>=125
        {
          if x<0 {image_xscale=1; xVel=6}
          else if x>room_width {image_xscale=-1; xVel=-6}

          if isCollisionBottom(1)
          {
            sprite_index=sOOstrich_Ready
            image_index=0
            xVel=0; yVel=0
            atkProg=0
            actionState=1
          }
        }
      }
      else if actionState=1 //----- After landing, run toward player, turn around when necessary -----
      {
        if atkProg=6
        {
          turnTime=0
          sprite_index=sOOstrich_Ready
          image_index=1
        }
        else if atkProg=12
        {
          sprite_index=sOOstrich_Run
          image_speed=0.35
          xVel=runAcc*image_xscale
        }
        else if atkProg>=13
        {
          if checkFacing()=0 {turnTime+=1}
          if x<=-16 or x>=room_width+16 {xVel=1*image_xscale; turnTime=turnMax}

          if turnTime>=turnMax
          {
            sprite_index=sOOstrich_Idle
            image_speed=0

            var tSkidEffect;
            tSkidEffect=instance_create(x,y-3+random(4),oEffect)
            tSkidEffect.sprite_index=sMMSmokeCloud; tSkidEffect.image_blend=make_color_rgb(248,240,144)
            tSkidEffect.image_alpha=0.75; tSkidEffect.xSpd=(2+random(2))*-image_xscale; tSkidEffect.ySpd=-2-random(2)
            tSkidEffect.newBlend=-1; tSkidEffect.followID=-1; tSkidEffect.decay=-100

            if xVel>0 {xVel-=0.5}
            else if xVel<0 {xVel+=0.5}
            if abs(xVel)<0.6
            {
              if x<oPlayer1.x {image_xscale=1}
              else {image_xscale=-1}
              xVel=0; yVel=0
              atkProg=0
              actionState=2
            }
          }
        }
      }
      else if actionState=2 //----- Hop low and shoot forward wave attack -----
      {
        if atkProg=5 {sprite_index=sOOstrich_JumpStance}
        else if atkProg=13
        {
          sprite_index=sOOstrich_Jumping
          y-=2
          yVel=-7
          xVel=4*image_xscale
        }
        else if atkProg>=14 and atkProg<=99
        {
          if yVel>=0
          {
            sprite_index=sOOstrich_WaveThrow
            xVel=0; yVel=0
            bHover=1
            atkProg=100
          }
        }
        else if atkProg=110
        {
          playSound(global.snd_WindBlow,0,1,43000)
          sprite_index=sOOstrich_Jumping
          if bossProgress>=3
          {
            var tArcDir;
            tArcDir=60
            for(i=0;i<forwardWaveAmt;i+=1)
            {
              var tNewAttack;
              tNewAttack=instance_create(x,y-50,oPassArcBullet)
              tNewAttack.sprite_index=sOOstrichForwardWave; tNewAttack.direction=tArcDir
              tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11; tNewAttack.decayTime=90
              tNewAttack.falloff=0.35+(forwardWaveAmt/20); tNewAttack.arcAmt=-7.75-(forwardWaveAmt/10)
              tArcDir-=10
            }

            tArcDir=120
            for(i=0;i<forwardWaveAmt;i+=1)
            {
              var tNewAttack;
              tNewAttack=instance_create(x,y-50,oPassArcBullet)
              tNewAttack.sprite_index=sOOstrichForwardWave; tNewAttack.direction=tArcDir
              tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11; tNewAttack.decayTime=90
              tNewAttack.falloff=0.35+(forwardWaveAmt/20); tNewAttack.arcAmt=7.75+(forwardWaveAmt/10)
              tNewAttack.image_xscale=-1
              tArcDir+=10
            }
          }
          else
          {
            var tArcDir;
            if image_xscale=1 {tArcDir=60}
            else {tArcDir=120}

            for(i=0;i<forwardWaveAmt;i+=1)
            {
              var tNewAttack;
              tNewAttack=instance_create(x,y-50,oPassArcBullet)
              tNewAttack.sprite_index=sOOstrichForwardWave; tNewAttack.direction=tArcDir
              tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=11; tNewAttack.decayTime=90
              tNewAttack.falloff=0.35+(forwardWaveAmt/20); tNewAttack.image_xscale=image_xscale
              if image_xscale=1
              {
                tNewAttack.arcAmt=-7.75-(forwardWaveAmt/10)
                tArcDir-=10
              }
              else
              {
                tNewAttack.arcAmt=7.75+(forwardWaveAmt/10)
                tArcDir+=10
              }
            }
          }
        }
        else if atkProg=115
        {
          sprite_index=sOOstrich_Falling
          xVel=6*image_xscale
          yVel=1
          bHover=0
        }
        else if atkProg>=125
        {
          if x<0 {image_xscale=1; xVel=6}
          else if x>room_width {image_xscale=-1; xVel=-6}

          if isCollisionBottom(1)
          {
            sprite_index=sOOstrich_Ready
            image_index=0
            xVel=0; yVel=0
            atkProg=0
            actionState=3
          }
        }
      }
      else if actionState=3 //----- Skip and loop around, running after looping -----
      {
        if atkProg=4
        {
          turnTime=0
          sprite_index=sOOstrich_Ready
          image_index=1
        }
        else if atkProg=10
        {
          sprite_index=sOOstrich_Skip
          image_speed=0.35
          xVel=runAcc*image_xscale
        }
        else if atkProg>=11 and atkProg<=999
        {
          if x<-32
          {
            x=room_width+32; xVel=(runAcc*1.25)*image_xscale
            sprite_index=sOOstrich_Run; atkProg=1000
          }
          else if x>room_width+32
          {
            x=-32; xVel=(runAcc*1.25)*image_xscale
            sprite_index=sOOstrich_Run; atkProg=1000
          }

          if isCollisionBottom(1)
          {
            if bossProgress>=3
            {
              var tNewAttack;
              tNewAttack=instance_create(x,y-16,oOOstrichGravWave)
              tNewAttack.atkPower=atkPower; tNewAttack.yVel=-8
            }
            y-=2
            yVel=-4
          }
        }
        else if atkProg>1001
        {
          var tProgress,tDistCheck;
          tProgress=0
          tDistCheck=0
          tDistCheck=point_distance(x,0,oPlayer1.x,0)

          if image_xscale=1 and x>room_width/4 and tDistCheck<64 {tProgress=1}
          else if image_xscale=-1 and x<room_width-(room_width/4) and tDistCheck<64 {tProgress=1}

          if image_xscale=1 and x>room_width-(room_width/4) {tProgress=1}
          else if image_xscale=-1 and x<room_width/4 {tProgress=1}

          if tProgress=1
          {
            image_speed=0
            atkProg=0
            actionState=0
          }
        }
      }
    }
    else //Special attack
    {
      image_blend=make_color_rgb(random(255),random(255),random(255))
      specProg+=1
      if specProg=1 //Start
      {
        xVel=0
        sprite_index=sOOstrich_Idle
        ySpecSpd=11
        specGravWFreq=6
        maxSlope=ySpecSpd+1; maxDownSlope=ySpecSpd
        for(i=0;i<6;i+=1) {resType[i]=1}
        image_xscale=1
      }
      else if specProg=20 {sprite_index=sOOstrich_Ready; image_index=0}
      else if specProg=25 {image_index=1}
      else if specProg=30 //Begin running
      {
        sprite_index=sOOstrich_Run
        image_speed=0.35
        xVel=ySpecSpd
      }
      else if specProg>=270 and specProg<=499 //Turn around
      {
        if x>room_width/2 and x<room_width-(room_width/4)
        {
          sprite_index=sOOstrich_Idle
          image_speed=0
          image_index=0
          specProg=500
        }
      }
      else if specProg>=501 and specProg<=599 //Slow down
      {
        var tSkidEffect;
        tSkidEffect=instance_create(x,y-3+random(4),oEffect)
        tSkidEffect.sprite_index=sMMSmokeCloud; tSkidEffect.image_blend=make_color_rgb(248,240,144)
        tSkidEffect.image_alpha=0.75; tSkidEffect.xSpd=(2+random(2))*-image_xscale; tSkidEffect.ySpd=-2-random(2)
        tSkidEffect.newBlend=-1; tSkidEffect.followID=-1; tSkidEffect.decay=-100

        xVel-=0.5
        if xVel<=0.6 {xVel=0; image_xscale=-1; specProg=600}
      }
      else if specProg=610 {sprite_index=sOOstrich_Ready}
      else if specProg=615 {image_index=1}
      else if specProg=620 //Begin running other way
      {
        sprite_index=sOOstrich_Run
        image_speed=0.35
        ySpecSpd+=1
        xVel=-ySpecSpd
        specGravWFreq-=1
      }
      else if specProg>=800 and specProg<=899 //Check for proper area to slow down
      {
        if x>room_width/4 and x<room_width/2
        {
          sprite_index=sOOstrich_Idle
          image_speed=0
          image_index=0
          specProg=900
        }
      }
      else if specProg>=901 and specProg<=999 //Slow down last time
      {
        var tSkidEffect;
        tSkidEffect=instance_create(x,y-3+random(4),oEffect)
        tSkidEffect.sprite_index=sMMSmokeCloud; tSkidEffect.image_blend=make_color_rgb(248,240,144)
        tSkidEffect.image_alpha=0.75; tSkidEffect.xSpd=(2+random(2))*-image_xscale; tSkidEffect.ySpd=-2-random(2)
        tSkidEffect.newBlend=-1; tSkidEffect.followID=-1; tSkidEffect.decay=-100

        xVel+=0.5
        if xVel>=-0.6 {xVel=0; specProg=1000}
      }
      else if specProg>=1010
      {
        image_blend=c_white
        maxSlope=runAcc+1; maxDownSlope=runAcc
        for(i=0;i<6;i+=1) {resType[i]=3}
        resType[1]=2; resType[2]=2; resType[5]=4
        specialAttack=3
      }

      if specProg>=35 and specProg<=899 //Grav wave spawn
      {
        if specProg mod specGravWFreq=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y-16,oOOstrichGravWave)
          tNewAttack.atkPower=atkPower; tNewAttack.yVel=-8
        }
      }

      if x<-48 {x=room_width+32} //Loop around map
      else if x>room_width+48 {x=-32}
    }

    if !isCollisionBottom(1) and bHover=0
      yVel+=0.3
    if isCollisionSolid()
      y-=2

    enemySlopeMovement()

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.84 and lifePercent>=0.69 and bossProgress=0
    {
      runAcc+=1
      maxSlope=runAcc+1; maxDownSlope=runAcc
      turnMax-=4
      downWaveAmt+=1
      bossProgress+=1
    }
    else if lifePercent<=0.68 and lifePercent>=0.53 and bossProgress=1
    {
      runAcc+=1
      maxSlope=runAcc+1; maxDownSlope=runAcc
      turnMax-=4
      downWaveAmt+=1
      forwardWaveAmt+=1
      bossProgress+=1
    }
    else if lifePercent<=0.52 and lifePercent>=0.37 and bossProgress=2
    {
      runAcc+=2
      maxSlope=runAcc+1; maxDownSlope=runAcc
      turnMax-=4
      downWaveAmt+=2
      forwardWaveAmt+=1
      specialAttack=1
      bossProgress+=1
    }
    else if lifePercent<=0.36 and lifePercent>=0.21 and bossProgress=3
    {
      runAcc+=0.5
      maxSlope=runAcc+1; maxDownSlope=runAcc
      turnMax-=4
      downWaveAmt+=1
      forwardWaveAmt+=1
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      runAcc+=0.5
      maxSlope=runAcc+1; maxDownSlope=runAcc
      turnMax-=4
      downWaveAmt+=1
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sOOstrich_Defeat
      with oEProjectileBase {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 9=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 3=0
      {
        var tEffect;
        tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(abs(sprite_height)),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      if global.bBossGallery=1
      {
        bossRoomTally(19)
        global.newMapX=1960; global.newMapY=1024; room_goto(rBossGallery)
      }
      else {instance_destroy()}
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if specialAttack=2 {redDmgHit(0)}
else {event_inherited()}
