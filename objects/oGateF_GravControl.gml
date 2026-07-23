#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lowGravOn=0
lowGravTime=0

colorUp=1
lowGravColor=160
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if lowGravOn=1
  {
    if lowGravTime>0
    {
      lowGravTime-=1
      if lowGravTime=0
      {
        oPlayer1.grav=1.2
        colorUp=1
        lowGravColor=160
        lowGravOn=0
        lowGravTime=0
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lowGravOn=1
{
  draw_set_alpha(0.25)
  if colorUp=0
  {
    lowGravColor-=5
    if lowGravColor<=160 {colorUp=1}
  }
  else
  {
    lowGravColor+=5
    if lowGravColor>=255 {colorUp=0}
  }
  draw_set_color(make_color_rgb(0,lowGravColor,lowGravColor))
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)

  if room!=rExtGateF_6
  {
    draw_set_font(fnt_Timer)
    draw_set_halign(fa_left)
    draw_set_alpha(1)
    textDropShadow(lowGravTime,view_xview[0]+412,view_yview[0]+8,c_black,c_white,3)
  }
}
