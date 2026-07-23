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
stunResist=50
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
  x+=sin(oGame.time/2.5+waveOffset)
  if room=rVault_5
  {
    if oVAbom_P1_Main.sequence=5 {y+=2}
  }
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
if room=rVault_5 {oVAbom_P1_Main.damageTaken+=tDmgA-tDmgB}
else if room=rVault_6 {oVAbom_P3_Main.damageTaken+=tDmgA-tDmgB}
