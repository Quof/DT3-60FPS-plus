#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
bOpened=0
lightCheck="0"

showControls=0
helpTextInner=make_color_rgb(159,132,105)
helpTextOuter=make_color_rgb(28,16,3)

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var lightCheck;
lightCheck=string_char_at(global.gateHLamps,myLight)
if lightCheck="1" {bOpened=1}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{

}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  showControls=2
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_LampOn,0,1,1)
    var tNewString;
    tNewString=string_delete(global.gateHLamps,myLight,1)
    if bOpened=0
    {
      bOpened=1
      tNewString=string_insert("1",tNewString,myLight)
    }
    else
    {
      bOpened=0
      tNewString=string_insert("0",tNewString,myLight)
    }
    global.gateHLamps=tNewString
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if bOpened=1
{
  draw_set_alpha(0.4)
  draw_set_blend_mode(bm_add)
  draw_circle_color(x,y-11,24,make_color_rgb(240,193,64),c_black,false)
  draw_set_blend_mode(bm_normal)
}


if showControls>0
{
  showControls-=1
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_left)
  if bOpened=0
  {
    draw_sprite_ext(sGateH_UI_Arrow,0,x-21,320,1,1,90,c_white,1)
    textDropShadow("TURN ON",x-12,317,helpTextInner,helpTextOuter,4)
  }
  else if bOpened=1
  {
    draw_sprite_ext(sGateH_UI_Arrow,0,x-21,320,1,1,90,c_white,1)
    textDropShadow("TURN OFF",x-12,317,helpTextInner,helpTextOuter,4)
  }
}
