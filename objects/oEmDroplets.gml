#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dropTime=irandom(65)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dropTime+=1*gDeltaTime
if dropTime>=150
{
  instance_create(x,y,oEfDroplet)
  dropTime=irandom(65)
}
