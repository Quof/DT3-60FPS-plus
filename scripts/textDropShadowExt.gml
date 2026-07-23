/*
This script will draw text with the dropshadow.
use: textDropShadowExt(string,x,y,text_color,shadow_color,type,height,width)

argument0: string to draw
argument1: x position
argument2: y position
argument3: text color
argument4: shadow color
argument5: type of drop shadow
argument6: line height
argument7: line width
-- 0: below text
-- 1: below to right of text
-- 2: circle text on 4 sides, horizontal/vertical
-- 3: circle text on 4 sides, diagonal
-- 4: circle text on 8 sides
Special Cases
-- 5: enemy info box
*/
var dsTextString,dsTextX,dsTextY,dsTextMainCol,dsTextShadowCol,dsTextType,dsLineHeight,dsLineWidth;
dsTextString=argument0
dsTextX=argument1
dsTextY=argument2
dsTextMainCol=argument3
dsTextShadowCol=argument4
dsTextType=argument5
dsLineHeight=argument6
dsLineWidth=argument7

if dsTextType=0 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text_ext(dsTextX,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_set_color(dsTextMainCol)
  draw_text_ext(dsTextX,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
}
else if dsTextType=1 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text_ext(dsTextX,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX+1,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX+1,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_set_color(dsTextMainCol)
  draw_text_ext(dsTextX,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
}
else if dsTextType=2 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text_ext(dsTextX,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX+1,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX,dsTextY-1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX-1,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
  draw_set_color(dsTextMainCol)
  draw_text_ext(dsTextX,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
}
else if dsTextType=3 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text_ext(dsTextX+1,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX+1,dsTextY-1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX-1,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX-1,dsTextY-1,dsTextString,dsLineHeight,dsLineWidth)
  draw_set_color(dsTextMainCol)
  draw_text_ext(dsTextX,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
}
else if dsTextType=4 //-------------------- BREAK --------------------
{
  draw_set_color(dsTextShadowCol)
  draw_text_ext(dsTextX,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX+1,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX,dsTextY-1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX-1,dsTextY,dsTextString,dsLineHeight,dsLineWidth)

  draw_text_ext(dsTextX+1,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX+1,dsTextY-1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX-1,dsTextY+1,dsTextString,dsLineHeight,dsLineWidth)
  draw_text_ext(dsTextX-1,dsTextY-1,dsTextString,dsLineHeight,dsLineWidth)
  draw_set_color(dsTextMainCol)
  draw_text_ext(dsTextX,dsTextY,dsTextString,dsLineHeight,dsLineWidth)
}
