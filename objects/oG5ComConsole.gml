#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
compScrFade=0
bConsoleOn=0
consoleAlpha=0.6

screenCol=make_color_rgb(0,255,0)
textCol=make_color_rgb(0,68,0)

if global.gameProgress<=2750 {locationTag="Sector 1"}
else if global.gameProgress>=2760 and global.gameProgress<=2780 {locationTag="Sector 2"}
else if global.gameProgress>=2790 and global.gameProgress<=2800 {locationTag="Sector 3"}
else if global.gameProgress=2810 {locationTag="Sector 1"}
else if global.gameProgress>=2820 and global.gameProgress<=2840 {locationTag="Sector 3"}
else if global.gameProgress>=2850 and global.gameProgress<=2859 {locationTag="Sector 2"}
else if global.gameProgress>=2860 {locationTag="N/A"}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if compScrFade=0
{
  image_alpha-=0.01
  if image_alpha<=0.6 {compScrFade=1}
}
else if compScrFade=1
{
  image_alpha+=0.01
  if image_alpha>=1 {compScrFade=0}
}

if oGame.time mod 3=0
{
  if consoleAlpha=0.6 {consoleAlpha=0.65}
  else {consoleAlpha=0.6}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Metroid command console script.
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  if bConsoleOn=0 {bConsoleOn=1}
  else {bConsoleOn=0}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,0,x,y)
draw_sprite_ext(sGate5ComScreen,0,x,y-38,1,1,0,c_white,image_alpha)

if bConsoleOn=1
{
  draw_set_alpha(consoleAlpha)
  draw_set_color(screenCol)
  draw_rectangle(x-64,y-101,x+64,y-50,0)
  draw_set_color(textCol)
  draw_set_alpha(1)
  draw_rectangle(x-64,y-101,x+64,y-50,1)
  draw_set_alpha(consoleAlpha+0.3)
  draw_set_font(fnt_StatRender)
  draw_set_halign(fa_left)
  draw_text(x-59,y-99,string(">Current Elevator#")
  +string(elevatorTag) +string("#")
  +string(">Next Destination#")
  +string(locationTag))
}
