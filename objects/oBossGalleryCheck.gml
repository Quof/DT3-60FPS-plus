#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bossKillCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  if bossKillCheck=2
  {
    bossRoomTally(50)
    global.newMapX=1032; global.newMapY=496; room_goto(rBossGallery)
  }
}
