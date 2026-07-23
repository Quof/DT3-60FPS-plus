#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if y<=0
{
  image_yscale+=16
  y-=256
}

var yLimit;
yLimit=y+(image_yscale*16)
if yLimit>=room_height
{
  image_yscale+=8
}
