#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

damageType="EXPLOSION"
weaponTag=108
atkPower=250
stunTime=5
bCanPierce=1
blastTime=0 //60fps change (added): see the Step
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  image_index+=0.25*gDeltaTime
  //if image_index>=5.7
  blastTime+=1*gDeltaTime
  if blastTime>=15 //60fps change: GM's own image_speed (1) also runs and wraps the 6-frame sprite, so at 30fps the index only lands on 5.75 on the 15th tick (three loops); in smaller per-frame steps it kept jumping past 5.7-6 and the wave looped on and on at 60/120fps. Ends on the 15th tick, as at 30fps
  {
    instance_destroy()
  }
}
