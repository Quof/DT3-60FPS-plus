#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=0; image_yscale=0
image_angle=270
bCanTakeDamage=false
bActive=true

//Enemy base statistics
eName="Abomination"
if global.modeWahfuu=1 {eName="Wahfuu"}
maxLife=1000000
life=maxLife
atkPower=9
affiliation=9
bIsBoss=true
bNoBonus=true

bMove=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if image_xscale<1.5
  {
    image_xscale+=0.02; image_yscale+=0.02
  }
  if bMove=1 {image_angle+=sin(oGame.time/2.5+waveOffset)}
  enemyStepEvent()
}
