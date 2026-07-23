#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
//Enemy base statistics
eName="Final Nightmare"
eLevel=10
maxLife=10000
life=maxLife
atkPower=4
resType[1]=2
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

atkProg=0
//Attack Data
bombTime=0
bombDelay=180

spreadTime=0
spreadDelay=305
spreadCircle=0
atkCircSpd=1

//Arm Data
maxArms=7
armStart=0
dropAtk=370
dropMax=400

//Movement Data
moveSpd=1
moveTime=120
moveSeq=0
stopTime=150

maxSpd=5
maxYDist=104
pDistX=0
pDistOrigX=0

//Face Data
faceTopImage=1
faceImage=0
faceRotate=0
faceSpinCycle=0

//Eye Data
eyeState=0
eyeTime=0
faceAtkTime=0
atkFollowSpc=30
atkFallSpc=5
atkGravSpc=10
atkSpiralAmt=6

//Hand Data
handSpr=sShroudLArm
handLaserTime=0
handLaserDelay=150
laserXOffset=0
targetLaserTime=75
targetLaserDelay=90

//Misc Data
platformMove=0
transform=0
tranSeq=0
tranSize=0
bodySize=12
formSDir=0
formSDist=0
stepCount=0
colorPhase=35
colSeq=0
lifeRefill=0
sLordMoveTime=0
sLordMove=0

xCenter=560
yGround=288
roomSpan=176

deathAnim=0

