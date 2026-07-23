/*
This script will draw colored text with the dropshadow.
use: textDropColor(string,x,y,top_color,bottom_color,shadow_color,text_alpha)

argument0: string to draw
argument1: x position
argument2: y position
argument3: text top color
argument4: text bottom color
argument5: shadow color
argument6: text alpha
*/
var dsTextString,dsTextX,dsTextY,dsTextTopCol,dsTextBottomCol,dsTextShadowCol,dsTextAlpha;
dsTextString=argument0
dsTextX=argument1
dsTextY=argument2
dsTextTopCol=argument3
dsTextBottomCol=argument4
dsTextShadowCol=argument5
dsTextAlpha=argument6

draw_set_color(dsTextShadowCol)
draw_text(dsTextX,dsTextY+1,dsTextString)
draw_text(dsTextX+1,dsTextY,dsTextString)
draw_text(dsTextX,dsTextY-1,dsTextString)
draw_text(dsTextX-1,dsTextY,dsTextString)

draw_text(dsTextX+1,dsTextY+1,dsTextString)
draw_text(dsTextX+1,dsTextY-1,dsTextString)
draw_text(dsTextX-1,dsTextY+1,dsTextString)
draw_text(dsTextX-1,dsTextY-1,dsTextString)
draw_text_color(dsTextX,dsTextY,dsTextString,dsTextTopCol,dsTextTopCol,dsTextBottomCol,dsTextBottomCol,dsTextAlpha)
