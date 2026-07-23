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
waggleTime+=1
if waggleTime>=20
{
  image_alpha-=0.04
  if image_alpha<=0
    instance_destroy()
}
