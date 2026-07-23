#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  global.gamePaused=true
  var tMyRules;
  tMyRules=instance_create(0,0,oTD_ExplainMenu)
  tMyRules.type=2
}
