#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bCostDisplayed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //----- Check player distance -----
  myDist=point_distance(x,y-16,oPlayer1.x,oPlayer1.y-16)
  if myDist<32
  {
    oTD_HUD.bCanConstruct=0
    oTD_HUD.bCanBaseUpgrade=1
    bCostDisplayed=1
  }
  else {bCostDisplayed=0}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if bCostDisplayed=1
{
  draw_set_alpha(1)
  draw_set_color(make_color_rgb(64,40,24))
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_center)
  textDropShadow(string("Repair 1 Stability#<") +string(oTD_HUD.recoverCost) +string(">"),x,y-80,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
}

if oTD_HUD.repairCooldown>0
{
  draw_set_alpha(1)
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_middle)
  textDropShadow(string("Repair Cooldown#<") +string(oTD_HUD.repairCooldown) +string(">"),x,y+16,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
}
