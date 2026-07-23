/*
This script will draw text with the dropshadow.
use: textDropShadow(string,x,y,text_color,shadow_color,type)

argument0: string to draw
argument1: x position
argument2: y position
argument3: text color
argument4: shadow color
argument5: type of drop shadow
-- 0: below text
-- 1: below to right of text
-- 2: circle text on 4 sides, horizontal/vertical
-- 3: circle text on 4 sides, diagonal
-- 4: circle text on 8 sides
*/
var dsTextString,dsTextX,dsTextY,dsTextMainCol,dsTextShadowCol,dsTextType;
dsTextString=argument0
dsTextX=argument1
dsTextY=argument2
dsTextMainCol=argument3
dsTextShadowCol=argument4
dsTextType=argument5

if dsTextType=0 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text(dsTextX,dsTextY+1,dsTextString)
  draw_set_color(dsTextMainCol)
  draw_text(dsTextX,dsTextY,dsTextString)
}
else if dsTextType=1 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text(dsTextX,dsTextY+1,dsTextString)
  draw_text(dsTextX+1,dsTextY,dsTextString)
  draw_text(dsTextX+1,dsTextY+1,dsTextString)
  draw_set_color(dsTextMainCol)
  draw_text(dsTextX,dsTextY,dsTextString)
}
else if dsTextType=2 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text(dsTextX,dsTextY+1,dsTextString)
  draw_text(dsTextX+1,dsTextY,dsTextString)
  draw_text(dsTextX,dsTextY-1,dsTextString)
  draw_text(dsTextX-1,dsTextY,dsTextString)
  draw_set_color(dsTextMainCol)
  draw_text(dsTextX,dsTextY,dsTextString)
}
else if dsTextType=3 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text(dsTextX+1,dsTextY+1,dsTextString)
  draw_text(dsTextX+1,dsTextY-1,dsTextString)
  draw_text(dsTextX-1,dsTextY+1,dsTextString)
  draw_text(dsTextX-1,dsTextY-1,dsTextString)
  draw_set_color(dsTextMainCol)
  draw_text(dsTextX,dsTextY,dsTextString)
}
else if dsTextType=4 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text(dsTextX,dsTextY+1,dsTextString)
  draw_text(dsTextX+1,dsTextY,dsTextString)
  draw_text(dsTextX,dsTextY-1,dsTextString)
  draw_text(dsTextX-1,dsTextY,dsTextString)

  draw_text(dsTextX+1,dsTextY+1,dsTextString)
  draw_text(dsTextX+1,dsTextY-1,dsTextString)
  draw_text(dsTextX-1,dsTextY+1,dsTextString)
  draw_text(dsTextX-1,dsTextY-1,dsTextString)
  draw_set_color(dsTextMainCol)
  draw_text(dsTextX,dsTextY,dsTextString)
}
