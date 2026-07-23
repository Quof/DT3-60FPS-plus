#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(2,0,sprite_width-2,sprite_height-1)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.2
  if yVel>12
    yVel=12

  if isCollisionBottom(1)
    yVel=0
  if isCollisionSolid()
    y-=2

  if y>room_height+24
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_background_part(tileLostVikingsA,32,96,32,32,x,y)
