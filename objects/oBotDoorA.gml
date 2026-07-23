#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
detectDistX=240
detectDistY=208
image_speed=0

spawnTime=0
opening=0
robotSpawn=0

if variable_local_exists("newDDX")
  detectDistX=newDDX
if variable_local_exists("newDDY")
  detectDistY=newDDY
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bFunctional=1
  {
    spawnTime-=1
    findTargetX=point_distance(oPlayer1.x,0,x,0)
    findTargetY=point_distance(0,oPlayer1.y-26,0,y)
    if findTargetX<=detectDistX and findTargetY<=detectDistY and opening=0
    {
      if spawnTime<=0 and !instance_exists(robotSpawn)
        opening+=1
    }

    //Open and spawn enemy
    if opening>=1
    {
      opening+=1
      if opening=2
        image_index=1
      else if opening=8
        image_index=2
      else if opening=14
        image_index=3
      else if opening=30
      {
        robotSpawn=instance_create(x,y,oPincherBot)
        robotSpawn.initDir=pushDir
        spawnTime=240
      }
      else if opening=46
        image_index=2
      else if opening=52
        image_index=1
      else if opening=58
      {
        image_index=0
        opening=0
      }
    }
  }
}
