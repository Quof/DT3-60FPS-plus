#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1
bActive=1

//Enemy base statistics
eName="CHAOS Robo Chicken"
eLevel=37
maxLife=60
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=201

moveProg=0
moveWave=pi/2
runAcc=1.5

jeremyText="Just shoot it down. It can't even fire back."
chaoText="Eaten Ability: LIFE UP#This simply restores 2 hearts of HP."
devText="N/A"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  event_inherited()
  if bActive=true and bIsSucked=0
  {
    if moveProg=0
    {
      moveWave+=pi/60
      y+=sin(moveWave)*2
      x-=runAcc
    }
    if x<=-32 {instance_destroy()}
  }
  enemyStepEvent()
}
