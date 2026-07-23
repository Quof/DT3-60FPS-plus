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
eName="CHAOS Sparker"
eLevel=37
maxLife=60
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=4

moveProg=0
moveWave=pi/2
runAcc=1.75
bulletTime=45
bulletDir=0
if global.shooterDifficulty=1 {bulletNum=12}
else {bulletNum=18}

jeremyText="Just shoot it down."
chaoText="Eaten Ability: HOMING NEEDLE#Power: 11 (DPS: 66)#Fire Rate: 6/sec#This finds the closest target and arcs its direction toward that. It has the lowest damage per second of any weapon you'll find out here."
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

      bulletTime+=1
      if bulletTime>=80 and x>32
      {
        if bulletTime mod 14=0
        {
          var tNewAttack,tDir;
          tDir=0
          for(i=0;i<bulletNum;i+=1)
          {
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sC_SparkNeedle; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
            tNewAttack.decayTime=-100; tNewAttack.direction=bulletDir+tDir
            tDir+=360/bulletNum
          }
          bulletDir+=12
          if bulletDir>=24
          {
            bulletDir=0
            bulletTime=0
          }
        }
      }

      if x<=208 {moveProg=1}
    }
    else if moveProg=1
    {
      x-=runAcc*3
    }

    if x<=-32 {instance_destroy()}
  }
  enemyStepEvent()
}
