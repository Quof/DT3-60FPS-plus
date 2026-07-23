#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.optMessagePlink=1 {playSound(global.snd_MessagePlink,0,1,1)}
window=0
talker=""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadingTime>0
{
  fadingTime-=1
  if fadingTime<=20
    image_alpha-=0.05
}
else
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMessage(view_xview[0]+x,view_yview[0]+y,message,talker,c_black,image_alpha,window)
