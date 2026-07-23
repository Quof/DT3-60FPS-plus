#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
newSprite=0
myHP=2

findTargetX=0
findTargetY=0
drawRangeX=560
drawRangeY=400
bCanMove=true
turnDelay=0
offscreenDestroy=300
deathCheck=0
solidIsNearPlayers=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xVel=xMove
yVel=yMove
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bCanMove=true
  {
    offscreenDestroy-=1
    if turnDelay=0
    {
      nextTurn=instance_nearest(x,y,oPlatRail) //find closest rail turn
      if point_distance(x,y,nextTurn.x+8,nextTurn.y+8)<moveSpd
      {
        x=nextTurn.x+8; y=nextTurn.y+8
        var tXvel,tYvel;
        tXvel=xVel; tYvel=yVel
        xVel=0; yVel=0
        if nextTurn.turnType=0 //top-left corner
        {
          if tYvel<0 {xVel=moveSpd}
          else if tXvel<0 {yVel=moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=1 //top-right corner
        {
          if tXvel>0 {yVel=moveSpd}
          else if tYvel<0 {xVel=-moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=2 //bottom-right corner
        {
          if tYvel>0 {xVel=-moveSpd}
          else if tXvel>0 {yVel=-moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=3 //bottom-left corner
        {
          if tXvel<0 {yVel=-moveSpd}
          else if tYvel>0 {xVel=moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=4 //turn around
        {
          xVel=-tXvel; yVel=-tYvel
          turnDelay=8
        }
      }
    }
    else {turnDelay-=1}
  }

  if myHP<=0
  {
    instance_destroy()
  }
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if offscreenDestroy<=0 {instance_destroy()}
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
}
