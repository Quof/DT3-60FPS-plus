//Randomizer: John, and his prompt while it's open: a window drawn as his Turret Defense Game menu is (oTD_GameStart's
//Draw), just over what he says (npcTextBox's box at size 2), kept in the view
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if rjOpen=1
{
  var tW,tH,tX,tY;
  tW=160
  tH=16+2*15
  tX=x-tW/2
  tY=y-16-sprite_height-54-4-tH
  if tX<view_xview[0]+4 {tX=view_xview[0]+4}
  if tX+tW>view_xview[0]+view_wview[0]-4 {tX=view_xview[0]+view_wview[0]-4-tW}
  if tY<view_yview[0]+4 {tY=view_yview[0]+4}
  draw_set_alpha(1)
  draw_set_color(make_color_rgb(0,104,32))
  draw_rectangle(tX,tY,tX+tW,tY+tH,0)
  draw_rectangle(tX+1,tY+1,tX+tW-1,tY+tH-1,1)
  draw_set_color(make_color_rgb(0,37,12))
  draw_rectangle(tX,tY,tX+tW,tY+tH,1)
  draw_line(tX,tY+15,tX+tW,tY+15)
  draw_set_font(fnt_PauseMenuMain)
  draw_set_halign(fa_center)
  textDropShadow("Debug Mode",tX+(tW/2),tY+1,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_left)
  textDropShadow("Turn Debug Mode On",tX+14,tY+18,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  textDropShadow("Cancel",tX+14,tY+33,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  draw_sprite(sPauseM_AbilArrow,0,tX+11,tY+24+rjCur*15)
}
