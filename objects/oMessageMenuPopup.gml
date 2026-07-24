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
showMessage(view_xview[0]+x,view_yview[0]+y,message,"",0,image_alpha)
