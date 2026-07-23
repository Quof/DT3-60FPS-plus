#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.attackState=0
{
  x=oPlayer1.x+(24*oPlayer1.image_xscale)

  if oPlayer1.state=oPlayer1.DUCKING
  {
    y=oPlayer1.y-7
  }
  else
  {
    y=oPlayer1.y-26
  }
}
else
{
  y=-16
}
#define Collision_oHelmetSwordBeam
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  playSound(global.snd_MMBulletDeflect,0,1,1)
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_destroy()
}
