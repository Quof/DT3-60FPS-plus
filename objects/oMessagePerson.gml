#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.optMessagePlink=1 {playSound(global.snd_MessagePlink,0,1,1)}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadingTime>0
{
  fadingTime-=1*gDeltaTime
  if fadingTime<=20
    image_alpha-=0.05*gDeltaTime
}
else
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMessage(view_xview[0]+x,view_yview[0]+y,message,talker,wColor,image_alpha,wSize)
