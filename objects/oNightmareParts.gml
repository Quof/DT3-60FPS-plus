#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
bActive=1
image_speed=0

//Enemy base statistics
eName="Nightmare"
eLevel=26
maxLife=1000
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[5]=4
affiliation=9
bIsBoss=true
bNoBonus=true
hitSound=global.snd_MetEnemyHitA
dieSound=0
dieEffect=0
bossProgress=0
activateBoss=0
anim=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sMetNightmareGrav
{
  eName="Gravity Device"
  resType[4]=5
  resType[5]=5
  bIsBoss=false
  jeremyText="Destroy this as fast as you can as it is limiting your mobility."
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sprite_index=sMetNightmareGrav
  {
    if anim=0
    {
      if image_alpha<1 {image_alpha+=0.02}
      else
      {
        bCanTakeDamage=true
        oPlayer1.grav=5.25
        oGateF_GravControl.lowGravOn=1
        anim=1
      }
    }

    if life<=0
    {
      playSound(global.snd_EnemyDieMM,0,1,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      oPlayer1.grav=1.2
      oGateF_GravControl.lowGravOn=0
      oMetNightmare.bGravExist=0
      instance_destroy()
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
if life>0 {redDmgHit(0)}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.bCanPierce=0 and sprite_index!=sMetNightmareGrav
{
  var tEffect;
  tEffect=instance_create(other.x+random_range(-4,4),other.y+random_range(-4,4),oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  with other {instance_destroy()}
}

if sprite_index=sMetNightmareGrav {event_inherited()}
