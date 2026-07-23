#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(-15,-15,15,15)
maxVel=4
maxYvel=9
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if xVel>maxVel
    xVel=maxVel
  else if xVel<-maxVel
    xVel=-maxVel
  if xVel>0
    xVel-=0.05
  else if xVel<0
    xVel+=0.05
  yVel+=0.2
  if yVel>maxYvel
    yVel=maxYvel
  if isCollisionBottom(1)
    yVel=0
  //if isCollisionLeft(1)
  //  xVel=0
  //if isCollisionRight(1)
  //  xVel=0
  //if isCollisionSolid()
  //  y-=2
  if y>room_height+24
    instance_destroy()
}
#define Collision_oLevelMovable
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  pDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-22)
  if pDist<400
  {
    if isCollisionCharacterBottom(1,other)
    {
      xVel=other.xVel
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
