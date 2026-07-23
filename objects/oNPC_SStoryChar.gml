#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-11,-50,11,-1)
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  global.recPeopleTalkNum+=1
  if x<=oPlayer1.x
    image_xscale=1
  else
    image_xscale=-1

  if variable_local_exists("storyCheck")
  {
    if storyCheck=global.gameProgress //Increment progress value by 10 when player talks to npc
      global.gameProgress+=10
    else
      npcTextBox()
  }
  else
    npcTextBox()
}
