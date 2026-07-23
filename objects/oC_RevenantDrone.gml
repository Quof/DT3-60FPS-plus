#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_xscale=-1
image_speed=0.25

//Enemy base statistics
eName="CHAOS Revenant Drone"
eLevel=37
maxLife=90
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=102

animate=0
moveDir=0
moveProg=0
runAcc=1.5
bulletTime=30
if global.shooterDifficulty=1 {bulletDelay=60; bulletMax=5}
else {bulletDelay=50; bulletMax=8}
bulletDir=0
bulletCheck=0

jeremyText="Just shoot it down."
chaoText="Eaten Ability: PLASMA DRONE#Power: 20#Fire Rate: 1.2/sec#While its damage per second may be low, it's extra firepower if you need it. The drone fires a plasma shot toward the closest enemy. Note that it only fires if the fire button is held down."
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
    if bulletTime<bulletDelay or x<33
    {
      x-=runAcc
      moveDir+=1
      if moveDir>=1 and moveDir<=35 {y+=runAcc}
      else if moveDir>=36 and moveDir<=70
      {
        y-=runAcc
        if moveDir=70 {moveDir=0}
      }
    }

    bulletTime+=1
    if bulletTime=bulletDelay-1
    {
      shotDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
    }
    if bulletTime>=bulletDelay and x>32
    {
      if bulletTime mod 2=0
      {
        var tNewAttack;
        tNewAttack=instance_create(x,y,oCW_ArcBullet)
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=shotDir
        bulletCheck+=1
        if bulletCheck>=bulletMax
        {
          bulletCheck=0
          bulletTime=0
        }
      }
    }

    if x<=-32 {instance_destroy()}
  }
  enemyStepEvent()
}
