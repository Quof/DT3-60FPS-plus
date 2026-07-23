#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//global.recPeopleTalkedTo+=1
bFading=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bFading=false
{
  if instance_exists(idCheck)
  {
    x=idCheck.x-xOffset
    y=idCheck.y-yOffset
    if x<0 {x=0}
    else if x+xOffset*2>room_width {x=room_width-xOffset*2}

    fadingTime-=1
    if fadingTime<=0 {bFading=true}
  }
  else {bFading=true}
}
else
{
  image_alpha-=0.05
  if image_alpha<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMessage(x,y,message,talker,6,image_alpha,boxSize)
