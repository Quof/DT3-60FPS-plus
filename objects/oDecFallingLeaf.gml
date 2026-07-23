#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hspeed=random_range(-1,1)
vspeed=random_range(1,2)
image_speed=0.2+(vspeed/10)
if hspeed<0
  image_xscale=-1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if x<-16
  instance_destroy()
else if x>=room_width+16
  instance_destroy()
else if y>=room_height+16
  instance_destroy()
