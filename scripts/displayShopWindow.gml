/*
This script displays the shop window.
*/

var tColorTop,tColorBack,tColorBorder,tColorInfo,tColorShop,tColorTextA,tColorTextB;
tColorTop=make_color_rgb(12,16,15)
tColorBack=make_color_rgb(28,52,62)
tColorBorder=make_color_rgb(117,121,156)
tColorInfo=make_color_rgb(10,32,45)
tColorShop=make_color_rgb(180,191,255)
tColorTextA=make_color_rgb(240,240,240)
tColorTextB=make_color_rgb(255,169,4)

shopWinX=view_xview[0]+80
shopWinY=view_yview[0]+51

draw_set_alpha(0.5)
draw_set_color(tColorBack)
draw_rectangle(shopWinX,shopWinY,shopWinX+319,shopWinY+239,0) //50% full window back
draw_sprite(sShopInternetzDisplay,0,shopWinX+183,shopWinY+212) //Internetz display
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(shopWinX,shopWinY,shopWinX+319,shopWinY+16,0) //top margin
draw_rectangle(shopWinX,shopWinY,shopWinX+319,shopWinY+239,1) //full window border
draw_set_color(tColorBorder)
draw_rectangle(shopWinX+2,shopWinY+2,shopWinX+317,shopWinY+237,1) //blue full window border (slight inset)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(shopWinX+8,shopWinY+3,"ITEM SHOP")
draw_set_alpha(0.2)
draw_rectangle(shopWinX+10,shopWinY+23,shopWinX+169,shopWinY+230,0) //item list fill
draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(shopWinX+183,shopWinY+23,shopWinX+310,shopWinY+208,0) //equipment info fill
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(shopWinX+10,shopWinY+23,shopWinX+169,shopWinY+230,1) //item list border
draw_rectangle(shopWinX+183,shopWinY+23,shopWinX+310,shopWinY+208,1) //equipment info border
draw_set_color(make_color_rgb(30,33,40))
draw_rectangle(shopWinX+1,shopWinY+233,shopWinX+318,shopWinY+234,0) //bottom margin 1
draw_set_color(make_color_rgb(26,49,54))
draw_rectangle(shopWinX+1,shopWinY+235,shopWinX+318,shopWinY+238,0) //bottom margin 2
draw_line_color(shopWinX+2,shopWinY+233,shopWinX+2,shopWinY+237,make_color_rgb(95,99,127),make_color_rgb(65,67,85))
draw_line_color(shopWinX+317,shopWinY+233,shopWinX+317,shopWinY+237,make_color_rgb(95,99,127),make_color_rgb(65,67,85))

draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(shopWinX+16,shopWinY+33,shopWinX+162,shopWinY+64,0) //item 1
draw_rectangle(shopWinX+16,shopWinY+72,shopWinX+162,shopWinY+103,0) //item 2
draw_rectangle(shopWinX+16,shopWinY+111,shopWinX+162,shopWinY+142,0) //item 3
draw_rectangle(shopWinX+16,shopWinY+150,shopWinX+162,shopWinY+181,0) //item 4
draw_rectangle(shopWinX+16,shopWinY+189,shopWinX+162,shopWinY+220,0) //item 5
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(shopWinX+16,shopWinY+33,shopWinX+162,shopWinY+64,1) //item 1
draw_rectangle(shopWinX+16,shopWinY+72,shopWinX+162,shopWinY+103,1) //item 2
draw_rectangle(shopWinX+16,shopWinY+111,shopWinX+162,shopWinY+142,1) //item 3
draw_rectangle(shopWinX+16,shopWinY+150,shopWinX+162,shopWinY+181,1) //item 4
draw_rectangle(shopWinX+16,shopWinY+189,shopWinX+162,shopWinY+220,1) //item 5
draw_rectangle(shopWinX+19,shopWinY+36,shopWinX+44,shopWinY+61,0)
draw_rectangle(shopWinX+19,shopWinY+75,shopWinX+44,shopWinY+100,0)
draw_rectangle(shopWinX+19,shopWinY+114,shopWinX+44,shopWinY+139,0)
draw_rectangle(shopWinX+19,shopWinY+153,shopWinX+44,shopWinY+178,0)
draw_rectangle(shopWinX+19,shopWinY+192,shopWinX+44,shopWinY+217,0)
draw_set_color(tColorTextB)
draw_rectangle(shopWinX+19,shopWinY+36,shopWinX+44,shopWinY+61,1)
draw_rectangle(shopWinX+19,shopWinY+75,shopWinX+44,shopWinY+100,1)
draw_rectangle(shopWinX+19,shopWinY+114,shopWinX+44,shopWinY+139,1)
draw_rectangle(shopWinX+19,shopWinY+153,shopWinX+44,shopWinY+178,1)
draw_rectangle(shopWinX+19,shopWinY+192,shopWinX+44,shopWinY+217,1)

