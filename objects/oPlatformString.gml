#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initSet=0
x+=8
y+=8
findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initSet=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initSet=1
{
  findTargetX=point_distance(oCharacter.x,0,x,0)
  findTargetY=point_distance(0,oCharacter.y,0,y)
  if findTargetX<drawRangeX and findTargetY<drawRangeY
  {
    draw_set_color(c_black)
    var circleRad,circleAlpha;
    circleRad=2
    circleAlpha=1
    for(i=0;i<6;i+=1)
    {
      draw_set_alpha(circleAlpha)
      draw_circle(x,y,circleRad,0)
      circleRad+=1.5
      circleAlpha-=0.15
    }
    draw_set_alpha(0.75)
    for(i=0;i<maxString;i+=1)
    {
      draw_line_width(x,y,stringTo[i].x+offsetX,stringTo[i].y+offsetY,2)
    }
  }
}
