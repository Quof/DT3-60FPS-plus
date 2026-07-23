#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
image_speed=0.33
image_alpha=0
flameFrm=0
flameBlend=c_white

//Enemy base statistics
eName="Dylan the Poe"
eLevel=6
maxLife=1500
life=maxLife
atkPower=4
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=1
dieEffect=0
hitSound=global.snd_EnemyHitZelda

atkSequence=0
atkTime=0
xSpd=1

bulletAtkTime=20
bulletAtkDelay=110
bulletType=0

leftSide=128
rightSide=352

deathAnim=0

jeremyText="Looks like this guy doesn't like you. His pattern is easy enough, it's just back and forth at the upper section of the room. When you see his flame flare up orange, he's going to fire a stream of bullets toward you. If it's green, get off the ground, he's about to fire a stream of bullets along the ground. It also seems he's invulnerable while his flame isn't lit."
chaoText="The shield hinders Dead Hand a bit. It slows down Dead Hand's generation of the Grabbing Hands and causes him to fire bullets at a much slower rate."
devText="A silly thing happened when I first released this level/boss to the testers. For the most part, everything was good for a first pass, but then I looked over my notes on how Dead Hand was supposed to behave and realized that I completely forgot to include the Poe appearing in the fight. I got a bit caught up in recoding the boss for DT3, that I forgot the addition of the Poe... Don't ask how that happened, it just does."
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
    showBossHP.newOffsetX=424
    activateBoss=2
  }

  if bActive=true and life>0
  {
    flameFrm+=0.15
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    if atkSequence=0 //--------------- Fade in ---------------
    {
      atkTime+=1
      if atkTime=10 {playSound(global.snd_Error,0,1,10000)}
      else if atkTime>=11 and atkTime<=30
      {
        image_alpha+=0.05
      }
      else if atkTime>=35
      {
        atkTime=0; atkSequence=1
      }
    }
    else if atkSequence=1 or atkSequence=3 //--------------- Slight wait ---------------
    {
      atkTime+=1
      if atkTime>=30 {atkTime=0; atkSequence+=1}
    }
    else if atkSequence=2 //--------------- Move left ---------------
    {
      x-=xSpd
      if x<=leftSide {atkSequence=3}
    }
    else if atkSequence=4 //--------------- Move right ---------------
    {
      x+=xSpd
      if x>=rightSide {atkSequence=1}
    }

    if atkSequence>0
    {
      bulletAtkTime+=1
      if bulletType=0 //Bullet line attack
      {
        if bulletAtkTime>=bulletAtkDelay
        {
          playSound(global.snd_SniperShot,0,0.95,14000)
          var tFire,tDir,tEffect;
          tDir=point_direction(x,y-32,oPlayer1.x,returnPlayerYCenter())
          tEffect=instance_create(x,y-32,oEffect)
          tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.75; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
          tEffect.newBlend=1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          for(i=0;i<5;i+=1)
          {
            tFire=instance_create(x,y-32,oPassBullet)
            tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=i+1; tFire.decayTime=-100
          }
          flameBlend=c_green
          bulletType=1; bulletAtkTime=0
        }
      }
      else //Bullet ground attack
      {
        if bulletAtkTime>=bulletAtkDelay
        {
          if bulletAtkTime mod 5=0
          {
            playSound(global.snd_SniperShot,0,0.95,28000)
            var tFire,tEffect;
            tEffect=instance_create(oDeadHand.xCenter-oDeadHand.roomSpan-48,oDeadHand.yGround-16,oEffect)
            tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.75; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
            tEffect.newBlend=1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
            tEffect=instance_create(oDeadHand.xCenter+oDeadHand.roomSpan+48,oDeadHand.yGround-16,oEffect)
            tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.75; tEffect.image_xscale=0.2; tEffect.image_yscale=0.2
            tEffect.newBlend=1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

            tFire=instance_create(oDeadHand.xCenter-oDeadHand.roomSpan-48,oDeadHand.yGround-16,oPassBullet)
            tFire.direction=0; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=6; tFire.decayTime=-100
            tFire=instance_create(oDeadHand.xCenter+oDeadHand.roomSpan+48,oDeadHand.yGround-16,oPassBullet)
            tFire.direction=180; tFire.sprite_index=sWolfHeadShot
            tFire.atkPower=atkPower; tFire.bulletSpeed=6; tFire.decayTime=-100
          }
        }
        if bulletAtkTime>=bulletAtkDelay+20
        {
          flameBlend=c_white
          bulletType=0
          bulletAtkTime=0
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0
    {
      bulletAtkDelay-=4
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.26 and bossProgress=1
    {
      bulletAtkDelay-=3
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0 and bossProgress=2
    {
      bulletAtkDelay-=3
      bossProgress+=1
    }
  }
  else if life<=0
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.75; tEffect.image_xscale=1; tEffect.image_yscale=1
    tEffect.newBlend=1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sG2_PoeCandle,0,x+(14*image_xscale),y+4,1,1,0,image_blend,image_alpha)
if bulletAtkTime>=bulletAtkDelay-55
{
  bCanTakeDamage=true
  draw_sprite_ext(sG2_PoeFlame,flameFrm,x+(14*image_xscale),y-6,1,1,0,flameBlend,image_alpha)
}
else
{
  bCanTakeDamage=false
}
event_inherited()
