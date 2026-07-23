#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_blend=c_green
flashTime=0
innerAlpha=0.3

clF[0]=63
clF[1]=126
clF[2]=189
clF[3]=252
for(i=0;i<4;i+=1)
  clDown[i]=0
cField[0]=make_color_rgb(clF[0],clF[3],clF[2])
cField[1]=make_color_rgb(clF[1],clF[0],clF[3])
cField[2]=make_color_rgb(clF[2],clF[1],clF[0])
cField[3]=make_color_rgb(clF[3],clF[2],clF[1])
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
textAmount+=round(zoneWidth/6)+round(zoneHeight/8)
for(i=0;i<round(zoneWidth/12)+round(zoneHeight/16);i+=1)
{
  var tRanValue;
  tRanValue=irandom(10)
  if tRanValue<=2
    textScramble+="0101"
  else if tRanValue>=3 and tRanValue<=5
    textScramble+="1010"
  else if tRanValue>=6 and tRanValue<=7
    textScramble+="0011"
  else if tRanValue>=8
    textScramble+="1100"
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if zoneType=0 //Square
  {
    if collision_rectangle(x,y,x+zoneWidth,y+zoneHeight,oPlayer1,0,1)
    {
      oPlayer1.dashEnergy=0
      if flashTime=0
      {
        if innerAlpha=0.3
          innerAlpha=0.25
        else
          innerAlpha=0.3
        flashTime=3
      }
      else
        flashTime-=1
    }
    else
    {
      flashTime=0
      innerAlpha=0.3
    }
  }
  else if zoneType=1 //Circle
  {
    if collision_circle(x,y,zoneRadius,oPlayer1,0,1)
    {
      oPlayer1.dashEnergy=0
      if flashTime=0
      {
        if innerAlpha=0.3
          innerAlpha=0.25
        else
          innerAlpha=0.3
        flashTime=3
      }
      else
        flashTime-=1
    }
    else
    {
      flashTime=0
      innerAlpha=0.3
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if zoneType=0 //Square
{
  draw_set_color(image_blend)
  draw_set_alpha(innerAlpha)
  draw_set_font(fnt_Swap)

  for(i=0;i<4;i+=1)
  {
    if clDown[i]=0
    {
      clF[i]+=3
      if clF[i]=255
        clDown[i]=1
    }
    else if clDown[i]=1
    {
      clF[i]-=3
      if clF[i]=0
        clDown[i]=0
    }
  }

  cField[0]=make_color_rgb(clF[0],clF[3],clF[2])
  cField[1]=make_color_rgb(clF[1],clF[0],clF[3])
  cField[2]=make_color_rgb(clF[2],clF[1],clF[0])
  cField[3]=make_color_rgb(clF[3],clF[2],clF[1])
  draw_rectangle_color(x,y,x+zoneWidth-1,y+zoneHeight-1,cField[0],cField[1],cField[2],cField[3],0)
  draw_set_alpha(0.9)
  draw_rectangle(x,y,x+zoneWidth-1,y+zoneHeight-1,1)
}
else if zoneType=1 //Circle
{
  draw_set_color(image_blend)
  draw_set_alpha(innerAlpha)
  draw_circle(x,y,zoneRadius,0)
  draw_set_alpha(0.9)
  draw_circle(x,y,zoneRadius,1)
}
