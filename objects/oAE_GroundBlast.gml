#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
sprite_index=sNull
image_yscale=2
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2
warnTime=25

var tTarget;
tTarget=instance_create(x,y-8,oEffect)
tTarget.sprite_index=sEfEnemyAppear; tTarget.image_speed=0.75
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
    image_index+=0.33
    if image_index>=9.6 {instance_destroy()}
  }
  else
  {
    warnTime-=1
    if warnTime=0
    {
      playSound(global.snd_BombExplode,0,0.9,1)
      sprite_index=sBTFirePillar
      bCanDealDamage=true
    }
  }
}
