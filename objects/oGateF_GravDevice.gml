#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=2
image_speed=0
animate=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oGateF_GravControl.lowGravOn=0
  {
    image_index=0
  }
  else
  {
    //Animate
    animate+=1
    if animate>=1 and animate<=10 {image_index=1}
    else if animate>=11 and animate<=20 {image_index=2}
    if animate>=21
    {
      image_index=3
      if animate>=30 {animate=0}
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  if oGateF_GravControl.lowGravOn=0
  {
    oPlayer1.grav=0.75
    oGateF_GravControl.lowGravTime=180
    oGateF_GravControl.lowGravOn=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x+32,y,-1,1,image_angle,image_blend,image_alpha)
