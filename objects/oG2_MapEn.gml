#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
bMoveStep=0
moveTime=0
decayTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(oZeldaSaveMenu)
{
  if bMoveStep=0 //Move decision
  {
    var tExCheck; tExCheck=10
    if x<oPlayerZeldaIcon.x
      bMoveStep=4
    else if x>oPlayerZeldaIcon.x
      bMoveStep=3

    if y<oPlayerZeldaIcon.y
    {
      if bMoveStep>0
        tExCheck=random(10)

      if tExCheck>5
        bMoveStep=2
    }
    else if y>oPlayerZeldaIcon.y
    {
      if bMoveStep>0
        tExCheck=random(10)

      if tExCheck>5
        bMoveStep=1
    }
  }
  else if bMoveStep=1
    y-=4
  else if bMoveStep=2
    y+=4
  else if bMoveStep=3
    x-=4
  else if bMoveStep=4
    x+=4

  moveTime+=1
  if moveTime=4
  {
    bMoveStep=0
    moveTime=0
  }

  decayTime+=1
  if decayTime>=90
    instance_destroy()
}
