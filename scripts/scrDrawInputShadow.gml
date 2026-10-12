/*
input text change (added): textDropShadow/textDropShadowExt for a text with input [tokens] while the gamepad is in use:
the same drop shadow passes, through scrDrawInput (the icons only on the top pass). Sets global.inputAlign back to fa_left.
argument0: text
argument1: x
argument2: y
argument3: text color
argument4: shadow color
argument5: type of drop shadow (as textDropShadow)
argument6: line separation (-1: the font's)
argument7: width to wrap at (-1: no wrapping)
*/
var s,tX,tY,tSep,tW,t,i,dx,dy,nn;
s=argument0
tX=argument1
tY=argument2
t=argument5
tSep=argument6
tW=argument7
draw_set_color(argument4)
if t=0 {nn=1} else if t=1 {nn=3} else if t=4 {nn=8} else {nn=4}
for(i=0;i<nn;i+=1)
{
  if t=0 {dx=0; dy=1}
  else if t=1 {if i=0 {dx=0; dy=1} else if i=1 {dx=1; dy=0} else {dx=1; dy=1}}
  else if t=2 {if i=0 {dx=0; dy=1} else if i=1 {dx=1; dy=0} else if i=2 {dx=0; dy=-1} else {dx=-1; dy=0}}
  else if t=3 {if i=0 {dx=1; dy=1} else if i=1 {dx=1; dy=-1} else if i=2 {dx=-1; dy=1} else {dx=-1; dy=-1}}
  else
  {
    if i=0 {dx=0; dy=1} else if i=1 {dx=1; dy=0} else if i=2 {dx=0; dy=-1} else if i=3 {dx=-1; dy=0}
    else if i=4 {dx=1; dy=1} else if i=5 {dx=1; dy=-1} else if i=6 {dx=-1; dy=1} else {dx=-1; dy=-1}
  }
  scrDrawInput(tX+dx,tY+dy,s,tSep,tW,0)
}
draw_set_color(argument3)
scrDrawInput(tX,tY,s,tSep,tW,1)
global.inputAlign=fa_left
