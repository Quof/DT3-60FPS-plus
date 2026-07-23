#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime=1000
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if point_distance(x,0,oPlayer1.x,0)<=192
  {
    spawnTime+=1
    if spawnTime>=spawnSpeed
    {
      mGamet=instance_create(x,y,oMetGamet)
      mGamet.bActive=true
      spawnTime=0
    }
  }
}
