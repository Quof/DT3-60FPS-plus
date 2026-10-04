#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
shiftTime=0
shiftTimeMax=96

prevX=0
prevY=0

findTargetX=0
findTargetY=0
drawRangeX=560
drawRangeY=400
bCanMove=true
bPauseOnEnd=true
shiftSeq=0

sprite_index=sScaledCollision
platColor=make_color_rgb(170,170,255)

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
if variable_local_exists("newRangeX")
  drawRangeX=newRangeX
if variable_local_exists("newRangeY")
  drawRangeY=newRangeY
if variable_local_exists("doNotMove")
{
  bCanMove=false
  xVel=0
  yVel=0
}
if variable_local_exists("newStartTime")
  shiftTime=newStartTime
if variable_local_exists("doNotPause")
  bPauseOnEnd=doNotPause
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//shift logic runs on 30fps ticks so trips are exactly as long as at 30fps; gameStepEvent spreads the movement across frames
if global.gamePaused=false and gDeltaDoTicks != 0
{
  if bCanMove=true
  {
    if shiftTime>=shiftTimeMax
    {
      if shiftSeq=0
      {
        if bPauseOnEnd=1
        {
          xVel=0
          yVel=0
          shiftSeq=1
        }
        else
          shiftSeq=1000
      }
      else if shiftSeq>0 and shiftSeq<=20
        shiftSeq+=1
      else if shiftSeq>20
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
      //if place_meeting(x,y,oNightmareEffect) {xVel=xDir/2; yVel=yDir/2}
      //else {xVel=xDir; yVel=yDir}
      if prevX!=mstLX or prevY!=mstLY //mstLX/mstLY: this tick's finished position (same as x/y at 30fps)
      {
        prevX=mstLX
        prevY=mstLY
        shiftTime+=1
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
  draw_set_color(platColor)
  draw_set_alpha(0.3)
  draw_roundrect(x,y,x+image_xscale-1,y+image_yscale-1,0)
  draw_set_alpha(1)
  draw_roundrect(x,y,x+image_xscale-1,y+image_yscale-1,1)
}
