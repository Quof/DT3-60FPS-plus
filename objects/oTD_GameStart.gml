#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bMenuDisplayed=0

TD_Check=global.gameOptTowerDef
if TD_Check>5 {TD_Check=5}

curInc=15
curPos=1
curMax=TD_Check+1
curY=24

menuSizeX=160
menuSizeY=16+((TD_Check+1)*curInc)

if global.gameProgress<=3900 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bMenuDisplayed=1
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if curPos=1
    {
      curPos=curMax
      curY+=curInc*(curMax-1)
    }
    else
    {
      curPos-=1
      curY-=curInc
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if curPos=curMax
    {
      curPos=1
      curY-=curInc*(curMax-1)
    }
    else
    {
      curPos+=1
      curY+=curInc
    }
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    if curPos=1 //Quit
    {
      bMenuDisplayed=0
      depth=50
      global.gamePaused=false
    }
    else if curPos=2 //First Offense
    {
      global.newMapX=192
      global.newMapY=560
      writeToPlayerGlobals()
      global.bTowerDefense=1
      room_goto(rTD_Lv1)
    }
    else if curPos=3 //Second Offense
    {
      global.newMapX=240
      global.newMapY=576
      writeToPlayerGlobals()
      global.bTowerDefense=2
      room_goto(rTD_Lv2)
    }
    else if curPos=4 //Optional 1
    {
      global.newMapX=256
      global.newMapY=576
      writeToPlayerGlobals()
      global.bTowerDefense=3
      room_goto(rTD_Lv3)
    }
    else if curPos=5 //Optional 2
    {
      global.newMapX=416
      global.newMapY=624
      writeToPlayerGlobals()
      global.bTowerDefense=4
      room_goto(rTD_Lv4)
    }
    else if curPos=6 //Optional 3
    {
      global.newMapX=272
      global.newMapY=576
      writeToPlayerGlobals()
      global.bTowerDefense=5
      room_goto(rTD_Lv5)
    }
  }
  else if oKeyCodes.kCodePressed[6]=1 //Cancel
  {
    curPos=1; curY=24
    bMenuDisplayed=0
    depth=50
    global.gamePaused=false
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  global.gamePaused=true
  resetKeyCodes()
  bMenuDisplayed=1
  depth=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if bMenuDisplayed=1
{
  var myWinX,myWinY;
  myWinX=view_xview[0]+172
  myWinY=view_yview[0]+124
  draw_set_alpha(1)
  draw_set_color(make_color_rgb(0,104,32))
  draw_rectangle(myWinX,myWinY,myWinX+menuSizeX,myWinY+menuSizeY,0)
  draw_set_color(make_color_rgb(0,104,32))
  draw_rectangle(myWinX+1,myWinY+1,myWinX+menuSizeX-1,myWinY+menuSizeY-1,1)
  draw_set_color(make_color_rgb(0,37,12))
  draw_rectangle(myWinX,myWinY,myWinX+menuSizeX,myWinY+menuSizeY,1)
  draw_line(myWinX,myWinY+15,myWinX+menuSizeX,myWinY+15)
  draw_set_color(make_color_rgb(0,74,23))
  draw_line(myWinX+1,myWinY+61,myWinX+menuSizeX,myWinY+61)

  draw_set_font(fnt_PauseMenuMain)
  draw_set_halign(fa_center)
  textDropShadow("Turret Defense Game",myWinX+(menuSizeX/2),myWinY+1,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_left)
  textDropShadow("Nah, don't want this",myWinX+14,myWinY+18,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  textDropShadow("First Offense",myWinX+14,myWinY+33,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  textDropShadow("Second Offense",myWinX+14,myWinY+48,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  textDropShadow("Optional 1",myWinX+14,myWinY+63,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  if TD_Check>=4
    textDropShadow("Optional 2",myWinX+14,myWinY+78,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  if TD_Check>=5
    textDropShadow("Optional 3",myWinX+14,myWinY+93,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)

  draw_sprite(sPauseM_AbilArrow,0,myWinX+11,myWinY+curY)
}
