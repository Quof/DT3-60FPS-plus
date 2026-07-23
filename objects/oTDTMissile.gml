#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="SHOT"
weaponTag=105
missileProg=0
decayTime=0
myTarget=-1
image_angle=90
direction=90
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sSamusMissileHit
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if missileProg=0
  {
    y-=2*global.speedMod
    decayTime+=1*global.speedMod
    if decayTime>=35
    {
      if instance_exists(oEnemyBase) {myTarget=instance_nearest(x,y,oEnemyBase)}
      else {direction=90}
      decayTime=150
      missileProg=1
    }
  }
  else if missileProg=1
  {
    if instance_exists(myTarget)
    {
      mydir=point_direction(x,y,myTarget.x,myTarget.y)
      turn_toward_direction(mydir,6*global.speedMod)
    }
    else
    {
      if instance_exists(oEnemyBase) {myTarget=instance_nearest(x,y,oEnemyBase)}
    }
    image_angle=direction
    speed=bulletSpeed*global.speedMod

    decayTime-=1*global.speedMod
    if decayTime<=0 {instance_destroy()}
  }
}
else {speed=0}
#define Collision_oEnemyBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if missileProg=1
{
  myExplosion=instance_create(x,y,oTDTMisExp)
  myExplosion.atkPower=atkPower
  myExplosion.image_xscale=2+(myLevel*0.15)
  myExplosion.image_yscale=2+(myLevel*0.15)
  instance_destroy()
}
