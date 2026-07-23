#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnX=0
spawnY=0
spawnTime=90
spawnProg=0
enemySpawn=oB2SpiritPlane

//planeSpawner=instance_create(0,0,oPlaneSpawner)
//planeSpawner.spawnDelay=115
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  spawnTime+=1
  if spawnTime>=spawnDelay
  {
    if spawnProg=0 {spawnX=view_xview-64; spawnProg=1} //from left
    else {spawnX=view_xview+view_wview+64; spawnProg=0} //from right

    spawnY=48+random(32)
    plane=instance_create(spawnX,spawnY,enemySpawn)
    plane.bActive=1
    spawnTime=0
  }
}
