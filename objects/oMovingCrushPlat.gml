#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: shiftTimeMax,xDir,yDir
viscidTop=1
makeActive()
shiftTime=0
deathCheck=0
solidIsNearPlayers=0
sprite_index=sInvisibleSolidMask
image_xscale=4
image_yscale=4

prevX=0
prevY=0

findTargetX=0
findTargetY=0
drawRangeX=560
drawRangeY=400
shiftTimeMax=96
shiftSeq=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xVel=xDir
yVel=yDir
x+=round(xDir)
y+=round(yDir)
shiftTimeMax=shiftChange-2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if shiftTime>=shiftTimeMax
  {
    if shiftSeq=0
    {
      xVel=0
      yVel=0
      shiftSeq=1
    }
    else if shiftSeq>=1 and shiftSeq<=20
      shiftSeq+=1
    else if shiftSeq>=21
    {
      shiftTime=0
      shiftSeq=0
      xVel=xDir
      yVel=yDir
      xVel*=-1
      yVel*=-1
      xDir=xVel
      yDir=yVel
    }
  }
  else
  {
    if prevX!=x or prevY!=y
    {
      prevX=x
      prevY=y
      shiftTime+=1
    }
  }
  scrPlatformCrush()
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
  if drawType=0
    draw_background_part(tileHPF,0,224,64,64,x,y)
  else if drawType=1
    draw_background_part(tileHPF,64,224,64,64,x,y)
  else if drawType=2
    draw_background_part(tileHPF,64,160,64,64,x,y)
}
