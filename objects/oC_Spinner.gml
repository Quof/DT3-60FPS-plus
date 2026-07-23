#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1

//Enemy base statistics
eName="CHAOS Spinner"
eLevel=37
maxLife=70
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=2

moveWave=pi/2
runAcc=2
missileTime=5
if global.shooterDifficulty=1 {missileDelay=45}
else {missileDelay=35}

jeremyText="Just shoot it down."
chaoText="Eaten Ability: STICKY BOMB#Power: 40 (DPS: 92)#Fire Rate: 2.3/sec#This fires slow, but the velocity is decent. When it touches an enemy, it attaches itself and then explodes about 1 second later. The explosion is an AOE, so you could possibly use that to your advantage. Bombs that are attached to an enemy that is destroyed will not explode."
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
    moveWave+=pi/60
    y+=sin(moveWave)
    x-=runAcc

    missileTime+=1
    if missileTime>=missileDelay and x>32
    {
      var tAtk;
      tAtk=instance_create(x+6,y-4,oCW_SpinMissile)
      tAtk.atkPower=atkPower; tAtk.turnDir=2
      tAtk=instance_create(x+6,y+4,oCW_SpinMissile)
      tAtk.atkPower=atkPower; tAtk.turnDir=-2
      missileTime=0
    }

    if x<=-32 {instance_destroy()}
  }
  enemyStepEvent()
}
