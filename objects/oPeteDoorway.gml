#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
y+=2
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0
{
  myMouthpiece=instance_create(x,y-2,oPeteDoorway)
  myMouthpiece.image_xscale=image_xscale
  myMouthpiece.image_index=1
  myMouthpiece.type=1
  myMouthpiece.depth=21
}
