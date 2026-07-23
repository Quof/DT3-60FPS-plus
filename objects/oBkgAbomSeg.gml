#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: maxScale
image_xscale=0; image_yscale=0
image_blend=c_gray

myProg=0
scaleWave=pi/2
moveWave=pi/2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  moveWave+=pi/50
  x+=cos(moveWave)/4

  if myProg=0
  {
    image_xscale+=0.01; image_yscale+=0.01
    if image_xscale=maxScale
    {
      myProg=1
    }
  }
  else if myProg=1
  {
    scaleWave+=pi/60
    image_xscale=0.65+(sin(scaleWave)/8)
    image_yscale=0.65+(sin(scaleWave)/8)
  }
}
