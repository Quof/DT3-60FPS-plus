#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showControls=0
helpTextInner=make_color_rgb(159,132,105)
helpTextOuter=make_color_rgb(28,16,3)
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
    global.newMapX=x; global.newMapY=304
    saveData()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if showControls>0
{
  showControls-=1
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_left)
  draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+37,1,1,90,c_white,1)
  textDropShadow("SAVE",x-12,y+34,helpTextInner,helpTextOuter,4)
}
