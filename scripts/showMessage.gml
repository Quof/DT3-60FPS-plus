/*
This script sets the message box used.
use: showMessage(x,y,msg,char,color,alpha,size)

argument0: x position (top-left)
argument1: y position (top-left)
argument2: message shown
argument3: character talking ("" for no one)
argument4: window color (0 for character specific)
argument5: window alpha
argument6: message box size
-- 0: Small
-- 1: Medium
-- 2: Large
-- 3: Super Size
*/
var tXpos,tYpos,tTextDisplay,tCharTalk,tWindowCol,tWindowAlpha,tWindowSize,tColorShown;
tXpos=argument0
tYpos=argument1
tTextDisplay=argument2
tCharTalk=argument3
tWindowCol=argument4
tWindowAlpha=argument5
tWindowSize=argument6

if global.modeDroggeljug=1
{
  tTextDisplay="droggeljug"
  tCharTalk="droggeljug"
}

//========================================
//============= WINDOW SIZE ==============
//========================================
var tWinSizeX,tWindSizeY;
if tWindowSize=0
{
  tWinSizeX=139
  tWinSizeY=28
}
else if tWindowSize=1
{
  tWinSizeX=199
  tWinSizeY=41
}
else if tWindowSize=2
{
  tWinSizeX=259
  tWinSizeY=54
}
else if tWindowSize=3
{
  tWinSizeX=319
  tWinSizeY=67
}

//========================================
//============ COLOR SETTINGS ============
//========================================
//Window color
if tWindowCol=0
{
  tColorShown=make_color_rgb(253,246,174) //Yellow (Default, if no character below is chosen)
  tColorBack=make_color_rgb(225,220,163) //make_color_rgb(0,100,60)
  if tCharTalk="Jerry"
    tWindowCol=1 //tColorShown=make_color_rgb(98,188,77) //Green
  else if tCharTalk="Jeremy"
    tWindowCol=2 //tColorShown=make_color_rgb(243,112,51) //Orange
  else if tCharTalk="Claire"
    tWindowCol=3 //tColorShown=make_color_rgb(102,47,137) //Purple
  else if tCharTalk="Chao"
    tWindowCol=4 //tColorShown=make_color_rgb(30,152,213) //Blue
  else if tCharTalk="Hex" or tCharTalk="Hexor"
    tWindowCol=5 //tColorShown=make_color_rgb(238,65,68) //Red

  //Others for NPCs that pause the game during their dialogue
  if tCharTalk="John"
  {
    tColorShown=make_color_rgb(209,253,174)
    tColorBack=make_color_rgb(190,225,163)
  }
  else if tCharTalk="Gene"
  {
    tColorShown=make_color_rgb(240,226,206)
    tColorBack=make_color_rgb(213,204,200)
  }
  else if tCharTalk="Syrus"
  {
    tColorShown=make_color_rgb(253,206,174)
    tColorBack=make_color_rgb(225,189,163)
  }
  else if tCharTalk="Bubblun"
  {
    tColorShown=make_color_rgb(220,253,174)
    tColorBack=make_color_rgb(199,225,163)
  }
  else if tCharTalk="Lovelun"
  {
    tColorShown=make_color_rgb(246,174,253)
    tColorBack=make_color_rgb(220,163,225)
  }
}

if tWindowCol=1 //Jerry (Green)
{
  tColorShown=make_color_rgb(98,188,77)
  tColorBack=make_color_rgb(166,238,150)
}
else if tWindowCol=2 //Jeremy (Orange)
{
  tColorShown=make_color_rgb(243,112,51)
  tColorBack=make_color_rgb(242,171,139)
}
else if tWindowCol=3 //Claire (Purple)
{
  tColorShown=make_color_rgb(102,47,137)
  tColorBack=make_color_rgb(183,126,219)
}
else if tWindowCol=4 //Chao (Blue)
{
  tColorShown=make_color_rgb(30,152,213)
  tColorBack=make_color_rgb(118,183,216)
}
else if tWindowCol=5 //Hex/Hexor (Red)
{
  tColorShown=make_color_rgb(238,65,68)
  tColorBack=make_color_rgb(238,139,141)
}
else if tWindowCol=6 //Yellow - Most NPCs - Some NPCs will have their own color here
{
  tColorShown=make_color_rgb(253,246,174) //Default: Yellow
  tColorBack=make_color_rgb(225,220,163)
  if tCharTalk="John"
  {
    tColorShown=make_color_rgb(209,253,174)
    tColorBack=make_color_rgb(190,225,163)
  }
  else if tCharTalk="Gene"
  {
    tColorShown=make_color_rgb(240,226,206)
    tColorBack=make_color_rgb(213,204,200)
  }
  else if tCharTalk="Syrus"
  {
    tColorShown=make_color_rgb(253,206,174)
    tColorBack=make_color_rgb(225,189,163)
  }
  else if tCharTalk="Bubblun"
  {
    tColorShown=make_color_rgb(220,253,174)
    tColorBack=make_color_rgb(199,225,163)
  }
  else if tCharTalk="Lovelun"
  {
    tColorShown=make_color_rgb(246,174,253)
    tColorBack=make_color_rgb(220,163,225)
  }
}
else if tWindowCol=7 //Gray 1
{
  tColorShown=make_color_rgb(169,194,164)
  tColorBack=make_color_rgb(195,229,188)
}
else if tWindowCol=8 //Brown
{
  tColorShown=make_color_rgb(140,70,10)
  tColorBack=make_color_rgb(210,154,106)
}

//========================================
//============ TEXT SETTINGS =============
//========================================
draw_set_alpha(tWindowAlpha)
draw_set_halign(fa_left)
draw_set_font(fnt_EnemyName)
//---------- Show message box ----------
draw_set_color(tColorShown)
draw_rectangle(tXpos,tYpos,tXpos+tWinSizeX,tYpos+tWinSizeY,0) //back window color
draw_set_color(make_color_rgb(0,100,60))
draw_rectangle(tXpos,tYpos,tXpos+tWinSizeX,tYpos+tWinSizeY,1) //outer border
draw_set_color(tColorBack)
draw_rectangle(tXpos+3,tYpos+12,tXpos+tWinSizeX-3,tYpos+tWinSizeY-3,0) //text area
//---------- Show character talking ----------
draw_set_color(make_color_rgb(12,43,0))
draw_text(tXpos+3,tYpos-1,">> " +string(tCharTalk))
//---------- Show text message ----------
draw_set_font(fnt_Points)
draw_text_ext(tXpos+5,tYpos+12,tTextDisplay,13,tWinSizeX-10)
