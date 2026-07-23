#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<36;i+=1)
{
  instance_create(random(room_width),random(room_height),oOverworldCloud)
}
cloudTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(oZeldaSaveMenu)
{
  cloudTime+=1
  if cloudTime>=40
  {
    if random(10)>5
    {
      instance_create(random(room_width),-48,oOverworldCloud)
    }
    else
    {
      instance_create(room_width+48,random(room_height),oOverworldCloud)
    }
    cloudTime=0
  }
}
