#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=1.75; image_yscale=1.75
bActive=true
bCanDealDamage=false

//Enemy base statistics
eName="Abomination"
if global.modeWahfuu=1 {eName="Wahfuu"}
eLevel=39
maxLife=1000000
life=maxLife
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=50
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
  x+=sin(oGame.time/2.5+waveOffset)
  enemyStepEvent()
}
