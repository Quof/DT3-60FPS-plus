#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[12]=1 //Close menu
{
  io_clear()
  resetKeyCodes()
  playSound(global.snd_MenuClose,0,1,1)
  global.gamePaused=false
  oHUD.menuOpen=false
  with oEscapePause {instance_destroy()}
  instance_destroy()
  exit;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//---------- Fade Back ----------
draw_set_color(c_black)
draw_set_alpha(0.33)
draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,false)

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(fnt_Swap)
draw_set_halign(fa_center)
draw_text(view_xview[0]+240,view_yview[0]+168,"PAUSED")
