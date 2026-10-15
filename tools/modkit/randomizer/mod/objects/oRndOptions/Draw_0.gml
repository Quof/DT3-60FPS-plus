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
tY=view_yview[0]+22
draw_set_alpha(1)
draw_set_color(c_black)
draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+room_width+1,view_yview[0]+room_height+1,0)

//window
draw_set_alpha(0.85)
draw_set_color(tColorBack)
draw_rectangle(tX,tY,tX+351,tY+307,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX,tY,tX+351,tY+16,0)
draw_rectangle(tX,tY,tX+351,tY+307,1)
draw_set_color(tColorBorder)
draw_rectangle(tX+2,tY+2,tX+349,tY+305,1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(tX+8,tY+3,"RANDOMIZER: NEW GAME")

//the options
draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(tX+8,tY+22,tX+343,tY+187,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX+8,tY+22,tX+343,tY+187,1)
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
    tName="Entrance Rando"
    if global.rndOptER=1 {tVal="Gate Swap"}
    else if global.rndOptER=2 {tVal="Overworld"}
    else if global.rndOptER=3 {tVal="Chaos"}
    else {tVal="Off"; tCol=tColorOff}
  }
  else if i=5
  {
    tName="Boss Rando"
    if global.rndOptBR=1 {tVal="On"; tCol=tColorOn}
    else {tVal="Off"; tCol=tColorOff}
  }
  else if i=6
  {
    tName="Instrument Randomization"
    if global.rndOptIR=1 {tVal="On"; tCol=tColorOn}
    else {tVal="Off"; tCol=tColorOff}
  }
  else if i=7
  {
    tName="Chip Randomizer"
    if global.rndOptChips=1 {tVal="On"; tCol=tColorOn}
    else {tVal="Off"; tCol=tColorOff}
  }
  else if i=8
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
draw_rectangle(tX+8,tY+193,tX+343,tY+274,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX+8,tY+193,tX+343,tY+274,1)
if roCursor=0 {tInfo="The number the items are placed by: the same seed with the same options places them the same way again. Confirm: type one in (leave it empty for a random one). The title screen's code seed and a number sets it too."}
else if roCursor=1 {tInfo="On: every layer has a weapon (an item of the Link, Belmont, Mega Man or Samus set) while there are any left. Off: the weapons go anywhere, as the other abilities do. Layer 1 is what jumping alone reaches from Central City; the items in it open layer 2, and so on."}
else if roCursor=2 {tInfo="How far from Central City the abilities and keys tend to be. Each goes in the newest layer (what the items before it opened) with a chance of 3 in 10 (Near) or 7 in 10 (Normal), else in an older one; always in the newest (Far)."}
else if roCursor=3 {tInfo="Shuffled: the equipment shops' stock is shuffled between the shops. As Normal: each shop sells its own."}
else if roCursor=4 {tInfo="Where the doors lead is shuffled (going back through one returns you where you came from). Gate Swap: the Access Gates' and Nightmare Gates' doors. Overworld: those, the doors between two areas and the maps' ways in and out. Chaos: every door. Every place stays reachable and the game can be finished. Making the seed takes a few seconds."}
else if roCursor=5 {tInfo="On: walking up to a boss starts another boss's fight, in that boss's own room (as the boss gallery does), and beating it counts as beating the boss whose room it is (a Nightmare Gate's reward is there after it). The CHAOS Warmaster stays where he is. The items are placed with each fight's new place in mind: the game can still be finished."}
else if roCursor=6 {tInfo="On: the 8 instruments are shuffled in with the other items, and a Nightmare Gate's boss leaves any item. Off: each gate's boss leaves its own instrument. Either way the Abomination needs all 8, and the Lost Entrance's barrier one."}
else if roCursor=7 {tInfo="On: the 6 Program Chips are shuffled in with the other items (in the place of six Internetz chests), and each Access Gate opens only once its own chip is found: going in without it turns you back. No chip is ever placed behind its own gate. Off: you start with all 6."}
else if roCursor=8 {tInfo="On: a list of where every item is goes in the Saves folder's Seeds folder (Randomizer spoiler log, with the seed's number)."}
else {tInfo="Start the game with these options. They're kept for the next new game."}
draw_set_color(tColorTop); draw_text_ext(tX+15,tY+197,tInfo,10,320)
draw_set_color(tColorTextA); draw_text_ext(tX+14,tY+196,tInfo,10,320)

//notice and controls
draw_set_font(fnt_Points)
if roGo>0
{
  if global.rndOptER>0 or global.rndOptBR=1 or global.rndOptIR=1 {tInfo="Shuffling and placing the items (a few seconds)..."}
  else {tInfo="Placing the items..."}
  textDropShadow(tInfo,tX+14,tY+278,tColorTextB,tColorTop,4)
}
textDropShadow("[Up]/[Down] Option     [Left]/[Right] Change     [Confirm] Change/Start",tX+14,tY+291,tColorTextA,tColorTop,4)
