#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1
image_speed=0
waterFrm=0

//Enemy base statistics
eName="Helmethead EX"
eLevel=40
maxLife=12000
life=maxLife
atkPower=11
resType[1]=2
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=1
hitSound=global.snd_EnemyHitZelda

shadowScale=0
shadowX=0
shadowOffsetX=0
endShadow=0

bMoveNormally=1
moveTime=0
moveThres=40
atkTime=0
atkDelay=90
bNormalAtk=1
myBarrier=0
bDisplayBarrier=0

floorFireTime=0
swordProg=0
swordBeamSpd=1
checkWhenToDestroyShield=0

helmetShadowProg=0
helmetShadowX1=0
helmetShadowY1=0
helmetShadowX2=0
helmetShadowY2=0
bHelmetShadowCanShoot=0
helmetShadowShotTime=0

numOfStreams=0
bulletStream=0
catfaceDist=0
catfaceAngle=0

xCenter=240
yGround=304
roomSpan=192

deathAnim=0

jeremyText="This guy sucks. He can screw you over if you don't pay attention and also because there's no way to predict what his helmets will do until you've died to him a few times. Definitely a garbage boss that should be skipped."
chaoText="Is there going to be an EX everything now? Imagine an EX Cackletta! She IS the hardest boss in the game!"
devText="?????"
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
    waterFrm+=0.33
    //---------- Movement ----------
    if moveTime<moveThres
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    if bMoveNormally=1 //Normal walk toward player
    {
      moveTime+=1
      if moveTime>=moveThres and moveTime<=moveThres+15
      {
        image_speed=0.2
        if image_xscale=1 {x+=1}
        else {x-=1}
      }
      else if moveTime>=moveThres+16
      {
        image_speed=0
        image_index=0
        xVel=0
        moveTime=0
      }
    }

    if shadowScale>0
    {
      shadowOffsetX=x-xCenter
      shadowX=xCenter-shadowOffsetX
    }

    if bNormalAtk=1 //Normal attack toward player
    {
      atkTime+=1
      if atkTime=atkDelay //---------- Attack: Bullet toward player ----------
      {
        var tEffect;
        tEffect=instance_create(x,y-35,oEffect)
        tEffect.sprite_index=sMMchargeComplete
        tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_speed=0.5
        tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-35
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if atkTime>=atkDelay+20
      {
        playSound(global.snd_HardHit3,0,1,17000)
        var tFire;
        tFire=instance_create(x,y-35,oPassBullet)
        tFire.direction=point_direction(x,y-35,oPlayer1.x,returnPlayerYCenter()); tFire.sprite_index=sWolfHeadShot
        tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        atkTime=0
      }
    }

    if bossProgress=5 //Move to side
    {
      atkTime+=1
      if atkTime=15
      {
        instance_create(oPlayer1.x,oPlayer1.y,oHelmetShield)
        var tEffect;
        tEffect=instance_create(x,y-35,oEffect)
        tEffect.sprite_index=sMMchargeComplete
        tEffect.image_xscale=4; tEffect.image_yscale=4; tEffect.image_speed=0.5
        tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-35
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if atkTime>=35
      {
        x+=4
        if x>422
        {
          bDisplayBarrier=0
          for(i=0;i<6;i+=1)
          {
            resType[i]=3
          }
          resType[4]=2
          x=422
          floorFireTime=1
          atkTime=0; bossProgress+=1
        }
      }
    }
    else if bossProgress=6 //Fire a pattern of bullets that player blocks with new shield - Part 1
    {
      atkTime+=1
      if atkTime=20
      {
        myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
      }
      else if atkTime=40
      {
        myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
      }
      else if atkTime=70
      {
        myBeam=instance_create(shadowX+(6*-image_xscale),y-7,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5
      }
      else if atkTime=100
      {
        myBeam=instance_create(shadowX+(6*-image_xscale),y-26,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5
        atkTime=0
      }
    }
    else if bossProgress=7 //Fire a pattern of bullets that player blocks with new shield - Part 2
    {
      atkTime+=1
      if atkTime=40
      {
        myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
        myBeam=instance_create(shadowX+(6*-image_xscale),y-26,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5
      }
      else if atkTime=70
      {
        myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
        myBeam=instance_create(shadowX+(6*-image_xscale),y-7,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5
      }
      else if atkTime=100
      {
        myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
      }
      else if atkTime=110
      {
        myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
      }
      else if atkTime=120
      {
        myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
      }
      else if atkTime=130
      {
        myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
      }
      else if atkTime=170
      {
        myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
        myBeam=instance_create(shadowX+(6*-image_xscale),y-7,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5
      }
      else if atkTime=190
      {
        myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
        myBeam=instance_create(shadowX+(6*-image_xscale),y-26,oHelmetSwordBeam)
        myBeam.atkPower=atkPower; myBeam.bulletSpeed=5
        atkTime=0
      }
    }
    else if bossProgress=8 //Desperation shield block sequence
    {
      atkTime+=swordBeamSpd
      if atkTime>=40 and swordProg=0 {myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=48 and swordProg=1 {myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=56 and swordProg=2 {myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=64 and swordProg=3 {myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=72 and swordProg=4 {myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=80 and swordProg=5 {myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=88 and swordProg=6 {myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=96 and swordProg=7 {myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=104 and swordProg=8 {myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=112 and swordProg=9 {myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=120 and swordProg=10 {myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=128 and swordProg=11 {myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=136 and swordProg=12 {myBeam=instance_create(x+(6*image_xscale),y-7,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180; swordProg+=1}
      else if atkTime>=144 and swordProg=13
      {
        myBeam=instance_create(x+(6*image_xscale),y-26,oHelmetSwordBeam); myBeam.atkPower=atkPower; myBeam.bulletSpeed=5; myBeam.direction=180
        atkTime=32
        swordProg=0
        swordBeamSpd+=0.25
        if swordBeamSpd>=1.9
        {
          helmetShadowX1=64
          helmetShadowY1=96
          helmetShadowX2=416
          helmetShadowY2=96
          atkTime=0; bossProgress+=1
        }
      }
    }
    else if bossProgress=9 //Get ready for final phase
    {
      atkTime+=1
      if atkTime>=70
      {
        with oHelmetFloorFire {instance_destroy()}
        with oHelmetHeadHelmetEX
        {
          bossProg=6
          if type=1 //Bottom
          {
            aimedAtkDelay=35
          }
          else if type=2 //Top
          {
            aimedAtkDelay=55
          }
        }
        bHelmetShadowCanShoot=1
        checkWhenToDestroyShield=1
        bDisplayBarrier=0
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        resType[4]=2
        atkTime=170; bossProgress+=1
      }
    }
    else if bossProgress=10 or bossProgress=11 //Bullet stream
    {
      atkTime+=1
      if atkTime=200
      {
        catfaceDist=120
        catfaceAngle=0
      }
      else if atkTime>=201 and atkTime<=320
      {
        catfaceAngle+=2
        catfaceDist-=1
        if atkTime=320 {atkTime=400}
      }
      else if atkTime>=401
      {
        if atkTime mod 2=0
        {
          playSound(global.snd_HardHit3,0,1,17000)
          var tFire;
          tFire=instance_create(x,y-35,oPassBullet)
          tFire.direction=180; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          if numOfStreams mod 2=0
          {
            var tFire;
            tFire=instance_create(x,y-17,oPassBullet)
            tFire.direction=180; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          }
          bulletStream+=1
        }

        if bulletStream>=5
        {
          bulletStream=0
          numOfStreams+=1
          if numOfStreams>=5
          {
            numOfStreams=0
            atkTime=0
          }
          else
          {
            atkTime=385
          }
        }
      }
    }
    else if bossProgress=12 //Final desperation
    {
      atkTime+=1
      if atkTime=20
      {
        catfaceDist=120
        catfaceAngle=0
      }
      else if atkTime>=21 and atkTime<=60
      {
        catfaceAngle+=6
        catfaceDist-=3
        if atkTime=60 {atkTime=100}
      }
      else if atkTime>=101 and atkTime<=400
      {
        if atkTime mod 2=0
        {
          playSound(global.snd_HardHit3,0,1,17000)
          var tFire;
          tFire=instance_create(x,y-35,oPassBullet)
          tFire.direction=180; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=6; tFire.decayTime=-100
          tFire=instance_create(x,y-17,oPassBullet)
          tFire.direction=180; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=6; tFire.decayTime=-100
          bulletStream+=1
        }
      }
      else if atkTime>=430
      {
        with oHelmetHeadEX_Catface {flashProg=11}
        atkTime=0; bossProgress+=1
      }
    }
    else if bossProgress>=13 //Last attack
    {
      atkTime+=1
      if atkTime=20
      {
        catfaceDist=120
        catfaceAngle=0
      }
      else if atkTime>=21 and atkTime<=80
      {
        catfaceAngle+=4
        catfaceDist-=2
        if atkTime=70
        {
          with oHelmetHeadHelmetEX
          {
            bossProg=10
            aimedAtkDelay=20
            for(i=0;i<6;i+=1)
            {
              resType[i]=1
            }
            myBarrier=0
          }
        }
        if atkTime=80 {atkTime=200}
      }
      else if atkTime>=201
      {
        if atkTime mod 2=0
        {
          playSound(global.snd_HardHit3,0,1,17000)
          var tFire;
          tFire=instance_create(x,y-35,oPassBullet)
          tFire.direction=180; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          if numOfStreams mod 2=0
          {
            var tFire;
            tFire=instance_create(x,y-17,oPassBullet)
            tFire.direction=180; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          }
          else
          {
            var tFire;
            tFire=instance_create(x,y-53,oPassBullet)
            tFire.direction=180; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
            tFire=instance_create(x,y-71,oPassBullet)
            tFire.direction=180; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          }
          bulletStream+=1
        }

        if bulletStream>=5
        {
          bulletStream=0
          numOfStreams+=1
          atkTime=175
        }
      }
    }

    //-------------------- Other sequencing behaviors --------------------
    if myBarrier=1 //Set barrier
    {
      with oHelmetHeadHelmetEX
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        resType[0]=2
        resType[1]=4
        myBarrier=1
      }
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      bDisplayBarrier=1
      myBarrier=2
    }
    else if myBarrier=2 //Wait for both helmets to take enough damage and revert everything to normal
    {
      if myHelmetA.myBarrier=0 and myHelmetB.myBarrier=0
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        if bossProgress=13
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=2
          }
        }
        bDisplayBarrier=0
        myBarrier=0
      }
    }

    if bossProgress=3 //Wait for Helmets to reach corners
    {
      if myHelmetA.bossProg=2 and myHelmetB.bossProg=2
      {
        myHelmetA.bossProg=3
        myHelmetB.bossProg=3
      }
    }
    else if bossProgress=4
    {
      if myHelmetA.bArcExtraBullet=0
      {
        if myHelmetA.shotTime>=250
        {
          myHelmetA.bArcExtraBullet=1
          myHelmetB.bArcExtraBullet=1
        }
      }
    }

    if floorFireTime>0 //Spawn fire along sides of the room
    {
      floorFireTime+=1
      if floorFireTime=15
      {
        myFire=instance_create(x-16,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        myFire=instance_create(shadowX+16,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
      }
      else if floorFireTime=30
      {
        myFire=instance_create(x-32,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        myFire=instance_create(shadowX+32,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
      }
      else if floorFireTime=45
      {
        myFire=instance_create(x-48,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        myFire=instance_create(shadowX+48,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
      }
      else if floorFireTime=60
      {
        myFire=instance_create(x-64,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        myFire=instance_create(shadowX+64,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
      }
      else if floorFireTime=75
      {
        myFire=instance_create(x-80,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        myFire=instance_create(shadowX+80,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
      }
      else if floorFireTime=90
      {
        myFire=instance_create(x-96,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        myFire=instance_create(shadowX+96,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
      }
      if bossProgress=8 //Right side extra fire
      {
        if floorFireTime=120
        {
          myFire=instance_create(x-112,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        }
        else if floorFireTime=140
        {
          myFire=instance_create(x-128,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        }
        else if floorFireTime=160
        {
          myFire=instance_create(x-144,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        }
        else if floorFireTime=180
        {
          myFire=instance_create(x-160,yGround,oHelmetFloorFire); myFire.atkPower=atkPower
        }
      }
    }

    if shadowScale>=1 and shadowScale<=1.5 //Scale up shadow
    {
      shadowScale+=0.01
    }

    if helmetShadowProg=1 //Send ghost helmets to their position
    {
      if helmetShadowX1<63 {helmetShadowX1+=1}
      else if helmetShadowX1>65 {helmetShadowX1-=1}
      if helmetShadowY1<95 {helmetShadowY1+=1}
      else if helmetShadowY1>97 {helmetShadowY1-=1}
      if helmetShadowX2<415 {helmetShadowX2+=1}
      else if helmetShadowX2>417 {helmetShadowX2-=1}
      if helmetShadowY2<95 {helmetShadowY2+=1}
      else if helmetShadowY2>97 {helmetShadowY2-=1}
    }

    if bHelmetShadowCanShoot=1 //Ghost helmets shoot
    {
      helmetShadowShotTime+=1
      if helmetShadowShotTime mod 3=0
      {
        //Left
        var tFire;
        tFire=instance_create(helmetShadowX1,helmetShadowY1-4,oPassBullet)
        tFire.direction=270; tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        tFire=instance_create(helmetShadowX1,helmetShadowY1-4,oPassBullet)
        tFire.direction=265; tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        tFire=instance_create(helmetShadowX1,helmetShadowY1-4,oPassBullet)
        tFire.direction=285; tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        tFire=instance_create(helmetShadowX1,helmetShadowY1-4,oPassBullet)
        tFire.direction=350; tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        //Right
        tFire=instance_create(helmetShadowX2,helmetShadowY2-4,oPassBullet)
        tFire.direction=270; tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        tFire=instance_create(helmetShadowX2,helmetShadowY2-4,oPassBullet)
        tFire.direction=275; tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        tFire=instance_create(helmetShadowX2,helmetShadowY2-4,oPassBullet)
        tFire.direction=255; tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        tFire=instance_create(helmetShadowX2,helmetShadowY2-4,oPassBullet)
        tFire.direction=190; tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
      }
    }

    if checkWhenToDestroyShield=1 //Destroy shield when it is no longer needed
    {
      if !instance_exists(oHelmetSwordBeam)
      {
        with oHelmetShield {instance_destroy()}
        checkWhenToDestroyShield=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.97 and bossProgress=0 //Helmets comes off
    {
      myHelmetA=instance_create(x,y-31,oHelmetHeadHelmetEX); myHelmetA.atkPower=atkPower
      myHelmetA.moveThres=20; myHelmetA.aimedAtkDelay=95; myHelmetA.yGround=160; myHelmetA.type=1; myHelmetA.xSpd=-2
      myHelmetB=instance_create(x,y-31,oHelmetHeadHelmetEX); myHelmetB.atkPower=atkPower
      myHelmetB.sprite_index=sHelmetHeadB
      myHelmetB.moveThres=30; myHelmetB.aimedAtkDelay=80; myHelmetB.yGround=176; myHelmetB.type=2; myHelmetB.xSpd=2
      bossProgress+=1
    }
    else if lifePercent<=0.94 and bossProgress=1 //HelmetHead barrier comes up
    {
      myBarrier=1
      bossProgress+=1
    }
    else if lifePercent<=0.88 and bossProgress=2 //Helmets go to top corners
    {
      with oHelmetHeadHelmetEX {bossProg=1}
      bossProgress+=1
    }
    else if lifePercent<=0.65 and bossProgress=3 //Barrier comes up again
    {
      myBarrier=1
      bossProgress+=1
    }
    else if lifePercent<=0.55 and bossProgress=4 //Slide to right side
    {
      shadowScale=1
      bDisplayBarrier=1
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      with oHelmetHeadHelmetEX
      {
        bAimedShot=0
        bossProg=4
      }
      bMoveNormally=0; moveTime=0
      bNormalAtk=0; atkTime=0
      bossProgress+=1
    }
    else if lifePercent<=0.43 and bossProgress=6 //Change sword waves
    {
      with oHelmetHeadEX_Catface {flashProg=1}
      with oHelmetSwordBeam
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_destroy()
      }
      atkTime=0
      bossProgress+=1
    }
    else if lifePercent<=0.3 and bossProgress=7 //Push player to the left with fire
    {
      with oHelmetHeadEX_Catface {flashProg=11}
      helmetShadowProg=1
      helmetShadowX1=myHelmetA.x; helmetShadowY1=myHelmetA.y
      helmetShadowX2=myHelmetB.x; helmetShadowY2=myHelmetB.y
      floorFireTime=100
      shadowScale=0
      bDisplayBarrier=1
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      with oHelmetFloorFire {instance_destroy()}
      for(i=0;i<6;i+=1)
      {
        myFire=instance_create(x-16-(16*i),yGround,oHelmetFloorFire); myFire.atkPower=atkPower
      }
      with oHelmetSwordBeam
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_destroy()
      }
      atkTime=0
      bossProgress+=1
    }
    else if lifePercent<=0.18 and bossProgress=10 //Final barrier
    {
      myBarrier=1
      bossProgress+=1
    }
    else if lifePercent<=0.09 and bossProgress=11 //Final desperation
    {
      with oHelmetHeadEX_Catface {flashProg=1}
      myBarrier=1
      with oHelmetHeadHelmetEX
      {
        bossProg=8
      }
      catfaceDist=0
      atkTime=0
      bossProgress+=1
    }
    else if lifePercent<=0.05 and bossProgress=13 //Bomb Resist
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=4; tAtkShield.atkUp=4
      resType[4]=1
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      global.canPause=0
      helmetShadowProg=0
      with oHelmetHeadHelmetEX {instance_destroy()}
      with oPassBullet {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 5=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),y-random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim=90
    {
      oHelmetHeadEX_Catface.alternateFlash=1
    }
    else if deathAnim>=141 and deathAnim<=160
    {
      endShadow+=0.1
    }
    else if deathAnim=180
    {
      global.BTB_HelmetHead=1
      oHelmetHeadEX_Catface.bulletProg=1
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if shadowScale>0
{
  draw_sprite_ext(sprite_index,image_index,shadowX,y,shadowScale*-image_xscale,shadowScale,image_angle,c_black,0.4)
}
if endShadow>0
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*endShadow,image_yscale*endShadow,image_angle,c_black,0.4)
}
event_inherited()
if bossProgress=0
  draw_sprite_ext(sHelmetHeadA,image_index,x,y-31,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if helmetShadowProg>0
{
  draw_sprite_ext(sHelmetHeadA,0,helmetShadowX1,helmetShadowY1,1,1,0,c_white,0.33)
  draw_sprite_ext(sHelmetHeadB,0,helmetShadowX2,helmetShadowY2,-1,1,0,c_white,0.33)
}

if catfaceDist>0
{
  for(i=0;i<24;i+=1)
  {
    draw_sprite_ext(sHelmetHeadEX_Catface,0,x+lengthdir_x(catfaceDist,catfaceAngle+(i*15)),y-31+lengthdir_y(catfaceDist,catfaceAngle+(i*15)),1,1,catfaceAngle+(i*15),c_white,1)
  }
}

if bDisplayBarrier=1 {draw_sprite_ext(sWaterBarrier,waterFrm,x,y-16,0.9,0.9,0,c_white,0.4)}
