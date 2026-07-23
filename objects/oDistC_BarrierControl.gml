#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
maxWalls=5
for(i=0;i<maxWalls;i+=1)
{
  wallProg[i]=0
}

enemy[0]=(467157)
wall[0]=(467149)
enemy[1]=(467158)
wall[1]=(467147)
enemy[2]=(467162)
wall[2]=(467161)
enemy[3]=(467163)
wall[3]=(467148)
enemy[4]=(467164)
wall[4]=(467165)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<maxWalls;i+=1)
{
  if wallProg[i]=0
  {
    if !instance_exists(enemy[i])
    {
      if instance_exists(wall[i])
      {
        with (wall[i]) {instance_destroy()}
      }
      wallProg[i]=1
    }
  }
}
