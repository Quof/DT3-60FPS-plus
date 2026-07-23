#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: pieceNum,delayTime
event_inherited()
bActive=true
visible=0
image_xscale=0.04; image_yscale=0.04
bCanDealDamage=0
bCanTakeDamage=0

//Enemy base statistics
eName="Abomination"
eLevel=39
maxLife=1000000
life=maxLife
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
affiliation=9
bIsBoss=true
bNoBonus=true

myProg=0
scaleWave=pi/2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if myProg=0
  {
    if delayTime>0 {delayTime-=1}
    else
    {
      visible=1
      image_xscale+=0.04; image_yscale+=0.04
      if image_xscale>=1
      {
        bCanDealDamage=1
        bCanTakeDamage=1
        myProg=1
      }
    }
  }
  else if myProg=1
  {
    scaleWave+=pi/50
    image_xscale=0.85+(sin(scaleWave)/4)
    image_yscale=0.85+(sin(scaleWave)/4)
  }
  enemyStepEvent()
}
