#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sScaledCollision

shiftTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bShifting=1
  {
    x+=xSpd
    y+=ySpd

    shiftTime+=1
    if shiftTime>=shiftMax
    {
      xSpd*=-1
      ySpd*=-1
      shiftTime=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
colorInverter(0,image_xscale,image_yscale)
