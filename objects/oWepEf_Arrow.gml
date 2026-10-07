#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
waggleTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//waggleTime+=1
waggleTime+=1*gDeltaTime //60fps change: stuck arrows started fading after half/quarter the time at 60/120fps
if waggleTime>=20
{
  image_alpha-=0.04*gDeltaTime
  if image_alpha<=0
    instance_destroy()
}
