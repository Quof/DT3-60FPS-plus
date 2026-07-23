#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime=irandom_range(10,240)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime-=1
if spawnTime<=0
{
  var tBirdSpawn,tXSpawn;
  tXSpawn=choose(view_xview[0]-48,view_xview[0]+view_wview[0]+48)
  tBirdSpawn=instance_create(tXSpawn,oPlayer1.y-64-random(128),oGrayBird)
  if tXSpawn>oPlayer1.x {tBirdSpawn.image_xscale=-1}
  spawnTime=irandom_range(10,240)
}
