#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanDealDamage=false

//Enemy base statistics
eName="Thunderbird"
eLevel=7
maxLife=2750
life=maxLife
atkPower=5
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
hitSound=global.snd_EnemyHitZelda

rmBd_Left=368
rmBd_Right=720
rmBd_Top=144
rmBd_Bottom=192

bFrameUp=0
animFrame=0

xSpd=-2.5
ySpd=1.2
spikeRise=0

atkTime=0
atkDelay=20
atkDir=1

fastMove=-1
spdMod=1

deathAnim=0

jeremyText="This has been changed quite a bit from its original source. If you're patient, it shouldn't be too bad though. Most of this is fireball spam."
chaoText="It sucked to always have to use half of your Magic to cast the Thunder spell just to be able to hit this thing in Zelda 2. Then cast the Jump, Shield, and Reflect spell, I'd have nothing left to cast Life. What? I always got hit so much on this thing!"
devText="Early on, these bosses were much closer to the originals with very few changes. Later in the project, all of the early bosses got quite a big revamp to set them apart."
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
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if bFrameUp=0
    {
      animFrame+=0.2
      if animFrame=3.4 {bFrameUp=1}
    }
    else if bFrameUp=1
    {
      animFrame-=0.2
      if animFrame=0.6 {bFrameUp=0}
    }

    //---------- Movement ----------
    if xSpd>0 and x>=rmBd_Right //Right side
    {
      xSpd*=-1
      if fastMove>=0
      {
        fastMove+=1
        if fastMove>=2 and fastMove<=9
        {
          spdMod=3
          fastMove=10
        }
        else if fastMove>=10
        {
          spdMod=1
          fastMove=0
        }
      }
    }
    else if xSpd<0 and x<=rmBd_Left //Left side
    {
      xSpd*=-1
      if fastMove>=0
      {
        fastMove+=1
        if fastMove>=2 and fastMove<=9
        {
          spdMod=3
          fastMove=10
        }
        else if fastMove>=10
        {
          spdMod=1
          fastMove=0
        }
      }
    }
    if ySpd>0 and y>=rmBd_Bottom //Bottom side
    {
      ySpd*=-1
    }
    else if ySpd<0 and y<=rmBd_Top //Top side
    {
      ySpd*=-1
    }
    x+=xSpd*spdMod; y+=ySpd

    if spdMod>1
    {
      if oGame.time mod 5=0
      {
        playSound(global.snd_BombLaunch,0,0.82,44100)
        tNewAttack=instance_create(x,y,oThunderFireball)
        tNewAttack.atkPower=atkPower; tNewAttack.xVel=0; tNewAttack.yVel=-4
        tNewAttack.fireType=0; tNewAttack.sprite_index=sFireBroBlueFire
      }
    }

    //---------- Normal Attack: Fireball ----------
    atkTime+=1
    if atkTime mod atkDelay=0 //Spew fireballs
    {
      var tNewAttack,tDistCheck;
      tDistCheck=point_distance(x,0,oPlayer1.x,0)/48*atkDir
      if atkDir=1 {atkDir=-1}
      else {atkDir=1}
      if bossProgress<=3
      {
        playSound(global.snd_BombLaunch,0,0.82,44100)
        tNewAttack=instance_create(x,y,oGravityBullet)
        tNewAttack.sprite_index=sFireBroFire; tNewAttack.atkPower=atkPower; tNewAttack.damageType="ELEMENTAL"
        tNewAttack.xVel=tDistCheck; tNewAttack.yVel=-3
      }
      else if bossProgress>=4
      {
        tNewAttack=instance_create(x,y,oThunderFireball)
        tNewAttack.atkPower=atkPower; tNewAttack.xVel=tDistCheck; tNewAttack.yVel=-3
        tNewAttack.fireType=1
      }
    }

    if spikeRise>=1 and spikeRise<=64 //Move spikes up
    {
      spikeRise+=1
      with oMarioSpikeFloor {y-=1}
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.87 and lifePercent>=0.75 and bossProgress=0
    {
      atkDelay-=1
      bossProgress+=1
    }
    else if lifePercent<=0.74 and lifePercent>=0.61 and bossProgress=1
    {
      atkDelay-=1
      fastMove=1
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.45 and bossProgress=2
    {
      for(i=0;i<9;i+=1)
      {
        instance_create(304+(16*i),368,oMarioSpikeFloor)
        instance_create(640+(16*i),368,oMarioSpikeFloor)
      }
      spikeRise=1
      bossProgress+=1
    }
    else if lifePercent<=0.44 and lifePercent>=0.21 and bossProgress=3
    {
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      atkDelay-=1
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      with oMarioSpikeFloor {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=55
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width)+random(sprite_width*2),(y-20)+random(sprite_height*4),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=56
    {
      if global.bBossGallery=1
      {
        bossRoomTally(6)
        global.newMapX=1304; global.newMapY=1376; room_goto(rBossGallery)
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
draw_sprite_ext(sThunderbirdBody,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sThunderbirdWing,animFrame,x+15,y-23,1,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sThunderbirdWing,animFrame,x-15,y-23,-1,image_yscale,image_angle,image_blend,image_alpha)
