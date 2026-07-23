#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//If rotating, requires: rotationRate, rotateMax, rotateMin
bRotate=false
rotateProg=0
rotateCurr=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("rotationRate") {bRotate=true}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bRotate=true
  {
    if rotateProg=0 //Rotate
    {
      image_angle+=rotationRate; rotateCurr+=rotationRate
      if rotateCurr>=rotateMax {rotateProg=1}
      else if rotateCurr<=rotateMin {rotateProg=1}
    }
    else if rotateProg>=1 //Stop at end
    {
      rotateProg+=1
      if rotateProg>=30 {rotationRate*=-1; rotateProg=0}
    }
  }
}
