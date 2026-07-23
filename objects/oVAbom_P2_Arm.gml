#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=2; image_yscale=2
bActive=true

//Enemy base statistics
eName="Abomination"
if global.modeWahfuu=1 {eName="Wahfuu"}
eLevel=20
maxLife=1000000
life=maxLife
atkPower=9
affiliation=9
bIsBoss=true
bNoBonus=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life<100000 {life=1000000}
  y+=sin(oGame.time/2.5+waveOffset)
  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tDmgA,tDmgB;
tDmgA=life
event_inherited()
tDmgB=life
oVAbom_P2_Main.damageTaken+=tDmgA-tDmgB
