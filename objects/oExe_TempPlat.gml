#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  colCorner[i]=i*60
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  colCorner[i]+=3
  if colCorner[i]>=255 {colCorner[i]-=255}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_rectangle_color(x,y,x+15,y+15,make_color_hsv(colCorner[0],255,255),make_color_hsv(colCorner[1],255,255),make_color_hsv(colCorner[2],255,255),make_color_hsv(colCorner[3],255,255),0)
