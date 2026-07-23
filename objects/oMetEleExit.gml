#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
eleFlash=0
moveProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eleFlash+=1
if eleFlash mod 2=0 //Flash sprite
{
  if image_alpha=1 {image_alpha=0.6}
  else {image_alpha=1}
}

if moveProg=0 and global.gamePaused=false //Player stands on elevator
{
  if isCollisionCharacterTop(1,0)
  {
    if type=0 //Go down
    {
      if oKeyCodes.kCodePressed[4]=1 {moveProg=1}
    }
    else if type=1 //Go up
    {
      if oKeyCodes.kCodePressed[3]=1 {moveProg=1}
    }
  }
}
if moveProg=1 //Set movement states
{
  scenePChk(round(x+(sprite_width/2)),round(y),0,0.1,1)
  stopPlayer()
  global.gamePaused=true
  moveProg=2
}
else if moveProg=2 //Move elevator and player
{
  if type=0 //Down
  {
    y+=2; oPlayer1.y+=2
    if oPlayer1.y>=room_height+56 {moveProg=3}
  }
  else if type=1 //Up
  {
    y-=2; oPlayer1.y-=2
    if oPlayer1.y<=4 {moveProg=3}
  }
}
else if moveProg=3 //Transition
{
  global.recAreaTrans+=1
  global.newMapX=newMapX
  global.newMapY=newMapY
  global.gamePaused=false
  writeToPlayerGlobals()
  transition_steps=10
  transition_kind=21
  room_goto(toRoom)
}
