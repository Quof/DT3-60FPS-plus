#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//pythagorean theorem: sqrt(sqr(room_width)+sqr(room_height))
image_alpha=0
xx=0
yy=0
initVars=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initVars=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initVars=1
{
  distToPoint=point_distance(x,y,oPlayer1.x,oPlayer1.y)
  image_alpha=(1-(distToPoint/fuzzRange))*maxFuzz
  if image_alpha>=maxFuzz
    image_alpha=maxFuzz

  if room=rMain_17
  {
    if image_alpha>=0.75 {oPlayer1.life-=oPlayer1.maxLife}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initVars=1
{
  draw_background_tiled_ext(backStatic,xx,yy,1,1,c_white,image_alpha)
  xx+=31
  yy+=21
}
