#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime=round(spawnDelay/2)
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
    var newObject;
    newObject=instance_create(x,y,oRollingBoulder)
    newObject.activate=1
    spawnTime=0
  }
}
