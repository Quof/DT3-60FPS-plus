#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Needs xMove and moveMax.
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Barrier Attacker"
eLevel=18
maxLife=210
life=maxLife
pointWorth=25
atkPower=5
resType[0]=2
resType[1]=2
resType[3]=2
stunResist=2
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
weight=90

turnTime=0
shotTime=50
shotDelay=100
barFrm=0

jeremyText="Attacking these from the front does not work very well, and unless their front armor is not open, even a shot to the back won't work for you very well. When it does open up its front armor, it will put up an energy shield and fire a quick laser at you."
chaoText="Seems these shielding type bots are becoming a lot more common. At least these don't absorb energy with their shield."
devText="When coding this enemy, I realized attacking from the front/back of enemies was going to be a more common thing in DT3. This prompted me to create a sub-class to taking damage for enemy objects that handled attacks coming from different directions based on the enemy's facing."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    if shotTime<shotDelay+9
    {
      if xMove>0
        image_xscale=1
      else
        image_xscale=-1

      x+=xMove

      turnTime+=1
      if turnTime>=moveMax
      {
        xMove*=-1
        turnTime=0
      }
    }

    shotTime+=1
    if shotTime>=shotDelay and shotTime<=shotDelay+10
    {
      if checkFacing()=1
      {
        image_index=1
        resType[3]=3
        shotTime=shotDelay+20
      }
      else {shotTime=shotDelay-2}
    }
    else if shotTime=shotDelay+26 {image_index=2; resType[3]=4}
    else if shotTime=shotDelay+42
    {
      playSound(global.snd_LaserA,0,0.97,25000)
      var tNewAttack;
      tNewAttack=instance_create(x+(10*image_xscale),y,oPassBullet)
      tNewAttack.sprite_index=sWalkBlasterLaser
      tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
      tNewAttack.direction=point_direction(x+(10*image_xscale),y,oPlayer1.x,oPlayer1.y-26)
    }
    else if shotTime=shotDelay+66 {image_index=1; resType[3]=3}
    else if shotTime=shotDelay+72 {image_index=0; resType[3]=2; shotTime=0}
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tDir=random_range(-3,3)
    tEffect=instance_create(x+(10*image_xscale),y-13,oEffectGrav); tEffect.sprite_index=sBarrierAttackerParts
    tEffect.image_speed=0; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-4-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x+(8*image_xscale),y-7,oEffectGrav); tEffect.sprite_index=sBarrierAttackerParts
    tEffect.image_speed=0; tEffect.image_index=1; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x-(5*image_xscale),y+9,oEffectGrav); tEffect.sprite_index=sBarrierAttackerParts
    tEffect.image_speed=0; tEffect.image_index=2; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    tDir=random_range(-3,3)
    tEffect=instance_create(x-(4*image_xscale),y-5,oEffectGrav); tEffect.sprite_index=sBarrierAttackerParts
    tEffect.image_speed=0; tEffect.image_index=3; tEffect.type=2
    tEffect.xSpd=tDir; tEffect.ySpd=-3-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
    tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    instance_destroy()
  }
  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_index=0 or image_index=2
{
  if enemyDeflect(0,1,1,1,0,1)=1
  {
    var tEffect;
    tEffect=instance_create(other.x,other.y,oEffect)
    tEffect.sprite_index=sMMchargeComplete
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    if image_index=2
    {
      playSound(global.snd_MMBulletDeflect,0,1,1)
      tEffect.image_xscale=2; tEffect.image_yscale=2
    }
    with other {instance_destroy()}
  }
  else {event_inherited()}
}
else {event_inherited()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if image_index=2
{
  barFrm+=0.33
  draw_sprite_ext(sBarrierAtkBar,barFrm,x+(10*image_xscale),y,image_xscale,1,0,c_white,0.5)
}
