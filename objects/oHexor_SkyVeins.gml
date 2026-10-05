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

//scaleTime+=1
scaleTime+=1*gDeltaTime //60fps change: the pulse was 2x/4x as fast and 1/2 or 1/4 as wide at 60/120fps
if scaleTime>=45
{
  scaleUp=!scaleUp
  scaleTime=0
}
