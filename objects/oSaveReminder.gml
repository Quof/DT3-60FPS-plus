#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_hspeed=random_range(-2,2)
_vspeed=-random_range(3,4)
dispTime=10
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_vspeed=scrGravAcc(_vspeed,0.2,-1) //gravity is added in Draw, after the move: second half after the move, Draw line kept for 30fps (see scrGravAcc)
correctHSpeedVSpeed(self)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaTime==1 {_vspeed+=0.2}
draw_set_halign(fa_center)
draw_set_alpha(image_alpha)
draw_set_font(fnt_HUDnum)
textDropShadow("Don't forget to save!",x,y,c_white,c_black,2)

dispTime-=1*gDeltaTime
if dispTime<=0
{
  image_alpha-=0.04*gDeltaTime
  if image_alpha<=0 {instance_destroy()}
}
