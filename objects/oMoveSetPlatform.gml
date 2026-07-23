#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
newSprite=1

//set up
findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
bCanMove=true
deathCheck=0

/*
***** Move Times *****
moveProg: Set in creation code, 0-right, 1-down, 2-left, 3-up
bReverse: Set in creation code
shiftSpd: Set in creation code
*/
timeRight=64
timeDown=64
timeLeft=64
timeUp=64
shiftTime=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("spriteChange")
  newSprite=spriteChange
if variable_local_exists("newRight")
  timeRight=newRight
if variable_local_exists("newDown")
  timeDown=newDown
if variable_local_exists("newLeft")
  timeLeft=newLeft
if variable_local_exists("newUp")
  timeUp=newUp
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
    shiftTime+=1
    if moveProg=0 //right
    {
      xVel=shiftSpd
      yVel=0
      if shiftTime>=timeRight
      {
        shiftTime=0
        if bReverse=0
          moveProg+=1
        else
          moveProg=3
      }
    }
    else if moveProg=1 //down
    {
      xVel=0
      yVel=shiftSpd
      if shiftTime>=timeDown
      {
        shiftTime=0
        if bReverse=0
          moveProg+=1
        else
          moveProg-=1
      }
    }
    else if moveProg=2 //left
    {
      xVel=-shiftSpd
      yVel=0
      if shiftTime>=timeLeft
      {
        shiftTime=0
        if bReverse=0
          moveProg+=1
        else
          moveProg-=1
      }
    }
    else if moveProg=3 //up
    {
      xVel=0
      yVel=-shiftSpd
      if shiftTime>=timeUp
      {
        shiftTime=0
        if bReverse=0
          moveProg=0
        else
          moveProg-=1
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
  if newSprite=0 //black
  {
    draw_set_alpha(1)
    draw_set_color(c_black)
    draw_rectangle(x,y,x+(image_xscale*16),y+(image_yscale*16),0)
  }
  else if newSprite=1 //normal sprite
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
