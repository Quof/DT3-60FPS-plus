#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
animFrm=0
animSpd=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animFrm+=animSpd
if animFrm>=1 and animFrm<=8 {image_index=0}
else if animFrm>=9 and animFrm<=16 {image_index=1}
else if animFrm>=17 and animFrm<=24 {image_index=2}
else if animFrm>=25
{
  image_index=1
  if animFrm>=32 {animFrm=0}
}
