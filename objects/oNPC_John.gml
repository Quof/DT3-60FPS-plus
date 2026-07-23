#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-9,-42,9,-1)
talker="John"
bTalkedTo=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  bTalkedTo=1
  global.recPeopleTalkNum+=1
  if x<=oPlayer1.x
    image_xscale=1
  else
    image_xscale=-1
  if stringToShow!="" {npcTextBox()}
}
