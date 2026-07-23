#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

image_angle=270
x+=16

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false
bOut=1
switchTime=0
switchDelay=60
if variable_local_exists("bReverse")
{
  sprite_index=sTimedSpikeIn
  bCanDealDamage=0
}
if variable_local_exists("newTime")
  switchDelay=newTime
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  switchTime+=1
  if switchTime>=switchDelay
  {
    if bCanDealDamage=0
    {
      sprite_index=sTimedSpikeOut
      bCanDealDamage=1
    }
    else
    {
      sprite_index=sTimedSpikeIn
      bCanDealDamage=0
    }
    switchTime=0
  }
}