jeremyText="It's hard to tell what this guy can do. Most of his data is encrypted really well. One thing I do know is he will change his attack pattern often. As for what, I'm not sure, I just know it's not going to be like Link's Awakening."
chaoText="The Nightmare escaped from the Vault and was hiding out here. Maybe we should have talked to him first and used the cutscene pause to our advantage."
devText="I had a hard time choosing between this guy and Vaati. The compromise of using one of Vaati's themes is what I went with. Plus the opening to it as the arms are extending went very well together. He goes really well with what you get at the end of these Nightmare Gates as well. The hardest part of designing this was the second phase. Deciding how big to actually make the opening and how long to allow it."
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
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if transform=0 or transform=1 //-------------------- PHASE 1 --------------------
    {
      //---------- ARM CONTROL ----------
      if armStart=0 //Create arms
      {
        for(i=0;i<maxArms;i+=1)
        {
          leftArm[i]=instance_create(x,y,oFNightmareSeg)
          leftArm[i].armSide=0; leftArm[i].segment=i
          leftArm[i].direction=190; leftArm[i].circleRad=10-(i/2)
          leftArm[i].type=0; leftArm[i].bEnd=0
          rightArm[i]=instance_create(x,y,oFNightmareSeg)
          rightArm[i].armSide=1; rightArm[i].segment=i
          rightArm[i].direction=350; rightArm[i].circleRad=10-(i/2)
          rightArm[i].type=0; rightArm[i].bEnd=0

          if i=maxArms-1
          {
            leftArm[i].bEnd=1
            rightArm[i].bEnd=1
          }
        }
        armStart+=1
      }
      else if armStart=1 //Check position
      {
        dropAtk+=1
        if leftArm[0].direction=180 and dropAtk>=dropMax
        {
          for(i=0;i<maxArms;i+=1)
          {
            leftArm[i].leftSpd=0
            rightArm[i].rightSpd=0
          }
          dropAtk=0
          armStart+=1
        }
      }
      else if armStart=2 //Slight wait 1 and extend arms
      {
        dropAtk+=1
        if dropAtk>=30
        {
          for(i=0;i<maxArms;i+=1)
          {
            leftArm[i].armDist+=2
            rightArm[i].armDist+=2
          }
          if leftArm[0].armDist=28 {dropAtk=0;armStart+=1}
        }
      }
      else if armStart=3 //Slight wait 2
      {
        dropAtk+=1
        if dropAtk>=30
        {
          playSound(global.snd_OrbThrow,0,1,1)
          dropAtk=0;armStart+=1
        }
      }
      else if armStart=4 //Drop down
      {
        if y>=yGround-48
        {
          dropAtk+=1
          if dropAtk>=15 {dropAtk=0;armStart+=1}
        }
        else {y+=4}
      }
      else if armStart=5 //Rise up and end
      {
        if y>yGround-128 {y-=2}
        if leftArm[0].armDist!=10
        {
          for(i=0;i<maxArms;i+=1)
          {
            leftArm[i].armDist-=1
            rightArm[i].armDist-=1
          }
        }

        if y=yGround-128 and leftArm[0].armDist=10 //end
        {
          for(i=0;i<maxArms;i+=1)
          {
            leftArm[i].leftSpd=1
            rightArm[i].rightSpd=1
          }
          armStart=1
        }
      }

      //---------- ATTACK: ARM BOMB ----------
      bombTime+=1
      if bombTime>=bombDelay
      {
        leftArm[maxArms-1].atkTime=1
        rightArm[maxArms-1].atkTime=1
        bombTime=0
      }

      //---------- ATTACK: SPREAD BOMB ----------
      spreadTime+=1
      if spreadTime>=spreadDelay
      {
        if spreadTime<=spreadDelay+100 //Check updates
        {
          spreadCircle=30
          spreadTime=10000
        }
        if spreadTime>=10030 and spreadTime<=10041
        {
          var tFire,tSprDir;
          if spreadTime mod 2=0 {tSprDir=0}
          else {tSprDir=22}

          if spreadTime mod 3=0
          {
            playSound(global.snd_Wave,0,0.94,33075)
            for(i=0;i<8;i+=1)
            {
              tFire=instance_create(x,y,oPassBullet)
              tFire.sprite_index=sFNBomb; tFire.atkPower=atkPower
              tFire.bulletSpeed=6; tFire.direction=tSprDir; tFire.decayTime=-100
              tSprDir+=360/8
            }
          }
        }
        else if spreadTime>=10042 {spreadTime=0}
      }
    }
    else if transform=3 //-------------------- PHASE 2 --------------------
    {
      faceTopImage=bCanTakeDamage
      if instance_exists(oLinkBomb)
      {
        if point_distance(x,y,oLinkBomb.x,oLinkBomb.y)<6 {oLinkBomb.x=x;oLinkBomb.y=y}
      }

      //---------- MOVEMENT ----------
      moveTime+=1
      if moveSeq=0 //Wait
      {
        if moveTime>=stopTime {bCanTakeDamage=0; moveTime=0; moveSeq+=1}
      }
      else if moveSeq=1 //Move left to left
      {
        x-=moveSpd
        if x<=464 {x=464; event_user(1); bCanTakeDamage=1; moveTime=0; moveSeq+=1}
      }
      else if moveSeq=2 //Wait
      {
        if moveTime>=stopTime {bCanTakeDamage=0; moveTime=0; moveSeq+=1}
      }
      else if moveSeq=3 //Move right to middle
      {
        x+=moveSpd
        if x>=560 {x=560; event_user(1); bCanTakeDamage=1; moveTime=0; moveSeq+=1}
      }
      else if moveSeq=4 //Wait
      {
        if moveTime>=stopTime {bCanTakeDamage=0; moveTime=0; moveSeq+=1}
      }
      else if moveSeq=5 //Move right to right
      {
        x+=moveSpd
        if x>=656 {x=656; event_user(1); bCanTakeDamage=1; moveTime=0; moveSeq+=1}
      }
      else if moveSeq=6 //Wait
      {
        if moveTime>=stopTime {bCanTakeDamage=0; moveTime=0; moveSeq+=1}
      }
      else if moveSeq=7 //Move left to middle
      {
        x-=moveSpd
        if x<=560 {x=560; event_user(1); bCanTakeDamage=1; moveTime=0; moveSeq=0}
      }
      //Rotate face
      event_user(0)
      //Attack
      event_user(2)

      collLeft.x=x-15; collLeft.y=y-10
      collRight.x=x+13; collRight.y=y-10
      collBottom.x=x-14; collBottom.y=y+10
      if faceTopImage=0 {collTop.x=x-15; collTop.y=y-10}
      else {collTop.x=x-15; collTop.y=y-1000}
    }
    else if transform=5 //-------------------- PHASE 3 --------------------
    {
      //---------- ARM CONTROL ----------
      if armStart=0 //Create arms
      {
        for(i=0;i<maxArms;i+=1)
        {
          leftArm[i]=instance_create(x,y,oFNightmareSeg)
          leftArm[i].armSide=0; leftArm[i].segment=i
          leftArm[i].direction=190; leftArm[i].circleRad=11-(i/2)
          leftArm[i].type=1; leftArm[i].bEnd=0
          rightArm[i]=instance_create(x,y,oFNightmareSeg)
          rightArm[i].armSide=1; rightArm[i].segment=i
          rightArm[i].direction=350; rightArm[i].circleRad=11-(i/2)
          rightArm[i].type=1; rightArm[i].bEnd=0

          if i=maxArms-1
          {
            leftArm[i].bEnd=1
            rightArm[i].bEnd=1
          }
        }
        armStart+=1
      }

      //---------- EYE CONTROL ----------
      eyeTime+=1
      if eyeState=0 {if eyeTime=70 {eyeTime=0;eyeState=1}}
      else if eyeState=1
      {
        if eyeTime=10 {faceImage+=1}
        else if eyeTime=20 {faceImage+=1; resType[1]=4; eyeState=2; eyeTime=0}
      }
      else if eyeState=2
      {
        if eyeTime=130 {faceImage-=1;resType[1]=1}
        else if eyeTime=140 {faceImage-=1}
        else if eyeTime=150 {eyeTime=0;eyeState=0}
      }

      //---------- MOVEMENT ----------
      if x<oPlayer1.x {if moveSpd<2 {moveSpd+=0.1}}
      else if x>oPlayer1.x {if moveSpd>-2 {moveSpd-=0.1}}
      x+=moveSpd

      //---------- ATTACK: TWIN BOMB ----------
      bombTime+=1
      if bombTime>=bombDelay
      {
        if bombTime<=bombDelay+100 //Check updates
        {
          var tAfterI;
          tAfterI=instance_create(x,y,oEnemyAfterImage)
          tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
          tAfterI.image_xscale=image_xscale; tAfterI.imageFade=0.05
          tAfterI.xScaling=0.075; tAfterI.yScaling=0.075; tAfterI.xShift=0; tAfterI.yShift=0
          tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
          bombTime=10000
        }
        if bombTime=10030
        {
          playSound(global.snd_Wave,0,0.95,12000)
          var tNewAtk;
          tNewAtk=instance_create(x-8,y-8,oFNBorderFollow)
          tNewAtk.atkPower=atkPower; tNewAtk.type=0
          tNewAtk=instance_create(x-8,y-8,oFNBorderFollow)
          tNewAtk.atkPower=atkPower; tNewAtk.type=1
          bombTime=0
        }
      }

      //---------- ATTACK: ROCK LASER ----------
      spreadTime+=1
      if spreadTime>=spreadDelay
      {
        if spreadTime<=spreadDelay+100 //Check updates
        {
          spreadCircle=30
          spreadTime=10000
          playSound(global.snd_OrbThrow,0,1,8000)
        }
        if spreadTime>=10121 and spreadTime<=10150
        {
          var tFire;
          tFire=instance_create(x,y,oPassBullet)
          tFire.sprite_index=sFNRock; tFire.atkPower=atkPower
          tFire.bulletSpeed=12; tFire.direction=270; tFire.decayTime=-100
        }
        else if spreadTime>=10162 {spreadTime=0}
      }
    }
    else if transform=7 //-------------------- PHASE 4 --------------------
    {
      faceImage+=0.1
      colSeq+=1
      if colSeq>=1 and colSeq<=50 {colorPhase+=1}
      else if colSeq>=51 and colSeq<=100
      {
        colorPhase-=1
        if colSeq=100 {colSeq=0}
      }
      baseColor=make_color_rgb(colorPhase,colorPhase,colorPhase)
      if bTakingDamage=0 {image_blend=baseColor}

      //---------- MOVEMENT ----------
      pDistOrigX=point_distance(x,0,oPlayer1.x,0)
      pDistX=pDistOrigX/25
      if x>oPlayer1.x //go left
      {
        if moveSpd>=0
        {
          moveSpd-=pDistX/5
          if pDistOrigX<16 and moveSpd<3 {moveSpd=0}
        }
        else {moveSpd-=pDistX/10}
      }
      else //go right
      {
        if moveSpd<=0
        {
          moveSpd+=pDistX/5
          if pDistOrigX<16 and moveSpd>-3 {moveSpd=0}
        }
        else {moveSpd+=pDistX/10}
      }

      if moveSpd>maxSpd {moveSpd=maxSpd}
      else if moveSpd<-maxSpd {moveSpd=-maxSpd}
      x+=moveSpd

      if y>oPlayer1.y+16 {y-=1}
      if y<oPlayer1.y-maxYDist {y+=1}

      //Bob up and down
      sLordMoveTime+=1
      if sLordMoveTime>=1 and sLordMoveTime<=21 {sLordMove+=0.04}
      else if sLordMoveTime>=22 and sLordMoveTime<=42 {sLordMove-=0.04}
      else if sLordMoveTime>=52 and sLordMoveTime<=72 {sLordMove-=0.04}
      else if sLordMoveTime>=73 and sLordMoveTime<=93 {sLordMove+=0.04}
      else if sLordMoveTime>=103 {sLordMoveTime=0}
      y+=sLordMove

      //---------- ATTACK: SKY LASER ----------
      spreadTime+=1
      if spreadTime>=spreadDelay and laserXOffset<140
      {
        newLaser=instance_create(xCenter-roomSpan+laserXOffset,yGround,oFNSkyLaser)
        newLaser.atkPower=floor(atkPower/2); newLaser.idleTime=10000; newLaser.bShake=0
        newLaser=instance_create(xCenter+roomSpan-laserXOffset,yGround,oFNSkyLaser)
        newLaser.atkPower=floor(atkPower/2); newLaser.idleTime=10000; newLaser.bShake=0
        laserXOffset+=20
        spreadTime=0
      }

      //---------- ATTACK: TARGET LASER ----------
      targetLaserTime+=1
      if targetLaserTime>=targetLaserDelay
      {
        newLaser=instance_create(oPlayer1.x,yGround,oFNSkyLaser)
        newLaser.atkPower=floor(atkPower/2); newLaser.idleTime=50; newLaser.bShake=1
        targetLaserTime=0
      }

      //---------- ATTACK: HAND LASER ----------
      if life<maxLife
      {
        handLaserTime+=1
        if handLaserTime>=handLaserDelay
        {
          if handLaserTime<=handLaserDelay+100 //Check updates
          {
            handSpr=sShroudLArmUp
            handLaserTime=10000
          }
          if handLaserTime=10040 //Create laser
          {
            handLaserL=instance_create(x+100,y-36,oFNHandLaser)
            handLaserL.atkPower=floor(atkPower/2); handLaserL.image_angle=270; handLaserL.image_yscale=5
            handLaserR=instance_create(x-100,y-36,oFNHandLaser)
            handLaserR.atkPower=floor(atkPower/2); handLaserR.image_angle=270; handLaserR.image_yscale=5
          }
          else if handLaserTime>=10041 //Update lasers (Forever)
          {
            if bossProgress=8 {handLaserTime=10050}

            handLaserL.x=x+100; handLaserL.y=y-36
            handLaserR.x=x-100; handLaserR.y=y-36

            var tEffect,i;
            for(i=0;i<2;i+=1)
            {
              tEffect=instance_create(x-100+(-8+random(16)),y-36+(-8+random(16)),oEffectB)
              tEffect.type=3; tEffect.sprite_index=sBelmontWepEffect; tEffect.image_speed=0.33
              tEffect.direction=random(360); tEffect.speed=random(0.5)+0.5
              tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.035
              tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
            }
            for(i=0;i<2;i+=1)
            {
              tEffect=instance_create(x+100+(-8+random(16)),y-36+(-8+random(16)),oEffectB)
              tEffect.type=3; tEffect.sprite_index=sBelmontWepEffect; tEffect.image_speed=0.33
              tEffect.direction=random(360); tEffect.speed=random(0.5)+0.5
              tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.035
              tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
            }
          }
        }
      }
    }

    //-------------------- TRANSFORM --------------------
    if transform=1 //To phase 2 check
    {
      if armStart=1 and spreadTime<spreadDelay
      {
        bCanTakeDamage=0
        for(i=0;i<maxArms;i+=1)
        {
          leftArm[i].armDist=10
          rightArm[i].armDist=10
        }
        bombTime=0
        spreadTime=0
        tranSize=12
        transform+=1
      }
    }
    else if transform=2 //To phase 2
    {
      if leftArm[0].armDist=0
      {
        tranSeq+=1
        if tranSeq=15
        {
          depth=9
          sprite_index=sFNFace
          resType[0]=1; resType[1]=1; resType[4]=4

          collLeft=instance_create(x-15,y-10,oScaledCollision)
          collLeft.image_xscale=2;collLeft.image_yscale=25
          collRight=instance_create(x+13,y-10,oScaledCollision)
          collRight.image_xscale=2;collRight.image_yscale=25
          collBottom=instance_create(x-15,y+10,oScaledCollision)
          collBottom.image_xscale=27;collBottom.image_yscale=5
          collTop=instance_create(x-15,y-10,oScaledCollision)
          collTop.image_xscale=29;collTop.image_yscale=5
        }
        else if tranSeq>=16
        {
          tranSize-=2
          if tranSize<=4
          {
            with oFNightmareSeg {instance_destroy()}
            tranSize=0
            tranSeq=0
            transform+=1
          }
        }
      }
      else
      {
        tranSize+=0.5
        for(i=0;i<maxArms;i+=1)
        {
          leftArm[i].armDist-=0.25
          rightArm[i].armDist-=0.25
        }
      }
    }
    else if transform=4 //To phase 3
    {
      tranSeq+=1
      if tranSeq>=1 and tranSeq<=100
      {
        if tranSeq=1 {resType[4]=1; bCanTakeDamage=0}
        if tranSeq<=60 {tranSize+=0.5}
      }
      else if tranSeq=101
      {
        sprite_index=sFNightmareEyes
        faceImage=0
        resType[0]=1; resType[1]=1; resType[4]=3
        with oScaledCollision {instance_destroy()}
      }
      else if tranSeq>=102
      {
        tranSize-=2
        if tranSize<=4
        {
          depth=25
          bombTime=0
          bombDelay=270
          spreadTime=0
          spreadDelay=330
          atkCircSpd=0.25
          moveSpd=0
          maxArms=11
          armStart=0
          tranSize=0
          tranSeq=0
          bCanTakeDamage=1
          transform+=1
        }
      }
    }
    else if transform=6 //To phase 4
    {
      tranSeq+=1
      if tranSeq>=1 and tranSeq<=30
      {
        for(i=0;i<maxArms;i+=1) //Bring arms in
        {
          leftArm[i].armDist-=1
          rightArm[i].armDist-=1
        }
        if leftArm[0].armDist<=1
        {
          bCanDealDamage=0; bCanTakeDamage=0
          resType[1]=1; resType[4]=1
          life=1250
          maxLife=5000
          lifeRefill=1
          with oFNightmareSeg {instance_destroy()}
          playSound(global.snd_PortalCreate,0,0.94,8000)
          tranSeq=30
        }
      }
      else if tranSeq>=31 and tranSeq<=210
      {
        if tranSeq<=210 {tranSize+=1}

        if x<xCenter {x+=1}
        else if x>xCenter {x-=1}
        if y<192 {y+=1}
      }
      else if tranSeq=261 //Change sprite to Shroud Lord
      {
        sprite_index=sShroudLHead
        image_speed=0.14
        baseColor=make_color_rgb(colorPhase,colorPhase,colorPhase)
        image_blend=baseColor
        faceImage=0
      }
      else if tranSeq>=262 and tranSeq<=999 //Bring black circle back in
      {
        tranSize-=3
        if tranSize<=3 {tranSeq=1000}
      }
      else if tranSeq=1001
      {
        msgCreate(0,0,"Jerry","No way! Jeremy!! ... THAT ISN'T EVEN RIGHT!!",0,1,oMessagePerson,0)
        newMessage.fadingTime=75
      }
      else if tranSeq=1075
      {
        msgCreate(0,0,"Nightmare","I know what you fear most.",8,1,oMessagePerson,0)
        newMessage.fadingTime=65
      }
      else if tranSeq>=1150 //To final phase
      {
        maxLife=3000; life=maxLife
        spreadTime=35; spreadDelay=40
        atkCircSpd=1
        moveSpd=0
        armStart=0
        tranSize=0; tranSeq=0
        bCanTakeDamage=1
        bossProgress=0
        transform+=1
      }
    }

    //-------------------- MOVE SIDE PLATFORMS --------------------
    if platformMove>=1 and platformMove<100 //Move platforms away
    {
      if platformMove=1
      {
        (196186).xVel=-1
        (196187).xVel=1
      }
      tile_layer_shift(1000001,-1,0)
      tile_layer_shift(1000002,1,0)
      platformMove+=1
      if platformMove=34
      {
        oMarioSpikeFloor.visible=1
        (196186).xVel=0
        (196187).xVel=0
        platformMove=100
      }
    }
    else if platformMove>=100 and platformMove<200 //Move spikes up
    {
      for(i=0;i<4;i+=1)
      {
        spikeAnnoy[i].y-=1
        if platformMove mod 3=0 //Spike smoke effect
        {
          var tEffect;
          tEffect=instance_create(spikeAnnoy[i].x-12+random(12),spikeAnnoy[i].y,oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
      }
      platformMove+=1
      if platformMove=96 {platformMove=200}
    }
    else if platformMove>=201 and platformMove<300 //Move platforms back in
    {
      if platformMove=201
      {
        for(i=0;i<4;i+=1)
        {
          var tEffect;
          tEffect=instance_create(spikeAnnoy[i].x-8,spikeAnnoy[i].y,oEffect)
          tEffect.sprite_index=sMMchargeComplete
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        with oMarioSpikeFloor {instance_destroy()}
        (196186).xVel=1
        (196187).xVel=-1
      }
      tile_layer_shift(1000001,1,0)
      tile_layer_shift(1000002,-1,0)
      platformMove+=1
      if platformMove=234
      {
        (196186).xVel=0
        (196187).xVel=0
        platformMove=300
      }
    }

    if lifeRefill=1 //Recharge life one time
    {
      life+=15
      if life>=maxLife
      {
        resType[0]=3; resType[1]=2; resType[4]=3
        life=maxLife
        lifeRefill=1000
      }
    }

    //---------- Boss Difficulty Curve ----------
    if transform>=0 and transform<=6
    {
      if lifePercent<=0.88 and lifePercent>=0.76 and bossProgress=0
      {
        dropMax-=45
        bombDelay-=15
        spreadDelay-=35
        bossProgress+=1
      }
      else if lifePercent<=0.75 and lifePercent>=0.63 and bossProgress=1 //Phase 2 start
      {
        transform+=1
        bossProgress+=1
      }
      else if lifePercent<=0.62 and lifePercent>=0.51 and bossProgress=2
      {
        moveSpd=2
        stopTime=135
        atkFollowSpc-=10
        atkFallSpc-=1
        atkGravSpc-=6
        atkSpiralAmt=8
        platformMove=1
        spikeAnnoy[0]=instance_create(480,room_height-12,oMarioSpikeFloor)
        spikeAnnoy[1]=instance_create(496,room_height-12,oMarioSpikeFloor)
        spikeAnnoy[2]=instance_create(608,room_height-12,oMarioSpikeFloor)
        spikeAnnoy[3]=instance_create(624,room_height-12,oMarioSpikeFloor)
        oMarioSpikeFloor.visible=0
        bossProgress+=1
      }
      else if lifePercent<=0.50 and lifePercent>=0.38 and bossProgress=3 //Phase 3 start
      {
        transform+=1
        platformMove=201
        bossProgress+=1
      }
      else if lifePercent<=0.37 and lifePercent>=0.26 and bossProgress=4
      {
        bombDelay-=15
        spreadDelay-=35
        bossProgress+=1
      }
      else if lifePercent<=0.25 and lifePercent>=0.13 and bossProgress=5 //Phase 4 start
      {
        transform+=1
        bossProgress+=1
      }
    }
    else if transform=7 //Phase 4 arc
    {
      if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0
      {

        bossProgress+=1
      }
      else if lifePercent<=0.5 and lifePercent>=0 and bossProgress=1
      {

        bossProgress+=1
      }
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      speed=0
      with oEProjectileBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(8)
        global.newMapX=1864; global.newMapY=1280; room_goto(rBossGallery)
      }
      else
      {
        oEvExGates.sceneProgress=1
        instance_destroy()
      }
    }
  }
  enemyStepEvent()
}
else {speed=0}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Phase 2 spin face image (spin duration)
if moveSeq mod 2!=0
{
  faceRotate+=1
  if faceRotate mod 5=0
  {
    if image_index=4
    {
      faceSpinCycle+=1
      if faceSpinCycle=4 {faceSpinCycle=0}
      image_index=faceSpinCycle
    }
    else {image_index=4}
  }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Phase 2 cycle face (End of spin)
faceAtkTime=1
faceImage+=1
if faceImage=4 {faceImage=0}
image_index=faceImage
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Phase 2 attacks
if faceAtkTime>0
{
  faceAtkTime+=1
  if faceImage=0 //Border Fire
  {
    if faceAtkTime<70
    {
      if faceAtkTime mod atkFollowSpc=0
      {
        playSound(global.snd_MarioCannon,0,0.95,15000)
        var tNewAtk;
        tNewAtk=instance_create(x-8,y-8,oFNBorderFollow)
        tNewAtk.atkPower=atkPower; tNewAtk.type=0
        tNewAtk=instance_create(x-8,y-8,oFNBorderFollow)
        tNewAtk.atkPower=atkPower; tNewAtk.type=1
      }
    }
    else {faceAtkTime=0}
  }
  else if faceImage=1 //Falling rocks
  {
    if faceAtkTime<80
    {
      if faceAtkTime mod atkFallSpc=0
      {
        playSound(global.snd_Earthquake,0,0.98,70000)
        var tNewAtk;
        tNewAtk=instance_create((xCenter-roomSpan)+random(roomSpan*2),yGround-240,oGravPassBullet)
        tNewAtk.sprite_index=sFNRock; tNewAtk.atkPower=atkPower
      }
    }
    else {faceAtkTime=0}
  }
  else if faceImage=2 //Spit gravity rocks
  {
    if faceAtkTime<90
    {
      if faceAtkTime mod atkGravSpc=0
      {
        playSound(global.snd_BombLaunch,0,0.91,37000)
        var tNewAtk;
        tNewAtk=instance_create(x,y-10,oGravPassBullet)
        tNewAtk.sprite_index=sFNRock; tNewAtk.atkPower=atkPower
        tNewAtk.xVel=random_range(-3,3); tNewAtk.yVel=-random_range(4,5)
      }
    }
    else {faceAtkTime=0}
  }
  else if faceImage=3 //dirSeg
  {
    if faceAtkTime=5
    {
      playSound(global.snd_FireLoop,0,0.95,1)
      var tDirSet;
      tDirSet=random(360)
      for(i=0;i<atkSpiralAmt;i+=1)
      {
        var tNewAtk;
        tNewAtk=instance_create(x,y,oFNSpiralAtk)
        tNewAtk.atkPower=atkPower; tNewAtk.dirSeg=tDirSet
        tDirSet+=360/atkSpiralAmt
      }
      faceAtkTime=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_black)
draw_set_alpha(image_alpha)
if sprite_index=sShroudLHead
{
  draw_sprite_ext(sShroudLBody,image_index,x,y-26,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(handSpr,faceImage,x+88,y-4,1,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(handSpr,faceImage,x-88,y-4,-1,image_yscale,image_angle,image_blend,image_alpha)
}
else
{
  formSDir-=3
  stepCount+=pi/60
  formSDist=8+sin(stepCount)
  if sprite_index!=sFNFace
  {
    draw_circle(x,y,bodySize,0)
    for(i=0;i<4;i+=1)
    {
      draw_circle(x+lengthdir_x(formSDist,formSDir+(i*90)),y+lengthdir_y(formSDist,formSDir+(i*90)),7,0)
    }
  }
}

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if sprite_index=sFNFace {draw_sprite_ext(sFNFTop,faceTopImage,x,y-13,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}

if transform=5 //Phase 3 Big Eye
{
  draw_circle(x,y,8,0)
  if eyeState>=1 {draw_sprite_ext(sFNBigEye,faceImage,x,y+4,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
}

if tranSize>0 {draw_circle(x,y,tranSize,0)}

if spreadCircle>0 //Attack indicator
{
  spreadCircle-=atkCircSpd
  draw_set_color(c_gray)
  draw_set_alpha(0.4+(spreadCircle*2))
  draw_circle(x,y,4+spreadCircle,1)
}
