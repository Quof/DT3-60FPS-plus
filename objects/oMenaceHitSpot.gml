#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- MENACE: HIT SPOT (BODY) -----
event_inherited()

//Enemy base statistics
eName="Menace"
eLevel=11
maxLife=7300
life=maxLife
atkPower=oMenaceMain.atkPower
affiliation=3
resType[0]=4
resType[2]=4
bIsBoss=true
bNoBonus=true
dieEffect=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oMenaceMain.x-43
  y=oMenaceMain.y+22
  enemyStepEvent()
}
