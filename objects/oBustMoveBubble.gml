#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33*gDeltaTime
decay=150
bounceAmt=1
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 {sprite_index=sBustMoveBubbleRed}
else if type=2 {sprite_index=sBustMoveBubbleBlue}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=moveSpd*gDeltaTime

  decay-=1*gDeltaTime
  if decay<=0
    instance_destroy()
}
else
  speed=0
#define Collision_oSolid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bounceAmt>0
{
  move_bounce_all(0)
  bounceAmt-=1
}
else
{
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMbusterHitEffect
  tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  playSound(global.snd_MetroidBomb,0,0.9,1)
  instance_destroy()
}
#define Collision_oSeekerVirusBasic
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  if type=other.type
    life-=100
  playSound(global.snd_EnemyHit,0,0.92,1)
  if life<=0
  {
    awardAwesome(20)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sSamusSMissileEffect
    tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    playSound(global.snd_EnemyDie,0,0.95,1)
    instance_destroy()
  }
}
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sMMbusterHitEffect; tEffect.image_speed=0.5
tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
