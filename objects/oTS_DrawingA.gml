#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: activationType,targetPath,texWidth,texHeight,lineType,lineScale,drawSpd,drawTime
/*
** activationType: how the drawing is initiated
** if 0: activationDist: how far the player needs to be to initiate drawing
** targetPath: which path to use to draw
** texWidth: texture width
** texHeight: texture height
** lineType: sprite to use when drawing the line
** lineScale: size of the line
** drawSpd: line drawing speed
** drawTime: how much time till the end drawing phase occurs
  ** -1 if infinite time
*/
bCanDraw=0
currentAction=0
bStartMe=0
bInit=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myPathX=x-(texWidth/2)
myPathY=y-texHeight
myStartX=x
myStartY=y
mySurf=surface_create(texWidth,texHeight)
surface_set_target(mySurf)
surface_reset_target()
bInit=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bInit=1
{
  if bCanDraw=0
  {
    if activationType=0 //If player gets close enough
    {
      if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<activationDist {event_user(0)}
    }
    else if activationType=1 //Activated on create
    {
      event_user(0)
    }
    else if activationType=2 //Activated by event
    {
      if bStartMe=1 {event_user(0)}
    }
  }
  else if bCanDraw=1
  {
    if currentAction=0 //draw path
    {
      if global.gamePaused=false
      {
        path_speed=drawSpd
        if surface_exists(mySurf)
        {
          surface_set_target(mySurf)
          draw_sprite_ext(sTS_LineA,0,x+(texWidth/2),y+texHeight,lineScale,lineScale,0,image_blend,1)
          surface_reset_target()
        }
        if drawTime>-1
        {
          drawTime-=1
          if drawTime<=0
          {
            currentAction=1
          }
        }
      }
      else {path_speed=0}
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
path_start(targetPath,drawSpd,0,true)
bCanDraw=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bInit=1
{
  if surface_exists(mySurf)
  {
    draw_surface(mySurf,myPathX,myPathY)
  }
  else
  {
    mySurf=surface_create(texWidth,texHeight)
  }
}
