#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime=100
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  myDist=point_distance(x,0,oPlayer1.x,0)
  if myDist<=320 {spawnTime+=1}
  if spawnTime>=spawnDelay
  {
    instance_create(x+8,y+8,oMetRinka)
    spawnTime=0
  }
}
