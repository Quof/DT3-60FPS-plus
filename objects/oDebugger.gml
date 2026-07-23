#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xSpot=5936
ySpot=256
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and global.gamePaused=false
{
  var tNewTutorial;
  tNewTutorial=instance_create(0,0,oTutorialPanel)
  tNewTutorial.tutorialTitle="Action Button C"
  tNewTutorial.tutorialInfo="To use Link's Bombs, press [O]. Like the arrows, their initial angle can be changed by holding Up or Down before firing. Press the bomb button again while it is active to speed up its detonation."
  tNewTutorial.scrAreaY=0
  //oPlayer1.x=xSpot
  //oPlayer1.y=ySpot
}
