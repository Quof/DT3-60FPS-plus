#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//set in the instance creation code
if !variable_local_exists("doorId2")
  image_yscale=doorId1.stepScale*scaleFactor
else
{
  if doorId1.stepScale<doorId2.stepScale
    image_yscale=doorId1.stepScale*scaleFactor
  else
    image_yscale=doorId2.stepScale*scaleFactor
}

draw_sprite_ext(sStepSwitchBottom,-1,x,y,1,image_yscale,image_angle,image_blend,1)
