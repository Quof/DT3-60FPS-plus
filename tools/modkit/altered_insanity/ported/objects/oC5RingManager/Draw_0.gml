  draw_set_alpha(1)
  draw_set_font(fnt_HUDnum)
  draw_set_halign(fa_left)
if ringColl>0
{
  
  draw_sprite_ext(sReachRingRed,0,view_xview[0]+400,view_yview[0]+18,0.4,0.4,0,c_white,1)
  if (ringMax != 1000)
  {
  textDropShadow(string(ringColl) +string("/") +string(ringMax),view_xview[0]+410,view_yview[0]+9,c_white,c_black,1)
}
  else
  {
    textDropShadow(string(ringColl),view_xview[0]+410,view_yview[0]+9,c_white,c_black,1)
  }
}

if (ringMax = 1000)
{
    textDropShadow("Prev: " + string(prevRings),view_xview[0]+410,view_yview[0]+49,c_white,c_black,1)
}

textDropShadow(string(index),view_xview[0]+410,view_yview[0]+59,c_white,c_black,1)
