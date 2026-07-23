#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-8,-46,8,-1)
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  if sprite_index!=sSonicSleeping and sprite_index!=sJerryLayDown and sprite_index!=sJerrySickFall
  {
    if x<=oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}
  }

  if stringToShow!=""
  {
    global.recPeopleTalkNum+=1
    npcTextBox()
  }
}
