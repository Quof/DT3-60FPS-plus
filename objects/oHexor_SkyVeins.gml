#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
scaleUp=1
scaleTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if scaleUp=1
{
  image_xscale+=0.002*gDeltaTime
  image_yscale+=0.002*gDeltaTime
}
else
{
  image_xscale-=0.002*gDeltaTime
  image_yscale-=0.002*gDeltaTime
}

scaleTime+=1
if scaleTime>=45
{
  scaleUp=!scaleUp
  scaleTime=0
}
