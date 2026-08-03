#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: fadeSpd,moveSpd
sparkColor=c_white
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oGame.time mod (2/gDeltaTime)=0
  {
    if sparkColor=c_white {sparkColor=c_gray}
    else {sparkColor=c_white}
  }

  _speed=moveSpd
  image_alpha-=fadeSpd
  
  if image_alpha<=0.75 {instance_destroy()}
}
else {_speed=0}
correctSpeedDirection(self)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(sparkColor)
draw_set_alpha(image_alpha)
draw_rectangle(x,y,x+2,y+2,0)
