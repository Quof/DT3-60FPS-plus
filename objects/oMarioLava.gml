#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

image_speed=random(0.1)+0.1

//Enemy base statistics
atkPower=12
damageType="ELEMENTAL"
bCanTakeDamage=false
bShowHealthBar=false

lavaFrm=0
yDraw=-1
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("scaling")
{
  yDraw=scaling
  image_yscale=(scaling+16)/16
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lavaFrm+=image_speed
for(i=0;i<image_xscale;i+=1)
{
  draw_sprite_ext(sLava,lavaFrm,x+(i*16),y,1,1,image_angle,image_blend,image_alpha)
}
if yDraw>0
{
  draw_sprite_part_ext(sLava,0,0,14,1,1,x,y+16,image_xscale*16,yDraw,image_blend,image_alpha)
}
