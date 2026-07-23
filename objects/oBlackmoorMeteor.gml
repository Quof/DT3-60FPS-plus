#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_alpha=0.66

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  image_angle+=15

  if y>=oBlackmoorMain.yGround
  {
    playSound(global.snd_OrbThrow,0,0.88,49000)
    myExplosion=instance_create(x,oBlackmoorMain.yGround,oBlackmoorShadowExp)
    myExplosion.atkPower=atkPower
    instance_destroy()
  }
}
else {speed=0}
