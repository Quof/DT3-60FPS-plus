#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
newSprite=0
bShift=0
shiftSeq=1
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
startX=x
startY=y
endX=x
endY=y
var xChk,yChk;
xChk=1; yChk=1
if xSpd<0
  xChk=-1
if ySpd<0
  yChk=-1

if xSpd!=0
  endX=x+(64*xChk)
if ySpd!=0
  endY=y+(64*yChk)

if variable_local_exists("spriteChange")
  newSprite=spriteChange
if variable_local_exists("newRangeX")
  drawRangeX=newRangeX
if variable_local_exists("newRangeY")
  drawRangeY=newRangeY
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bShift=1
  {
    if shiftSeq=0 //To end
    {
      xVel=xSpd
      yVel=ySpd
      if (xSpd>0 and x>=endX) or (xSpd<0 and x<=endX) or (ySpd>0 and y>=endY) or (ySpd<0 and y<=endY)
      {
        x=endX
        y=endY
        xVel=0
        yVel=0
        bShift=0
      }
    }
    else if shiftSeq=1 //To start
    {
      xVel=-xSpd
      yVel=-ySpd
      if (xSpd>0 and x<=startX) or (xSpd<0 and x>=startX) or (ySpd>0 and y<=startY) or (ySpd<0 and y>=startY)
      {
        x=startX
        y=startY
        xVel=0
        yVel=0
        bShift=0
      }
    }
  }
}
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
  {
    draw_sprite(sPlatformBlockA,0,x,y)
    draw_sprite_ext(sPlatformBlockA,0,x,y+64,1,1,90,image_blend,image_alpha)
    draw_sprite_ext(sPlatformBlockA,0,x+64,y+64,1,1,180,image_blend,image_alpha)
    draw_sprite_ext(sPlatformBlockA,0,x+64,y,1,1,270,image_blend,image_alpha)
  }
}
