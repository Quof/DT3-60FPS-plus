#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnDirection=0
init=0
spawnX=0
spawnTime=15
enemySpawn=oSkullHead
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newEnemySpawn")
  enemySpawn=newEnemySpawn
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if spawnDirection=0
  {
    if oPlayer1.x<256
      spawnDirection=1
    else
      spawnDirection=2
  }

  if spawnTime>=spawnDelay
  {
    var spawnX,ranSpawn,eSpawn;
    if oPlayer1.image_xscale=1 //spawn from right
      spawnX=view_xview+view_wview+16
    else //spawn from left
      spawnX=view_xview-16
    if enemySpawn=oWolfHead
      ranSpawn=(oPlayer1.y-30)+random(4)
    else if enemySpawn=oBagoBago
    {
      ranSpawn=room_height+16
      if random(4)>2
        spawnX=view_xview+view_wview+16
      else
        spawnX=view_xview-16
    }
    else
      ranSpawn=(oPlayer1.y-56)+random(60)
    eSpawn=instance_create(spawnX,ranSpawn,enemySpawn)
    eSpawn.bActive=true
    spawnTime=0
  }
  else
  {
    if (spawnDirection=1 and oPlayer1.x<room_width-(view_wview[0]/2)) or (spawnDirection=2 and oPlayer1.x>view_wview[0]/2)
      spawnTime+=1
  }
}
