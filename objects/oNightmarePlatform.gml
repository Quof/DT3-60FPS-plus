#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
shiftTime=0

prevX=0
prevY=0

bPauseOnEnd=true
shiftSeq=0
deathCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if collision_rectangle(x,y-8,x+48,y+32,oNightmareEffect,0,1)
  {
    sprite_index=sNightmarePlatform
  }
  else
  {
    sprite_index=sNull
  }

  if bCanMove=true
  {
    if shiftTime>=shiftMax
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
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sNightmarePlatform
{
  draw_sprite(sNightmarePlatform,0,x,y)
}
else
{
  draw_sprite_ext(sNightmarePlatform,0,x,y,1,1,0,c_white,0.15)
}
