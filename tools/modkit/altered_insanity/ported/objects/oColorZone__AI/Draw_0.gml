if checkScreenArea(x,y,240)=1
{
  if zoneColor>=1 and zoneColor<=4 {image_blend=global.czColor[zoneColor]} //color zone change (added): follows the option right away (it can be changed from the pause menu)
  draw_set_color(image_blend)
  draw_set_alpha(innerAlpha)
  draw_rectangle(x,y,x+image_xscale-1,y+image_yscale-1,0)
  draw_set_alpha(0.9)
  draw_rectangle(x,y,x+image_xscale-1,y+image_yscale-1,1)
}
