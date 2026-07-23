#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanBeSucked=1
suckReady=0
suckThres=0.45
weaponGive=0
bIsSucked=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bIsSucked>0 {bIsSucked-=1}

if lifePercent<=suckThres and suckReady=0 and bCanBeSucked=1
{
  baseColor=make_color_rgb(255,135,115)
  image_blend=baseColor
  suckReady=1
}
