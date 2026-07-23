#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Recognition,0,1,1)
noticeTime=95
textColor=make_color_rgb(3,28,4)
whiteFade=1
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tNewString;
tNewString=string_delete(global.tokenRecognitionsSetTwo,checkNum,1)
tNewString=string_insert("1",tNewString,checkNum)
global.tokenRecognitionsSetTwo=tNewString
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
noticeTime-=1
if noticeTime<=20 {image_alpha-=0.05}
if whiteFade>0 {whiteFade-=0.1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  xView=view_xview[0]+360
  yView=view_yview[0]+20
  draw_sprite_ext(sAchievementPopup,0,xView,yView,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_set_color(textColor)
  draw_set_font(fnt_Achievement)
  draw_set_alpha(image_alpha)
  draw_set_halign(fa_left)
  draw_text(xView-62,yView-2,myAchievement)
  if whiteFade>0 {draw_sprite_ext(sAchieveMask,0,xView,yView,image_xscale,image_yscale,image_angle,c_white,whiteFade)}
}
