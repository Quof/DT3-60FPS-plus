#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
image_speed=0
visible=0
bump=0
waterFrm=0

//Enemy base statistics
eName="Dead Hand"
eLevel=6
maxLife=4000
life=maxLife
atkPower=4
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
hitSound=global.snd_EnemyHitZelda

atkSequence=0
atkTime=0
atkDuration=180
atkCycle=0
bPoeActive=0

xSpd=0.5
ySpd=0
fireRate=12
bCanSummonHands=0
baseRate=90
handRate=baseRate
handTime=70
handSpawnX=240
handTimeout=220
maxHands=6

bBigHands=0
bigHandScl=0

xCenter=240
yGround=288
yCeiling=96
roomSpan=144

deathAnim=0

jeremyText="The first thing it does is rise from the ground, and will then slowly creep toward you. If you're on one of the platforms while it's in the ground, it may launch itself out of the ground at you. The other thing to watch for are the hands it summons. There is a limit to the number it can summon, but I wouldn't let them pile up too much."
chaoText="Dead Hand was a miniboss in Ocarina of Time found at the bottom of the well in Kakariko Village and in the Shadow Temple. Oh yeah, I did see a weakness that I don't think Jeremy found. When it comes from the ceiling periodically, it's weak to your arrows. AND, when it launches out of the ground, it's weak to your sword while it's off the ground!"
devText="This is actually the first boss encounter ever made for this engine. While the Displaced Cyborg from DT1 was made before DT was concieved, this one was the first test of a more complex enemy than just move toward player and/or fire at them. It of course had to be altered somewhat to make it work for DT's faster paced gameplay."
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
    if atkSequence=0 //--------------- Rise up from the ground ---------------
    {
      atkTime+=1
      if atkTime=1
      {
        if oPlayer1.x<=240
        {
          x=oPlayer1.x+96
          image_xscale=-1
        }
        else
        {
          x=oPlayer1.x-96
          image_xscale=1
        }
        y=yGround+abs(sprite_height)
        visible=1

        if oPlayer1.y<=232 and bPoeActive=0 //Player is too high
        {
          atkTime=0
          atkSequence=1
        }
      }
      else if atkTime>=30
      {
        if atkTime=31 {playSound(global.snd_Earthquake,0,1,44100)}
        var tEffect,tXspd;
        tEffect=instance_create(x-8+random_range(-15,15),yGround+random_range(-3,15),oEffect)
        tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        if oGame.time mod 2=0
        {
          tXspd=random_range(-2,2)
          tEffect=instance_create(x+random_range(-13,13),yGround+random_range(-2,3),oEffectGrav)
          tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(4); tEffect.grav=0.4
          tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
        }

        y-=0.33
        if y<=yGround
        {
          bCanDealDamage=true
          bCanTakeDamage=true
          y=yGround
          atkTime=0
          atkSequence=2
        }
      }
    }
    else if atkSequence=1 //--------------- Jump up because player was up too high ---------------
    {
      atkTime+=1
      if atkTime=1
      {
        playSound(global.snd_Earthquake,0,1,88200)
        x=oPlayer1.x
        sprite_index=sDeadHand_Jump
        image_speed=0.33
        if bPoeActive=0 {resType[0]=4}
        var tEffect,tXspd;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(x-8+random_range(-15,15),yGround+random_range(-3,15),oEffect)
          tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

          tXspd=random_range(-2,2)
          tEffect=instance_create(x+random_range(-13,13),yGround+random_range(-2,3),oEffectGrav)
          tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(4); tEffect.grav=0.4
          tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
        }
        ySpd=-8
        bCanDealDamage=true
        bCanTakeDamage=true
      }
      else if atkTime>=2
      {
        y+=ySpd
        if ySpd<-2 {ySpd+=0.2}
        else if ySpd>=-2 and ySpd<8 {ySpd+=0.4}
        if y>=yGround and ySpd>0
        {
          sprite_index=sDeadHand_Idle
          image_speed=0; image_index=0
          if bPoeActive=0 {resType[0]=3}
          y=yGround
          atkTime=0
          atkSequence=2
        }
      }
    }
    else if atkSequence=2 //--------------- Move toward player ---------------
    {
      if x<oPlayer1.x
      {
        image_xscale=1
        x+=xSpd
      }
      else
      {
        image_xscale=-1
        x-=xSpd
      }

      if oGame.time mod 3=0
      {
        if bump=0 {y+=1; bump=1}
        else {y-=1; bump=0}
      }

      atkTime+=1
      if atkTime>=atkDuration
      {
        atkTime=0
        if bossProgress>=3 {atkSequence=3}
        else {atkSequence=4}
      }
    }
    else if atkSequence=3 //--------------- Fire at player ---------------
    {
      if bPoeActive=0
      {
        atkTime+=1
        if atkTime=1
        {
          image_index=1
          if x<oPlayer1.x {image_xscale=1}
          else {image_xscale=-1}
        }
        else if atkTime>=30
        {
          if atkTime mod fireRate=0
          {
            playSound(global.snd_HardHit3,0,0.975,22000)
            var tFire;
            tFire=instance_create(x+(20*image_xscale),y-14,oPassBullet)
            tFire.direction=point_direction(x+(20*image_xscale),y-14,oPlayer1.x,oPlayer1.y-26); tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          }
        }
        if atkTime>=80
        {
          image_index=0
          atkTime=0; atkSequence=4
        }
      }
      else
      {
        image_index=0
        atkTime=0; atkSequence=4
      }
    }
    else if atkSequence=4 //--------------- Sink in ground ---------------
    {
      bCanDealDamage=false; bCanTakeDamage=false
      var tEffect,tXspd;
      tEffect=instance_create(x-8+random_range(-15,15),yGround+random_range(-3,15),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      if oGame.time mod 2=0
      {
        tXspd=random_range(-2,2)
        tEffect=instance_create(x+random_range(-13,13),yGround+random_range(-2,3),oEffectGrav)
        tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(4); tEffect.grav=0.4
        tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
      }
      y+=0.5
      if y>=yGround+sprite_height
      {
        visible=0
        atkSequence=5
      }
    }
    else if atkSequence=5 //--------------- Slight wait ---------------
    {
      atkTime+=1
      if atkTime>=45
      {
        atkTime=0
        atkCycle+=1
        if atkCycle=3
        {
          atkCycle=0
          atkSequence=6
        }
        else {atkSequence=0}
      }
    }
    else if atkSequence=6 //--------------- Come from ceiling ---------------
    {
      atkTime+=1
      if atkTime=1
      {
        visible=1
        image_index=1
        image_yscale=-1
        x=xCenter
        y=yCeiling-abs(sprite_height)
        if bPoeActive=0 {resType[1]=5}
        bBigHands=1
        bigHandScl=0
      }
      else if atkTime>=2
      {
        if atkTime=2 {playSound(global.snd_OrbThrow,0,0.975,14000)}
        if bigHandScl<5 {bigHandScl+=0.2}

        var tEffect,tXspd;
        tEffect=instance_create(x-8+random_range(-15,15),yCeiling+random_range(-3,15),oEffect)
        tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        if oGame.time mod 2=0
        {
          tXspd=random_range(-0.25,0.25)
          tEffect=instance_create(x+random_range(-13,13),yCeiling+random_range(-2,3),oEffectGrav)
          tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
          tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=random(1); tEffect.grav=0.4
          tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
        }
        y+=0.5
        if y>=yCeiling
        {
          bCanDealDamage=true; bCanTakeDamage=true
          y=yCeiling
          atkTime=0; atkSequence=7
        }
      }
    }
    else if atkSequence=7 //--------------- Attack from ceiling ---------------
    {
      atkTime+=1
      if bPoeActive=0 {atkMod=20}
      else {atkMod=50}
      if atkTime mod atkMod=0
      {
        playSound(global.snd_HardHit3,0,0.95,28000)
        var tFire;
        tFire=instance_create(x+(20*image_xscale),y+14,oPassBullet)
        tFire.direction=point_direction(x+(20*image_xscale),y+14,oPlayer1.x,oPlayer1.y-26); tFire.sprite_index=sWolfHeadShot
        tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
      }
      if atkTime mod 50=0 and bPoeActive=0
      {
        var tFire,tXOff;
        tXOff=-80
        for(i=0;i<3;i+=1)
        {
          tFire=instance_create(xCenter+tXOff,0,oPassBullet)
          tFire.direction=270; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=6; tFire.decayTime=-100
          tXOff+=80
        }
      }
      if atkTime>=105
      {
        bCanDealDamage=false
        bCanTakeDamage=false
        atkTime=0
        atkSequence=8
      }
    }
    else if atkSequence=8 //--------------- Rise back into ceiling ---------------
    {
      if bigHandScl>0 {bigHandScl-=0.2}

      var tEffect,tXspd;
      tEffect=instance_create(x-8+random_range(-15,15),yCeiling+random_range(-3,15),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_speed=0.25; tEffect.image_blend=c_gray
      tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      if oGame.time mod 2=0
      {
        tXspd=random_range(-0.25,0.25)
        tEffect=instance_create(x+random_range(-13,13),yCeiling+random_range(-2,3),oEffectGrav)
        tEffect.sprite_index=sSmallBoulder; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
        tEffect.followID=-1; tEffect.newBlend=-1; tEffect.xSpd=tXspd; tEffect.ySpd=random(1); tEffect.grav=0.4
        tEffect.rotation=tXspd; tEffect.type=2; tEffect.fadeSpd=0.075
      }
      y-=0.5
      if y<=yCeiling-abs(sprite_height)
      {
        image_yscale=1
        image_index=0
        if bPoeActive=0 {resType[1]=3}
        bBigHands=0
        atkTime=0; atkSequence=9
      }
    }
    else if atkSequence=9 //--------------- Very slight wait ---------------
    {
      atkTime+=1
      if atkTime>=15 {atkTime=0; atkSequence=0}
    }

    if bPoeActive=1 //Dylan is beaten
    {
      if !instance_exists(oDylanThePoe)
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=3
        }
        if sprite_index=sDeadHand_Jump {resType[0]=4}
        if atkSequence>=6 and atkSequence<=8 {resType[1]=5}
        bPoeActive=0
        baseRate=80
      }
    }

    if bCanSummonHands=1 //Summon Hands
    {
      if oPlayer1.y>=232 {handRate=baseRate}
      else {handRate=round(baseRate*0.7)}

      handTime+=1
      if handTime>=handRate and instance_number(oGrabbingHand)<maxHands
      {
        var tHand;
        tHand=instance_create(handSpawnX,yGround+25,oGrabbingHand)
        tHand.timeout=handTimeout
        handSpawnX+=24
        if handSpawnX>=xCenter+roomSpan-24 {handSpawnX=xCenter-roomSpan+24}
        handTime=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.92 and lifePercent>=0.76 and bossProgress=0
    {
      bCanSummonHands=1
      atkDuration-=5
      bossProgress+=1
    }
    else if lifePercent<=0.75 and lifePercent>=0.56 and bossProgress=1
    {
      atkDuration-=15
      baseRate-=7
      handTimeout-=5
      maxHands+=1
      bossProgress+=1
    }
    else if lifePercent<=0.55 and lifePercent>=0.31 and bossProgress=2
    {
      atkDuration-=15
      baseRate-=7
      handTimeout-=5
      maxHands+=1
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0 and bossProgress=3
    {
      baseRate=230
      atkDuration-=5
      handTimeout-=5
      fireRate-=1
      bPoeActive=1
      instance_create(352,160,oDylanThePoe)
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oGrabbingHand {instance_destroy()}
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
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(4)
        global.newMapX=1016; global.newMapY=1376; room_goto(rBossGallery)
      }
      else
      {
        oEvCh4MainA.sceneProgress=1
        instance_destroy()
      }
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
event_inherited()
if bPoeActive=1 {draw_sprite_ext(sWaterBarrier,waterFrm,x,y-(20*image_yscale),1.1,1.1,0,c_white,0.4)}

if bBigHands=1
{
  draw_sprite_ext(sGrabbingHand,0,xCenter-96,yCeiling,bigHandScl,-bigHandScl,0,c_black,0.5)
  draw_sprite_ext(sGrabbingHand,0,xCenter+96,yCeiling,-bigHandScl,-bigHandScl,0,c_black,0.5)
}
