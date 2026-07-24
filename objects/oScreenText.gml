#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if textTime!=-1
{
  if global.gamePaused=false
    textTime-=1*gDeltaTime

  if textTime>=1 and textTime<=25
    image_alpha-=0.04*gDeltaTime
  if textTime=0
    instance_destroy()
}

if textType=1 //Marquee
{
  textWidth=string_width(screenText)
  x-=2*gDeltaTime
  if followType=0
  {
    if x<=-(string_width(screenText)*2)-4
      instance_destroy()
  }
  else if followType=1
  {
    if x<=-(string_width(screenText)*2)-4
      instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
textTime    - Time on screen, -1 if infinite
textFont    - Font to use
textAlign   - Text alignment
screenText  - Text to draw
dropStyle   - Dropshadow type
textType    - 0: Normal, 1: Marquee
followType  - 0: World Absolute, 1: Screen Local
image_blend - Inner text color
*/
draw_set_font(textFont)
draw_set_halign(textAlign)
draw_set_alpha(image_alpha)
if followType=0
  textDropShadow(screenText,x,y,image_blend,c_black,dropStyle)
else if followType=1
  textDropShadow(screenText,view_xview[0]+x,view_yview[0]+y,image_blend,c_black,dropStyle)
