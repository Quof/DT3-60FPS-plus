#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
menuSizeX=160
menuSizeY=138

curInc=13
curPos=1
curMax=global.shooterProgress+1
curY=10
bCanMoveCursor=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanMoveCursor=1
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
    if curPos>=1 and curPos<=8 //To Dragoon segment
    {
      global.gamePaused=false
      if curPos=1 {global.newMapX=0}
      else if curPos=2 {global.newMapX=5}
      else if curPos=3 {global.newMapX=6}
      else if curPos=4 {global.newMapX=10}
      else if curPos=5 {global.newMapX=11}
      else if curPos=6 {global.newMapX=14}
      else if curPos=7 {global.newMapX=15}
      else if curPos=8 {global.newMapX=16}
      global.recAreaTrans+=1
      global.shooterDifficulty=1
      global.newMapY=192
      writeToPlayerGlobals()
      transition_steps=10
      transition_kind=21
      room_goto(rDragoonMapA)
    }
    else //To Warship
    {
      global.gamePaused=false
      global.recAreaTrans+=1
      global.newMapX=1072; global.newMapY=416
      writeToPlayerGlobals()
      transition_steps=10
      transition_kind=21
      room_goto(rWarshipA)
    }
  }
  else if oKeyCodes.kCodePressed[6]=1
  {
    resetKeyCodes()
    global.gamePaused=false
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myWinX=view_xview[0]+172
myWinY=view_yview[0]+124

draw_set_alpha(1)
draw_set_color(make_color_rgb(0,104,32))
draw_rectangle(myWinX,myWinY,myWinX+menuSizeX,myWinY+menuSizeY,0)
draw_set_color(make_color_rgb(0,104,32))
draw_rectangle(myWinX+1,myWinY+1,myWinX+menuSizeX-1,myWinY+menuSizeY-1,1)
draw_set_color(make_color_rgb(0,37,12))
draw_rectangle(myWinX,myWinY,myWinX+menuSizeX,myWinY+menuSizeY,1)

draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
textDropShadow("From the beginning! (1-1)",myWinX+14,myWinY+3,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
if global.shooterProgress>=1
  textDropShadow("1-X",myWinX+14,myWinY+16,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
if global.shooterProgress>=2
  textDropShadow("2-1",myWinX+14,myWinY+29,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
if global.shooterProgress>=3
  textDropShadow("2-X",myWinX+14,myWinY+42,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
if global.shooterProgress>=4
  textDropShadow("3-1",myWinX+14,myWinY+55,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
if global.shooterProgress>=5
  textDropShadow("3-4",myWinX+14,myWinY+68,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
if global.shooterProgress>=6
  textDropShadow("3-5",myWinX+14,myWinY+81,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
if global.shooterProgress>=7
  textDropShadow("CHAOS",myWinX+14,myWinY+94,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
if global.shooterProgress>=8
  textDropShadow("To the Warship!",myWinX+14,myWinY+107,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
textDropShadow("",myWinX+14,myWinY+120,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)

draw_sprite(sPauseM_AbilArrow,0,myWinX+11,myWinY+curY)
