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
  if signSize=0 {tBoxOffsetX=140}
  else if signSize=1 {tBoxOffsetX=200}
  else if signSize=2 {tBoxOffsetX=260}
  else if signSize=3 {tBoxOffsetX=320}

  if x<0 {x=0}
  else if x+tBoxOffsetX>room_width {x=room_width-tBoxOffsetX}
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
showMessage(x,y,message,"",6,image_alpha,signSize)
