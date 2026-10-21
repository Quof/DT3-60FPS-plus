//Randomizer: the sign, ONE over WAY, just above its exit's arrow and to its left (the exit's arrowX: the arrow's middle,
//arrowY: its top, as the exit draws it, bobbing with it), while the exit shows its arrow; a pipe's (it has none) in the
//middle of where its arrow would be, all the time. Kept inside the room: most of these exits are at a room's side, and
//the view ends there (one at the left side has it to the arrow's right)
var tW,tH,tX,tY;
if !instance_exists(exitId) {instance_destroy(); exit}
if exitId.bShowArrow=true or pipe=1
{
  draw_set_alpha(1)
  draw_set_font(fnt_EnemyName)
  draw_set_halign(fa_center)
  draw_set_valign(fa_bottom)
  //(WAY, the wider line, ending at the arrow's middle; textDropShadow's outline is a pixel more each side)
  tW=string_width("WAY")
  tH=string_height("WAY")
  tX=floor(exitId.arrowX-tW/2)
  if pipe=1 {tX=floor(exitId.arrowX)}
  tX=min(max(tX,ceil(tW/2)+2),floor(room_width-tW/2)-2)
  tY=exitId.arrowY-2
  textDropShadow("ONE",tX,tY-tH,make_color_rgb(255,224,120),c_black,4)
  textDropShadow("WAY",tX,tY,make_color_rgb(255,224,120),c_black,4)
  draw_set_halign(fa_left)
  draw_set_valign(fa_top)
}
