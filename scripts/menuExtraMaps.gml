/*
This script is an extension of the map submenu
It is used to display other maps
argument0: Which map to display
*/
var tExtraMap,tShowPos;
tExtraMap=argument0
tShowPos=0

if tExtraMap=2 //==================== Gate 2 - Forest Palace ====================
{
  draw_sprite(sPauseM_MapExt2,0,contentMenuX+141,contentMenuY+79)
  area_Name="G2 - Forest Palace"
  menuInfoText="A confusing and twisted palace overtaken by an evil curse."
  //---------- Black out areas the player has not gone to ----------
  draw_set_color(make_color_rgb(8,184,112))
  var tMcX,tMcY,tMapX,tMapY,tMSpc;
  tMapX=13; tMapY=23; tMSpc=8
  tMcX=contentMenuX+tMapX; tMcY=contentMenuY+tMapY
  if mapExtIndex2[2]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*18),tMcY+(tMSpc*8))
  if mapExtIndex2[3]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*20),tMcY+(tMSpc*9))
  if mapExtIndex2[4]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*20),tMcY+(tMSpc*7))
  if mapExtIndex2[5]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*22),tMcY+(tMSpc*7))
  if mapExtIndex2[6]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc*2,tMcX+(tMSpc*18),tMcY+(tMSpc*10))
  if mapExtIndex2[7]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*17),tMcY+(tMSpc*11))
  if mapExtIndex2[8]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*18),tMcY+(tMSpc*7))
  if mapExtIndex2[9]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*16),tMcY+(tMSpc*7))
  if mapExtIndex2[10]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*20),tMcY+(tMSpc*11))
  if mapExtIndex2[11]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc*2,tMSpc,tMcX+(tMSpc*21),tMcY+(tMSpc*11))
  if mapExtIndex2[12]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*23),tMcY+(tMSpc*11))
  //---------- Display location ----------
  var tMapLocX,tMapLocY;
  tMapLocX=tMapX; tMapLocY=tMapY
  if room=rLink2_PalaceF_1 {tMapLocX+=tMSpc*17; tMapLocY+=tMSpc*10; tShowPos=1}
  else if room=rLink2_PalaceF_2a or room=rLink2_PalaceF_2b {tMapLocX+=tMSpc*19; tMapLocY+=tMSpc*9; tShowPos=1}
  else if room=rLink2_PalaceF_3 {tMapLocX+=tMSpc*21; tMapLocY+=tMSpc*10; tShowPos=1}
  else if room=rLink2_PalaceF_4a or room=rLink2_PalaceF_4b {tMapLocX+=tMSpc*21; tMapLocY+=tMSpc*8; tShowPos=1}
  else if room=rLink2_PalaceF_5 {tMapLocX+=tMSpc*23; tMapLocY+=tMSpc*8; tShowPos=1}
  else if room=rLink2_PalaceF_6a or room=rLink2_PalaceF_6b {tMapLocX+=tMSpc*19; tMapLocY+=tMSpc*11; tShowPos=1}
  else if room=rLink2_PalaceF_7 {tMapLocX+=tMSpc*18; tMapLocY+=tMSpc*12; tShowPos=1}
  else if room=rLink2_PalaceF_8 {tMapLocX+=tMSpc*19; tMapLocY+=tMSpc*8; tShowPos=1}
  else if room=rLink2_PalaceF_9 {tMapLocX+=tMSpc*17; tMapLocY+=tMSpc*8; tShowPos=1}
  else if room=rLink2_PalaceF_10 {tMapLocX+=tMSpc*21; tMapLocY+=tMSpc*12; tShowPos=1}
  else if room=rLink2_PalaceF_11 {tMapLocX+=tMSpc*22; tMapLocY+=tMSpc*12; tShowPos=1}
  else if room=rLink2_PalaceF_12 {tMapLocX+=tMSpc*24; tMapLocY+=tMSpc*12; tShowPos=1}
}
else if tExtraMap=3 //==================== Gate 3 - Water Palace ====================
{
  draw_sprite(sPauseM_MapExt3,0,contentMenuX+141,contentMenuY+95)
  area_Name="G2 - Water Palace"
  menuInfoText="A place hated by many and loved by very few. There are many who wonder why such a place would ever exist; They never knew the torment of its creator."
  //---------- Black out areas the player has not gone to ----------
  draw_set_color(make_color_rgb(8,184,112))
  var tMcX,tMcY,tMapX,tMapY,tMSpc;
  tMapX=13; tMapY=23; tMSpc=8
  tMcX=contentMenuX+tMapX; tMcY=contentMenuY+tMapY
  if mapExtIndex3[2]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*17),tMcY+(tMSpc*9))
  if mapExtIndex3[3]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*18),tMcY+(tMSpc*9))
  if mapExtIndex3[4]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*19),tMcY+(tMSpc*9))
  if mapExtIndex3[5]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*18),tMcY+(tMSpc*10))
  if mapExtIndex3[6]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*19),tMcY+(tMSpc*10))
  if mapExtIndex3[7]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*20),tMcY+(tMSpc*10))
  if mapExtIndex3[8]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*20),tMcY+(tMSpc*9))
  if mapExtIndex3[9]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*21),tMcY+(tMSpc*10))
  if mapExtIndex3[10]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*22),tMcY+(tMSpc*10))
  if mapExtIndex3[11]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*21),tMcY+(tMSpc*9))
  if mapExtIndex3[12]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*23),tMcY+(tMSpc*10))
  if mapExtIndex3[13]="0" draw_sprite_part(sPauseM_MapGrid,0,8,9,tMSpc,tMSpc,tMcX+(tMSpc*24),tMcY+(tMSpc*10))
  //---------- Display location ----------
  var tMapLocX,tMapLocY;
  tMapLocX=tMapX; tMapLocY=tMapY
  if room=rLink2_PalaceW_1 {tMapLocX+=tMSpc*17; tMapLocY+=tMSpc*10; tShowPos=1}
  else if room=rLink2_PalaceW_2 {tMapLocX+=tMSpc*18; tMapLocY+=tMSpc*10; tShowPos=1}
  else if room=rLink2_PalaceW_3 {tMapLocX+=tMSpc*19; tMapLocY+=tMSpc*10; tShowPos=1}
  else if room=rLink2_PalaceW_4 {tMapLocX+=tMSpc*20; tMapLocY+=tMSpc*10; tShowPos=1}
  else if room=rLink2_PalaceW_5 {tMapLocX+=tMSpc*19; tMapLocY+=tMSpc*11; tShowPos=1}
  else if room=rLink2_PalaceW_6 {tMapLocX+=tMSpc*20; tMapLocY+=tMSpc*11; tShowPos=1}
  else if room=rLink2_PalaceW_7 {tMapLocX+=tMSpc*21; tMapLocY+=tMSpc*11; tShowPos=1}
  else if room=rLink2_PalaceW_8 {tMapLocX+=tMSpc*21; tMapLocY+=tMSpc*10; tShowPos=1}
  else if room=rLink2_PalaceW_9 {tMapLocX+=tMSpc*22; tMapLocY+=tMSpc*11; tShowPos=1}
  else if room=rLink2_PalaceW_10 {tMapLocX+=tMSpc*23; tMapLocY+=tMSpc*11; tShowPos=1}
  else if room=rLink2_PalaceW_11 {tMapLocX+=tMSpc*22; tMapLocY+=tMSpc*10; tShowPos=1}
  else if room=rLink2_PalaceW_12 {tMapLocX+=tMSpc*24; tMapLocY+=tMSpc*11; tShowPos=1}
  else if room=rLink2_PalaceW_13 {tMapLocX+=tMSpc*25; tMapLocY+=tMSpc*11; tShowPos=1}
}

if tShowPos=1 //Draw location
{
  mMap_FrameCount+=1
  if mMap_FrameCount mod 6=0
  {
    mMap_CurFrame+=1
    if mMap_CurFrame=4
      mMap_CurFrame=0
  }
  draw_sprite(sPauseM_MapLoc,mMap_CurFrame,contentMenuX+tMapLocX-4,contentMenuY+tMapLocY-4)
}
draw_set_color(textColorMain)
draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_left)
draw_text(infoMenuX+87,infoMenuY+2,">>" +string(area_Name))
