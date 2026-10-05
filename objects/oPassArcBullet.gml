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
_speed=0
_direction=0
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if init=0 {init=1}

  _speed=bulletSpeed
  //_direction+=arcAmt*gDeltaTime
  //60fps change (added): at 30fps the bullet turns by arcAmt, THEN arcAmt shrinks, once per tick. Shrinking it a bit every frame
  //turned the bullet less overall (~1.5-3 degrees by the end at 120fps: Dracula's meteors, Overdrive Ostrich's waves,
  //Warmaster/Fedex ice), so it landed a few px off. Above 30fps the shrink is spread over each tick with scrTickAcc and the
  //turn uses scrTickAccBPre, so every tick turns by the arcAmt it started with, like at 30fps.
  if gDeltaTime!=1 {arcAmt=scrTickAcc(arcAmt,-sign(arcAmt)*falloff,0)}
  _direction+=(arcAmt+scrTickAccBPre(0))*gDeltaTime //60fps change: was arcAmt*gDeltaTime
  image_angle=_direction

  if gDeltaTime==1 //60fps change (added): the 30fps shrink; above 30fps scrTickAcc above does it
  {
  if arcAmt!=0
  {
    if arcAmt>0 {arcAmt-=falloff*gDeltaTime}
    else {arcAmt+=falloff*gDeltaTime}
  }
  } //60fps change (added)
  //if arcAmt>-0.2 and arcAmt<0.2 {arcAmt=0}
  var tTickEnd; tTickEnd=1 //60fps change (added): above 30fps, only snap at the end of a tick (when arcAmt is exactly the 30fps value), not partway through one
  if gDeltaTime!=1 {tTickEnd=(tkK[0]>=round(1/gDeltaTime))} //60fps change (added)
  if arcAmt>-0.2 and arcAmt<0.2 and tTickEnd {arcAmt=0} //60fps change: added "and tTickEnd"

  if decayTime!=-100
  {
    decayTime-=1*gDeltaTime
    if decayTime<=0 {instance_destroy()}
  }
  //_speed=0
}
else {_speed=0}
correctSpeedDirection(self)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100 and init=1 {instance_destroy()}
