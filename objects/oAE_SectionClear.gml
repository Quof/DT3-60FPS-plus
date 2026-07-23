#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
sprite_index=sNull
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
damageType="EXPLOSION"
size=2
warnTime=35

var tTarget;
tTarget=instance_create(x,y,oEffect)
tTarget.sprite_index=sEfEnemyAppear; tTarget.image_speed=0.65; tTarget.image_alpha=0.8
tTarget.newBlend=-1; tTarget.followID=-1; tTarget.decay=-100; tTarget.xSpd=0; tTarget.ySpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bCanDealDamage=true
  {
    image_index+=0.5
    if image_index>=6.6 {instance_destroy()}
  }
  else
  {
    warnTime-=1
    if warnTime=0
    {
      playSound(global.snd_BombExplode,0,1,1)
      sprite_index=sShipExplosion
      bCanDealDamage=true
    }
  }
}
