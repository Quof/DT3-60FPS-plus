#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bReturn=0
decayTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if image_xscale=1
    image_angle-=25
  else
    image_angle+=25

  if bReturn=0
  {
    decayTime+=1
    if decayTime=40
    {
      bulletSpeed*=-1
      bReturn=1
      decayTime=0
    }
  }
  else if bReturn=1
  {
    decayTime+=1
    if decayTime=40
      instance_destroy()
  }
  speed=bulletSpeed
}
else
  speed=0
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
