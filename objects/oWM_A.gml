#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
warmasterCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if warmasterCheck=4
  {
    global.newMapX=184; global.newMapY=208; room_goto(rBT_HUB)
  }
}
