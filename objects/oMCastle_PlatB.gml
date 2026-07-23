#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
distToGo=100
myColor=255
deathCheck=0
image_xscale=0.2; image_yscale=0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Move the platform continuously in one direction
if global.gamePaused=false
{
  if image_xscale<1 {image_xscale+=0.2; image_yscale+=0.2}
  distToGo-=1
  if distToGo<=30 {myColor-=7}
  if distToGo<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,make_color_rgb(myColor,myColor,255),image_alpha)
