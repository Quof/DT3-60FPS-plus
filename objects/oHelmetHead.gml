#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
waterFrm=0

//Enemy base statistics
eName="Helmethead"
eLevel=5
maxLife=3000
life=maxLife
atkPower=4
resType[1]=2
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
hitSound=global.snd_EnemyHitZelda

moveTime=0
moveThres=40
atkTime=0
atkDelay=90
myBarrier=0

xCenter=448
yGround=304
roomSpan=192

deathAnim=0

jeremyText="Remember this guy from Zelda 2? Minor differences between the two exist. It's only going to periodically walk toward you and fire bullets. It also has some resistance to your arrows... Oh wait, its got a lot more that it can do now. It'll be shielding itself somehow."
chaoText="This wasn't a ghost in Zelda 2. Remember that?"
devText="Since this Gate is using Zelda 2 as a base, it needed a boss or two from the game. Jerry is faster, jumps higher, and attacks wider than Link did in the original game. Of course some changes should be made to compensate for this."
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
      if x<oPlayer1.x
        image_xscale=1
      else
        image_xscale=-1
    }

    moveTime+=1
    if moveTime>=moveThres and moveTime<=moveThres+15
    {
      image_speed=0.2
      if image_xscale=1
        x+=1
      else
        x-=1
    }
    else if moveTime>=moveThres+16
    {
      image_speed=0
      image_index=0
      xVel=0
      moveTime=0
    }

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

    if myBarrier=1 //Set barrier
    {
      with oHelmetHeadHelmet
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
        if bossProgress=6 {resType[0]=2}
        resType[1]=2
        resType[4]=4
        myBarrier=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.87 and lifePercent>=0.74 and bossProgress=0
    {
      myHelmetA=instance_create(x,y-31,oHelmetHeadHelmet)
      myHelmetA.moveThres=20; myHelmetA.atkDelay=95; myHelmetA.yGround=160; myHelmetA.type=1
      atkDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.73 and lifePercent>=0.61 and bossProgress=1
    {
      myHelmetB=instance_create(x,y-31,oHelmetHeadHelmet)
      myHelmetB.sprite_index=sHelmetHeadB; myHelmetB.type=2
      myHelmetB.moveThres=30; myHelmetB.atkDelay=80; myHelmetB.yGround=176
      atkDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=2
    {
      atkDelay-=4
      myBarrier=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.26 and bossProgress=3
    {
      with oHelmetHeadHelmet {bossProg=1}
      atkDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0.11 and bossProgress=4
    {
      with oHelmetHeadHelmet {extraBullet=1}
      atkDelay-=4
      var tAtkShield;
      tAtkShield=instance_create(x,y-16,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=-16; tAtkShield.atkType=0; tAtkShield.atkUp=1
      resType[0]=2
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=5
    {
      myBarrier=1
      atkDelay-=2
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oHelmetHeadHelmet {instance_destroy()}
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
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(3)
        global.newMapX=872; global.newMapY=1376; room_goto(rBossGallery)
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
if bossProgress=0
  draw_sprite_ext(sHelmetHeadA,image_index,x,y-31,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
else if bossProgress=1
  draw_sprite_ext(sHelmetHeadB,image_index,x,y-31,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if myBarrier=2 {draw_sprite_ext(sWaterBarrier,waterFrm,x,y-16,0.9,0.9,0,c_white,0.4)}
