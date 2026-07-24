#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.1
tutorialTime=0
textColorMain=make_color_rgb(255,248,155)
initObj=0
scrAreaX=368
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("xChange") {scrAreaX=xChange}
initObj=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initObj=1
{
  tutorialTime+=1*gDeltaTime
  if tutorialTime>=1 and tutorialTime<=9
    image_alpha+=0.1*gDeltaTime
  else if tutorialTime>=360
  {
    image_alpha-=0.1*gDeltaTime
    if image_alpha=0
      instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initObj=1
{
  xx=view_xview[0]+scrAreaX
  if scrAreaY=0
    yy=view_yview[0]+5
  else if scrAreaY=1
    yy=view_yview[0]+251
  draw_sprite_ext(sprite_index,0,xx,yy,1,1,0,c_white,image_alpha)
  draw_set_font(fnt_HUDnum)
  draw_set_alpha(image_alpha)
  draw_set_halign(fa_middle)
  textDropShadowExt(tutorialTitle,xx,yy+1,textColorMain,c_black,1,13,190)
  draw_set_halign(fa_left)
  draw_set_font(fnt_EnemyName)
  textDropShadowExt(tutorialInfo,xx-94,yy+19,textColorMain,c_black,1,13,190)
}
