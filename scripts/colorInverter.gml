/*
This script inverts the colors of the designated area.
Use in draw event.
argument0: type: 0-rectangle, 1-circle
argument1: if rectangle-width, if circle-radius
argument2: if rectangle-height, if circle-not used
*/
var tType,tWidth,tHeight;
tType=argument0
tWidth=argument1
tHeight=argument2

draw_set_color(c_white)
draw_set_blend_mode_ext(bm_inv_dest_color,bm_zero)
if tType=0
  draw_rectangle(x,y,x+tWidth,y+tHeight,0)
else if tType=1
  draw_circle(x,y,tWidth,0)
draw_set_blend_mode(bm_normal)
