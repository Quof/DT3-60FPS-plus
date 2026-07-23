#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2
bChained=0
autoMove=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("chainMax")
{
  bChained=1
  leftEnd=x-(chainMax/2)
  rightEnd=x+(chainMax/2)

  if variable_local_exists("flipMe")
  {
    bChained=2
    leftEnd=y-(chainMax/2)
    rightEnd=y+(chainMax/2)
  }

  moveProg=0
  if variable_local_exists("moveCheck")
  {
    autoMove=moveCheck
    moveProg=newMove
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if autoMove=1 //Auto move left and right
  {
    if moveProg=0
    {
      x+=moveSpd
      if x>rightEnd {moveProg=1}
    }
    else if moveProg=1
    {
      x-=moveSpd
      if x<leftEnd {moveProg=0}
    }
  }
  else if autoMove=2 //Auto move up and down
  {
    if moveProg=0
    {
      y+=moveSpd
      if y>rightEnd {moveProg=1}
    }
    else if moveProg=1
    {
      y-=moveSpd
      if y<leftEnd {moveProg=0}
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bChained>=1
{
  draw_set_color(c_gray)
  draw_set_alpha(0.7)
  if bChained=1
  {
    for(i=0;i<chainMax/6;i+=1)
    {
      draw_sprite_ext(sPlatformChainA,0,leftEnd+(i*6),y,1,1,90,image_blend,1)
    }
    draw_circle(leftEnd,y,6,0)
    draw_circle(rightEnd,y,6,0)
  }
  else if bChained=2
  {
    for(i=0;i<chainMax/6;i+=1)
    {
      draw_sprite_ext(sPlatformChainA,0,x,leftEnd+(i*6),1,1,0,image_blend,1)
    }
    draw_circle(x,leftEnd,6,0)
    draw_circle(x,rightEnd,6,0)
  }
}
draw_set_color(c_gray)
draw_set_alpha(0.05)
draw_circle(x,y,192,0)
draw_set_alpha(0.35)
draw_circle(x,y,192,1)
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,0.8)
draw_sprite_ext(sprite_index,image_index,x,y,1.5,1.5,image_angle,image_blend,0.4)
draw_sprite_ext(sprite_index,image_index,x,y,2,2,image_angle,image_blend,0.2)
draw_sprite_ext(sprite_index,image_index,x,y,3,3,image_angle,image_blend,0.1)
