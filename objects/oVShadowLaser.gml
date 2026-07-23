#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_xscale=0.1
image_yscale=0.1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
lifeTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  lifeTime+=1
  if lifeTime>=1 and lifeTime<=10
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sBelmontWepEffect; tEffect.image_speed=0.6+random(0.1)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
  else if lifeTime>=11 and lifeTime<=34
  {
    speed=0
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sBelmontWepEffect; tEffect.image_speed=0.6+random(0.1)
    tEffect.speed=1+random(2); tEffect.direction=random(360)
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
  if lifeTime=35
  {
    bCanDealDamage=true
    direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
  }

  if lifeTime>=1 and lifeTime<=10 {speed=8}
  else if lifeTime>=35 {speed=17}
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>=50 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>36 //Trail
{
  draw_set_blend_mode(bm_add)
  draw_line_width_color(x,y,x+lengthdir_x(80,direction-180),y+lengthdir_y(80,direction-180),2,c_teal,c_black)
  draw_set_blend_mode(bm_normal)
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
