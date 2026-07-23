#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- BLACKMOOR: HAND -----
event_inherited()
bCanTakeDamage=false

//Enemy base statistics
eName="Blackmore"
eLevel=13
maxLife=100
life=maxLife
atkPower=oBlackmoorMain.atkPower
affiliation=9
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if side=0 //Left (Front)
  {
    x=oBlackmoorMain.bForearmL.x+lengthdir_x(53,oBlackmoorMain.bForearmL.image_angle+270)
    y=oBlackmoorMain.bForearmL.y+lengthdir_y(53,oBlackmoorMain.bForearmL.image_angle+270)
    image_angle=oBlackmoorMain.bForearmL.image_angle
  }
  else if side=1 //Right (Back)
  {
    x=oBlackmoorMain.bForearmR.x+lengthdir_x(53,oBlackmoorMain.bForearmR.image_angle+270)
    y=oBlackmoorMain.bForearmR.y+lengthdir_y(53,oBlackmoorMain.bForearmR.image_angle+270)
    image_angle=oBlackmoorMain.bForearmR.image_angle
  }
  enemyStepEvent()
}
