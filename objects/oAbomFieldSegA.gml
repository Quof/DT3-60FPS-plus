#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
image_xscale=0; image_yscale=0
bCanDealDamage=0

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

myProg=0
scaleWave=pi/2
moveWave=pi/2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  moveWave+=pi/50
  x+=cos(moveWave)/4

  if myProg=0
  {
    image_xscale+=0.01; image_yscale+=0.01
    if image_xscale=0.8
    {
      bCanDealDamage=1
      myProg=1
    }
  }
  else if myProg=1
  {
    scaleWave+=pi/60
    image_xscale=0.5+(sin(scaleWave+i)/8)
    image_yscale=0.5+(sin(scaleWave+i)/8)
  }
  enemyStepEvent()
}
