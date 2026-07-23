#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
newSprite=0

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384

destroyRange=24
deathCheck=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xVel=moveSpeedX
yVel=moveSpeedY

if variable_local_exists("spriteChange")
  newSprite=spriteChange

if variable_local_exists("newDestroy")
  destroyRange=newDestroy

if newSprite=1 and variable_local_exists("xSize")
  image_xscale=1+(xSize*0.5)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Move the platform continuously in one direction
if global.gamePaused=false
{
  findTargetX=point_distance(oPlayer1.x,0,x,0)
  findTargetY=point_distance(0,oPlayer1.y,0,y)
  if x<-destroyRange
    instance_destroy()
  else if x>room_width+destroyRange
    instance_destroy()
  else if y<-destroyRange
    instance_destroy()
  else if y>room_height+destroyRange
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if newSprite=0 //Normal
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else if newSprite=1 //Mario platforms
  {
    draw_sprite_part(sMovingPlatform1,0,0,0,32,16,x,y)
    draw_sprite_part(sMovingPlatform1,0,16,0,32,16,x+32,y)
  }
  else if newSprite=2 //Highlands Tree Branch
  {
    draw_background_part(tileHighlands,64,64,64,16,x,y)
  }
}
