#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bulletSpeed,arcAmt,falloff,decayTime
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
init=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if init=0 {init=1}

  speed=bulletSpeed
  direction+=arcAmt
  image_angle=direction

  if arcAmt!=0
  {
    if arcAmt>0 {arcAmt-=falloff}
    else {arcAmt+=falloff}
  }
  if arcAmt>-0.2 and arcAmt<0.2 {arcAmt=0}

  if decayTime!=-100
  {
    decayTime-=1
    if decayTime<=0 {instance_destroy()}
  }
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100 and init=1 {instance_destroy()}
