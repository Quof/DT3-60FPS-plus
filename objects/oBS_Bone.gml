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
bDestroy=0
grav=0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if xSpd>0
    image_angle-=10
  else if xSpd<0
    image_angle+=10

  ySpd+=grav
  if ySpd>7
    ySpd=7

  x+=xSpd
  y+=ySpd

  if y>room_height+32
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,1.5,1.5,image_angle,c_yellow,0.33)
draw_sprite_ext(sprite_index,image_index,x,y,1.25,1.25,image_angle,c_yellow,0.66)
draw_self()
