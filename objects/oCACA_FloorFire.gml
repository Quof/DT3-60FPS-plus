#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=2
image_yscale=2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oCACA_Main.x+xOffset
  //if oCACA_Main.bFloorFlame=0 {y=-16*gDeltaTime}
  if oCACA_Main.bFloorFlame=0 {y=-16} //60fps change: this sets a position (hides the flame above the room), so it isn't scaled; at 120fps it was only 4px above
  else {y=oCACA_Main.yGround}
}
