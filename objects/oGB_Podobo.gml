#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.1+random(0.1)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

atkPower=8
damageType="ELEMENTAL"

yVel=-11
glowScl=1.1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  glowScl+=0.025
  if glowScl>=1.4 {glowScl=1.1}

  if yVel<0
  {
    var tBufScl;
    tBufScl=abs(image_yscale)
    image_yscale=tBufScl
  }
  else
  {
    var tBufScl;
    tBufScl=abs(image_yscale)
    image_yscale=-tBufScl
  }
  yVel+=yGrav
  y+=yVel
  if yVel>1 and y>ystart
  {
    var tEffect;
    tEffect=instance_create(x+2,ystart+4,oEffectGrav)
    tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33
    tEffect.type=1; tEffect.decay=12 tEffect.xSpd=1; tEffect.ySpd=-2; tEffect.grav=0.3; tEffect.image_blend=image_blend
    tEffect.newBlend=-1; tEffect.decay=45; tEffect.followID=-1; tEffect.rotation=0
    tEffect=instance_create(x-2,ystart+4,oEffectGrav)
    tEffect.sprite_index=sEfMarioFireHit; tEffect.image_speed=0.33; tEffect.image_xscale=-1
    tEffect.type=1; tEffect.decay=12 tEffect.xSpd=-1; tEffect.ySpd=-2; tEffect.grav=0.3; tEffect.image_blend=image_blend
    tEffect.newBlend=-1; tEffect.decay=45; tEffect.followID=-1; tEffect.rotation=0
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*glowScl,image_yscale*glowScl,image_angle,image_blend,0.25)
event_inherited()
