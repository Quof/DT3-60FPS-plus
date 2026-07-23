#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawnTime=0
effectDist=400
newObject=0
type=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("bInstant")
  spawnTime=spawnDelay
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Creates objects from object x/y position, limiting to only 1 instance of spawned object at a time.
Variables on instance creation code (Must be used)
-- objCreate: Object to create
-- spawnDelay: Time till a new object is spawned

Other variables (Optional)
-- bInstant: Set to 1 to instantly spawn object on creation
*/

if global.gamePaused=false
{
  if !instance_exists(newObject)
  {
    spawnTime+=1
    if spawnTime>=spawnDelay
    {
      newObject=instance_create(x,y,objCreate)
      spawnTime=0
    }
  }
}
