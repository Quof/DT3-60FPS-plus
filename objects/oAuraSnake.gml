#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=6
size=2
direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
moveSpd=3.25
turnSpd=2.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  var tEffect,tRan;
  tRan=random_range(-4,4)
  tEffect=instance_create(x+lengthdir_x(40,direction-180+tRan),y+lengthdir_y(40,direction-180+tRan),oEffect)
  tEffect.sprite_index=sE_Ef_ASPart; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_angle=choose(0,90,180,270)
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.2

  speed=moveSpd
  turn_toward_direction(point_direction(x,y,oPlayer1.x,oPlayer1.y-26),turnSpd)
  image_angle=direction
}
else {speed=0}
