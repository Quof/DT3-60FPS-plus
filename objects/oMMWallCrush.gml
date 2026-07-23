#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
** Requires moveSpd, drawSec

** moveSpd: Direction and speed to start moving
** drawSec: How many segments to draw
*/

viscidTop=1
makeActive()

findTargetX=0
findTargetY=0
drawRangeX=1024
drawRangeY=384
moveSeq=0
moveTime=0
deathCheck=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=drawSec+1
if moveSpd<0 {x+=drawSec*16}
moveMax=(moveSpace/abs(moveSpd))*16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if moveSeq=1
  {
    xVel=moveSpd
    moveSeq=2
  }
  else if moveSeq=2
  {
    moveTime+=1
    if moveTime>=moveMax {xVel=0; moveSeq=3}

    scrPlatformCrush()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if moveSpd>0
  {
    draw_sprite(sprite_index,0,x,y)
    for(i=0;i<drawSec;i+=1) {draw_sprite(sprite_index,1,x-16-(i*16),y)}
  }
  else
  {
    draw_sprite_ext(sprite_index,0,x-16-(drawSec*16),y,-1,1,0,c_white,1)
    for(i=0;i<drawSec;i+=1) {draw_sprite_ext(sprite_index,1,x-(drawSec*16)+(i*16),y,-1,1,0,c_white,1)}
  }
}
