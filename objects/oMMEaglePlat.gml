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
newSprite=0

prevX=0
prevY=0

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
bCanMove=true
bPauseOnEnd=true
shiftSeq=0
flameFrm=0

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
      else if shiftSeq>=1 and shiftSeq<=20
        shiftSeq+=1
      else if shiftSeq=21
      {
        flameFrm=0
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
        flameFrm+=0.5
        prevX=x
        prevY=y
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
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  if shiftTime<shiftTimeMax and shiftSeq=0 and yVel<0
  {
    draw_sprite(sMM_SEPEffect,flameFrm,x+20,y+12)
  }
}
