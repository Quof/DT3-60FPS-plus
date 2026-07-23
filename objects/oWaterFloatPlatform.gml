#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(2,0,sprite_width-2,sprite_height-1)
newSprite=0

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
deathCheck=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("spriteChange")
  newSprite=spriteChange
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if isCollisionWaterBottom(-4)
  {
    yVel-=0.2
    if yVel<-2
      yVel=-2
    else if yVel>2
      yVel=1
  }
  else
  {
    yVel+=0.2
    if yVel<-1
      yVel=-1
    else if yVel>10
      yVel=10
  }

  if isCollisionTop(1)
  {
    //if !collision_point(x,bbox_top-2,oPushRock,0,1)
    yVel=0

    if !isCollisionWaterBottom(-4)
      yVel+=0.5
  }
  if isCollisionBottom(1)
  {
    yVel=0
    if isCollisionWaterBottom(-4)
      yVel-=0.5
  }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Do nothing (Removes crush mechanics)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if newSprite=0
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else if newSprite=1 //Stratum Steppe 1
  {
    draw_background_part(tileMeadelandA,96,64,64,16,x,y)
  }
}
