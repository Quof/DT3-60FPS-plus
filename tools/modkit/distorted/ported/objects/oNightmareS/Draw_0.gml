if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}

if room=rExtGateG_2 //Gate G - Map 2 Map
{
  if mapTime>=30
  {
    draw_sprite(sGG_M2Map,0,view_xview[0]+240,view_yview[0]+96)
  }
}
