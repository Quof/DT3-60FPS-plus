#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
imageScaling=0.9
image_xscale=imageScaling
image_yscale=imageScaling
image_speed=0.5
image_blend=make_color_rgb(16,16,16)
moveSpd=1

armAngle=0
moveWave=pi/2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=moveSpd

  //Arm angle
  moveWave+=pi/60
  armAngle+=sin(moveWave)/2
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sClaireMotherArm,image_index,x-(2*image_xscale),y-42,image_xscale,image_yscale,armAngle,image_blend,image_alpha)