//bottom NPC text area
draw_set_alpha(0.75)
draw_set_color(tColorBack)
draw_rectangle(shopWinX,shopWinY+240,shopWinX+319,shopWinY+277,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(shopWinX,shopWinY+240,shopWinX+319,shopWinY+277,1)
draw_set_font(fnt_Points)
textDropShadowExt(shopText,shopWinX+3,shopWinY+240,tColorTextA,tColorTop,4,12,314)

//display items
for(i=0;i<5;i+=1)
{
  if stock[i,0]>0
  {
    if object_index=oShopWindow
      draw_sprite(sEquipItemIcons,stock[i,4]-1,shopWinX+32,shopWinY+49+(i*39)) //item icon
    else if object_index=oExtraShopWindow
      draw_sprite(sPauseM_ExtraItemIcons,stock[i,4]-1,shopWinX+32,shopWinY+49+(i*39))
    draw_set_font(fnt_EnemyName)
    textDropShadow(stock[i,1],shopWinX+48,shopWinY+34+(i*39),tColorTextA,tColorTop,4) //item name
    draw_set_font(fnt_Points)
    if bCanBuy[i]="0" //check item stock
      textDropShadow(string(stock[i,2]) +string("     Internetz"),shopWinX+48,shopWinY+50+(i*39),tColorTextB,tColorTop,4)
    else
      textDropShadow("Out of stock",shopWinX+48,shopWinY+50+(i*39),tColorTextB,tColorTop,4)
  }
}

//display item info
draw_set_color(tColorTop)
draw_rectangle(shopWinX+235,shopWinY+28,shopWinX+260,shopWinY+53,0) //item icon box
draw_set_color(tColorTextB)
draw_rectangle(shopWinX+235,shopWinY+28,shopWinX+260,shopWinY+53,1)
if stock[cursorPos-1,0]>0
{
  if object_index=oShopWindow
    draw_sprite(sEquipItemIcons,stock[cursorPos-1,4]-1,shopWinX+248,shopWinY+41) //item icon
  else if object_index=oExtraShopWindow
    draw_sprite(sPauseM_ExtraItemIcons,stock[cursorPos-1,4]-1,shopWinX+248,shopWinY+41)
  draw_set_halign(fa_middle)
  draw_set_font(fnt_EnemyName)
  textDropShadow(stock[cursorPos-1,1],shopWinX+247,shopWinY+57,tColorTextA,tColorTop,4) //item name
  draw_set_font(fnt_Points)
  if bCanBuy[cursorPos-1]="0"
    textDropShadow(string(stock[cursorPos-1,2]) +string("     Internetz"),shopWinX+247,shopWinY+71,tColorTextB,tColorTop,4)
  else
    textDropShadow("Out of stock",shopWinX+247,shopWinY+71,tColorTextB,tColorTop,4)
  draw_set_halign(fa_left)
  textDropShadowExt(stock[cursorPos-1,3],shopWinX+187,shopWinY+90,tColorTextA,tColorTop,4,13,120)
}

//display internetz
textDropShadow(oPlayer1.currentMoney,shopWinX+252,shopWinY+215,tColorTextA,tColorTop,4)

//display cursor
draw_set_color(tColorTextB)
draw_rectangle(shopWinX+cursorX,shopWinY+cursorY,shopWinX+cursorX+148,shopWinY+cursorY+33,1)
