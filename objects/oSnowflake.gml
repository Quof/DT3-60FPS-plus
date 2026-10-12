#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_alpha=0.4+random(0.1)
alarm[0]=1
_hspeed=0
_vspeed=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
{
  _hspeed=random_range(-1,1)
  _vspeed=random_range(1,2)
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
if _hspeed>=0 {image_angle-=2*gDeltaTime}
else {image_angle+=2*gDeltaTime}

if x<-16
  instance_destroy()
else if x>=room_width+16
  instance_destroy()
else if y>=room_height+16
  instance_destroy()
//60fps change (added): storm flakes (type 2) fly in a straight line faster than the view moves, so once one has left the
//view it can't be seen again. They lived until they left the room (hundreds at once in the large ice rooms), which
//lagged at 60/120fps where each one runs every frame
else if type=2 and (y>=view_yview[0]+view_hview[0]+32 or (_hspeed>0 and x>=view_xview[0]+view_wview[0]+32) or (_hspeed<0 and x<view_xview[0]-32))
  instance_destroy()

//correctHSpeedVSpeed(self)
x+=_hspeed*gDeltaTime; y+=_vspeed*gDeltaTime //60fps change: the same move without the script call (Create sets both), as there are many flakes
