#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=288

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
laserProg=0
effectDelay=9
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  effectDelay+=1
  if effectDelay mod 10=0
  {
    var tFFScl,tEffect;
    for(i=0;i<19;i+=1)
    {
      tFFScl=random(0.1)
      tEffect=instance_create(x+lengthdir_x(16*i,image_angle),y+lengthdir_y(16*i,image_angle),oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
      tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
      tEffect.fadeSpd=0.1; tEffect.image_blend=c_teal
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
  }

  tFFScl=random(0.1)
  tEffect=instance_create(x+lengthdir_x(288,image_angle),y+lengthdir_y(288,image_angle),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
  tEffect.image_xscale=0.3+tFFScl; tEffect.image_yscale=0.3+tFFScl
  tEffect.fadeSpd=0.1; tEffect.image_blend=c_teal
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0

  laserProg+=1
  if laserProg>=10
  {
    instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
