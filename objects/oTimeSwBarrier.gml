#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: swAmount,switchID[i]
image_alpha=0.75
switchCount=0
lineColor=c_white
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_alpha=0.75 {image_alpha=0.25}
else {image_alpha=0.75}

//set in the instance creation code
switchCount=swAmount
for(i=0;i<swAmount;i+=1)
{
  if switchID[i].activated=1
    switchCount-=1
}
if switchCount<=0
{
  for(i=0;i<swAmount;i+=1)
    switchID[i].activated=2
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
//draw connecting lines
for(i=0;i<swAmount;i+=1)
{
  draw_set_alpha(0.4)
  draw_set_color(lineColor)
  if i=swAmount-1
  {
    if swAmount>2
      draw_line(switchID[i].x+8,switchID[i].y+8,switchID[0].x+8,switchID[0].y+8)
  }
  else
    draw_line(switchID[i].x+8,switchID[i].y+8,switchID[i+1].x+8,switchID[i+1].y+8)
}
