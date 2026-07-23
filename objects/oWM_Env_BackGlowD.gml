#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
glowProg=0
colorBlend=255
depth=1000010
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if glowProg=0
{
  colorBlend-=1
  if colorBlend<=190 {glowProg=1}
}
else if glowProg=1
{
  colorBlend+=1
  if colorBlend>=255 {glowProg=0}
}

image_blend=make_color_rgb(colorBlend,colorBlend,255)
