#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_alpha=0.4+random(0.1)
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
{
  hspeed=random_range(-1,1)
  vspeed=random_range(1,2)
  var tRanScl;
  tRanScl=0.3+random(0.7)
  image_xscale=tRanScl
  image_yscale=tRanScl
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hspeed>=0 {image_angle-=2}
else {image_angle+=2}

if x<-16
  instance_destroy()
else if x>=room_width+16
  instance_destroy()
else if y>=room_height+16
  instance_destroy()
