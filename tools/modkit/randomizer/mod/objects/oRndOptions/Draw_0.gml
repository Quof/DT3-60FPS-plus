//Randomizer: the options window (the Mods window's look), on a black screen
var tColorTop,tColorBack,tColorBorder,tColorInfo,tColorTextA,tColorTextB,tColorOn,tColorOff,tX,tY,i,tRowY,tName,tVal,tCol,tInfo;
tColorTop=make_color_rgb(12,16,15)
tColorBack=make_color_rgb(28,52,62)
tColorBorder=make_color_rgb(117,121,156)
tColorInfo=make_color_rgb(10,32,45)
tColorTextA=make_color_rgb(240,240,240)
tColorTextB=make_color_rgb(255,169,4)
tColorOn=make_color_rgb(120,232,96)
tColorOff=make_color_rgb(232,96,96)
tX=view_xview[0]+64
tY=view_yview[0]+30
draw_set_alpha(1)
draw_set_color(c_black)
draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+room_width+1,view_yview[0]+room_height+1,0)

//window
draw_set_alpha(0.85)
draw_set_color(tColorBack)
draw_rectangle(tX,tY,tX+351,tY+291,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX,tY,tX+351,tY+16,0)
draw_rectangle(tX,tY,tX+351,tY+291,1)
draw_set_color(tColorBorder)
draw_rectangle(tX+2,tY+2,tX+349,tY+289,1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(tX+8,tY+3,"RANDOMIZER: NEW GAME")

//the options
draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(tX+8,tY+22,tX+343,tY+123,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX+8,tY+22,tX+343,tY+123,1)
draw_set_font(fnt_PauseMenuText)
for(i=0;i<roRows;i+=1)
{
  tRowY=tY+25+(i*16)
  tVal=""
  tCol=tColorTextB
  if i=0
  {
    tName="Seed"
    if global.rndNextSeed>=0 {tVal=string(global.rndNextSeed)}
    else {tVal="Random"}
  }
  else if i=1
  {
    tName="Guarantee Early Weapons"
    if global.rndOptWeapons=1 {tVal="On"; tCol=tColorOn}
    else {tVal="Off"; tCol=tColorOff}
  }
  else if i=2
  {
    tName="Ability Spread"
    if global.rndOptSpread=0 {tVal="Near"}
    else if global.rndOptSpread=2 {tVal="Far"}
    else {tVal="Normal"}
  }
  else if i=3
  {
    tName="Shop Equipment"
    if global.rndOptShops=1 {tVal="Shuffled"}
    else {tVal="As Normal"}
  }
  else if i=4
  {
    tName="Spoiler Log"
    if global.rndOptLog=1 {tVal="On"; tCol=tColorOn}
    else {tVal="Off"; tCol=tColorOff}
  }
  else {tName="Start Game"}
  draw_set_halign(fa_left)
  draw_set_color(tColorTop); draw_text(tX+15,tRowY+1,tName)
  draw_set_color(tColorTextA); draw_text(tX+14,tRowY,tName)
  if tVal!=""
  {
    draw_set_halign(fa_right)
    draw_set_color(tColorTop); draw_text(tX+329,tRowY+1,tVal)
    draw_set_color(tCol); draw_text(tX+328,tRowY,tVal)
  }
}
draw_set_halign(fa_left)
draw_set_color(tColorTextB)
draw_rectangle(tX+12,tY+24+(roCursor*16),tX+331,tY+39+(roCursor*16),1)

//the option on the cursor
draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(tX+8,tY+129,tX+343,tY+258,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX+8,tY+129,tX+343,tY+258,1)
if roCursor=0 {tInfo="The number the items are placed by: the same seed with the same options places them the same way again. Confirm: type one in (leave it empty for a random one). The title screen's code seed and a number sets it too."}
else if roCursor=1 {tInfo="On: every layer has a weapon (an item of the Link, Belmont, Mega Man or Samus set) while there are any left. Off: the weapons go anywhere, as the other abilities do. Layer 1 is what jumping alone reaches from Central City; the items in it open layer 2, and so on."}
else if roCursor=2 {tInfo="How far from Central City the abilities and keys tend to be. Each goes in the newest layer (what the items before it opened) with a chance of 3 in 10 (Near) or 7 in 10 (Normal), else in an older one; always in the newest (Far)."}
else if roCursor=3 {tInfo="Shuffled: the equipment shops' stock is shuffled between the shops. As Normal: each shop sells its own."}
else if roCursor=4 {tInfo="On: a list of where every item is goes in the Saves folder (Randomizer spoiler log, with the seed's number)."}
else {tInfo="Start the game with these options. They're kept for the next new game."}
draw_set_color(tColorTop); draw_text_ext(tX+15,tY+133,tInfo,10,320)
draw_set_color(tColorTextA); draw_text_ext(tX+14,tY+132,tInfo,10,320)

//notice and controls
draw_set_font(fnt_Points)
if roGo>0 {textDropShadow("Placing the items...",tX+14,tY+262,tColorTextB,tColorTop,4)}
textDropShadow("[Up]/[Down] Option     [Left]/[Right] Change     [Confirm] Change/Start",tX+14,tY+275,tColorTextA,tColorTop,4)
