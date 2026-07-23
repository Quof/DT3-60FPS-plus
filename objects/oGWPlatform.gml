#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
-- Requires: startPos, maxDist, type
*/

viscidTop=1
makeActive()

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
moveSpd=2
startFrm=0
endFrm=0
animSpd=0.33
deathCheck=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type>=2
{
  sprite_index=sInvisibleSolidMask
  image_yscale=4
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if instance_exists(oMMXgravityWell)
  {
    var nearGW,tGWDist_Start,tGWDist_End;
    nearGW=instance_nearest(x+32,y+8,oMMXgravityWell)
    if nearGW.sprite_index=sMMXgravityWell1 //Check distance to sides
    {
      if type=0 //Horizontal
      {
        if point_distance(startPos,y+8,nearGW.x,nearGW.y)<=16 {nearGW.gravityProg=1}
        if point_distance(startPos+maxDist+64,y+8,nearGW.x,nearGW.y)<=16 {nearGW.gravityProg=1}
      }
      else if type=1 //Vertical
      {
        if point_distance(x+32,startPos,nearGW.x,nearGW.y)<=16 {nearGW.gravityProg=1}
        if point_distance(x+32,startPos+maxDist+16,nearGW.x,nearGW.y)<=16 {nearGW.gravityProg=1}
      }
      else if type=2 //Horizontal - 90 degrees
      {
        if point_distance(startPos,y+32,nearGW.x,nearGW.y)<=16 {nearGW.gravityProg=1}
        if point_distance(startPos+maxDist+16,y+32,nearGW.x,nearGW.y)<=16 {nearGW.gravityProg=1}
      }
      else if type=3 //Vertical - 90 degrees
      {
        if point_distance(x+8,startPos,nearGW.x,nearGW.y)<=16 {nearGW.gravityProg=1}
        if point_distance(x+8,startPos+maxDist+64,nearGW.x,nearGW.y)<=16 {nearGW.gravityProg=1}
      }
    }
    else if nearGW.sprite_index=sMMXgravityWell3 //Attract platform
    {
      if type=0 //Horizontal
      {
        tGWDist_Start=point_distance(startPos+32,y+8,nearGW.x,nearGW.y)
        tGWDist_End=point_distance(startPos+32+maxDist,y+8,nearGW.x,nearGW.y)
        if tGWDist_Start<tGWDist_End //Left
        {
          if tGWDist_Start<104 and x>startPos {xVel=-moveSpd; startFrm+=animSpd}
          else {xVel=0}
        }
        else //Right
        {
          if tGWDist_End<104 and x<startPos+maxDist {xVel=moveSpd; endFrm+=animSpd}
          else {xVel=0}
        }
      }
      else if type=1 //Vertical
      {
        tGWDist_Start=point_distance(x+32,startPos+8,nearGW.x,nearGW.y)
        tGWDist_End=point_distance(x+32,startPos+8+maxDist,nearGW.x,nearGW.y)
        if tGWDist_Start<tGWDist_End //Up
        {
          if tGWDist_Start<104 and y>startPos {yVel=-moveSpd; startFrm+=animSpd}
          else {yVel=0}
        }
        else //Down
        {
          if tGWDist_End<104 and y<startPos+maxDist {yVel=moveSpd; endFrm+=animSpd}
          else {yVel=0}
        }
      }
      else if type=2 //Horizontal - 90 degrees
      {
        tGWDist_Start=point_distance(startPos+8,y+32,nearGW.x,nearGW.y)
        tGWDist_End=point_distance(startPos+8+maxDist,y+32,nearGW.x,nearGW.y)
        if tGWDist_Start<tGWDist_End //Left
        {
          if tGWDist_Start<104 and x>startPos {xVel=-moveSpd; startFrm+=animSpd}
          else {xVel=0}
        }
        else //Right
        {
          if tGWDist_End<104 and x<startPos+maxDist {xVel=moveSpd; endFrm+=animSpd}
          else {xVel=0}
        }
      }
      else if type=3 //Vertical - 90 degrees
      {
        tGWDist_Start=point_distance(x+8,startPos+32,nearGW.x,nearGW.y)
        tGWDist_End=point_distance(x+8,startPos+32+maxDist,nearGW.x,nearGW.y)
        if tGWDist_Start<tGWDist_End //Up
        {
          if tGWDist_Start<104 and y>startPos {yVel=-moveSpd; startFrm+=animSpd}
          else {yVel=0}
        }
        else //Down
        {
          if tGWDist_End<104 and y<startPos+maxDist {yVel=moveSpd; endFrm+=animSpd}
          else {yVel=0}
        }
      }
    }
    else {xVel=0; yVel=0}
  }
  else {xVel=0; yVel=0}
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
  draw_set_alpha(0.8)
  draw_set_color(c_black)
  if type=0 //Horizontal
  {
    draw_line_width(startPos,y+8,startPos+maxDist+64,y+8,2)
    draw_sprite_ext(sGWPlatEnd,startFrm,startPos,y+8,0.75,0.75,0,image_blend,image_alpha)
    draw_sprite_ext(sGWPlatEnd,endFrm,startPos+maxDist+64,y+8,0.75,0.75,0,image_blend,image_alpha)
  }
  else if type=1 //Vertical
  {
    draw_line_width(x+32,startPos,x+32,startPos+maxDist+16,2)
    draw_sprite_ext(sGWPlatEnd,startFrm,x+32,startPos,0.75,0.75,0,image_blend,image_alpha)
    draw_sprite_ext(sGWPlatEnd,endFrm,x+32,startPos+maxDist+16,0.75,0.75,0,image_blend,image_alpha)
  }
  else if type=2 //Horizontal - 90 degrees
  {
    draw_line_width(startPos,y+32,startPos+maxDist+16,y+32,2)
    draw_sprite_ext(sGWPlatEnd,startFrm,startPos,y+32,0.75,0.75,0,image_blend,image_alpha)
    draw_sprite_ext(sGWPlatEnd,endFrm,startPos+maxDist+16,y+32,0.75,0.75,0,image_blend,image_alpha)
  }
  else if type=3 //Vertical - 90 degrees
  {
    draw_line_width(x+8,startPos,x+8,startPos+maxDist+64,2)
    draw_sprite_ext(sGWPlatEnd,startFrm,x+8,startPos,0.75,0.75,0,image_blend,image_alpha)
    draw_sprite_ext(sGWPlatEnd,endFrm,x+8,startPos+maxDist+64,0.75,0.75,0,image_blend,image_alpha)
  }

  if type=0 or type=1 {draw_sprite_ext(sGWPlatform,image_index,x,y,1,1,0,image_blend,image_alpha)}
  else if type=2 or type=3 {draw_sprite_ext(sGWPlatform,image_index,x+16,y,1,1,270,image_blend,image_alpha)}
}
