/*
An object can only use this script after calling "setCollisionBounds."
0: Number of pixels left of the collision rectangle to check for a collision
with an "oWater".
*/
calculateCollisionBounds()
if collision_line(round(lb-argument0),round(tb),round(lb-argument0),round(bb-1),oWater,1,1)>0
{
  return 1
}
return 0
