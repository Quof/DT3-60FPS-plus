/*
This script is called in the HUD pause menu and is an extension of it
It is used to display the map details on collectibles
*/
if global.bNightmareMode=0
{
  detailMenuX=view_xview[0]+22
  detailMenuY=view_yview[0]+10
  draw_sprite(sPauseM_MapHelp,0,detailMenuX,detailMenuY)
  checkItemPercent(3)
  draw_set_font(fnt_PauseMenuMain)
  draw_set_halign(fa_center)
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_HeartP=0
  {
    draw_rectangle(detailMenuX+24,detailMenuY+18,detailMenuX+37,detailMenuY+32,0)
    textDropShadow("?",detailMenuX+31,detailMenuY+19,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_Chest=0
  {
    draw_rectangle(detailMenuX+9,detailMenuY+37,detailMenuX+37,detailMenuY+60,0)
    textDropShadow("?",detailMenuX+24,detailMenuY+42,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_Arrow=0
  {
    draw_rectangle(detailMenuX+19,detailMenuY+65,detailMenuX+37,detailMenuY+82,0)
    textDropShadow("?",detailMenuX+29,detailMenuY+67,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_HeartE=0
  {
    draw_rectangle(detailMenuX+22,detailMenuY+87,detailMenuX+37,detailMenuY+99,0)
    textDropShadow("?",detailMenuX+30,detailMenuY+86,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_Missile=0
  {
    draw_rectangle(detailMenuX+22,detailMenuY+104,detailMenuX+37,detailMenuY+119,0)
    textDropShadow("?",detailMenuX+30,detailMenuY+105,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_Ki=0
  {
    draw_rectangle(detailMenuX+24,detailMenuY+124,detailMenuX+37,detailMenuY+137,0)
    textDropShadow("?",detailMenuX+31,detailMenuY+124,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_Air=0
  {
    draw_rectangle(detailMenuX+23,detailMenuY+142,detailMenuX+37,detailMenuY+156,0)
    textDropShadow("?",detailMenuX+31,detailMenuY+142,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_Wallet=0
  {
    draw_rectangle(detailMenuX+24,detailMenuY+161,detailMenuX+37,detailMenuY+176,0)
    textDropShadow("?",detailMenuX+31,detailMenuY+162,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_Weapon=0
  {
    draw_rectangle(detailMenuX+22,detailMenuY+181,detailMenuX+37,detailMenuY+196,0)
    textDropShadow("?",detailMenuX+30,detailMenuY+182,textColorMain,textColorShadow,1)
  }
  draw_set_color(make_color_rgb(8,184,112))
  if itemC_AP=0
  {
    draw_rectangle(detailMenuX+16,detailMenuY+201,detailMenuX+37,detailMenuY+218,0)
    textDropShadow("?",detailMenuX+27,detailMenuY+203,textColorMain,textColorShadow,1)
  }
  draw_set_halign(fa_left)
  textDropShadow(string(coll_HeartP) +string(" / ") +string(max_HeartP),detailMenuX+44,detailMenuY+22,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_Chest) +string(" / ") +string(max_Chest),detailMenuX+44,detailMenuY+50,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_Arrow) +string(" / ") +string(max_Arrow),detailMenuX+44,detailMenuY+72,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_HeartE) +string(" / ") +string(max_HeartE),detailMenuX+44,detailMenuY+89,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_Missile) +string(" / ") +string(max_Missile),detailMenuX+44,detailMenuY+109,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_Ki) +string(" / ") +string(max_Ki),detailMenuX+44,detailMenuY+127,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_Air) +string(" / ") +string(max_Air),detailMenuX+44,detailMenuY+146,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_Wallet) +string(" / ") +string(max_Wallet),detailMenuX+44,detailMenuY+166,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_Weapon) +string(" / ") +string(max_Weapon),detailMenuX+44,detailMenuY+186,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_AP) +string(" / ") +string(max_AP),detailMenuX+44,detailMenuY+208,textColorMain,textColorShadow,1)
  textDropShadow(string(coll_Extra) +string(" / ") +string(max_Extra),detailMenuX+44,detailMenuY+227,textColorMain,textColorShadow,1)
}
