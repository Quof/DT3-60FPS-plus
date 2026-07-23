#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_xscale=-1
bActive=1

//Enemy base statistics
eName="CHAOS Rocket Turtle"
eLevel=37
maxLife=140
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=3

runAcc=1
bulletTime=5
bulletCycle=1
bulletCheck=0
if global.shooterDifficulty=1 {bulletMax=1}
else {bulletMax=3}

jeremyText="Just shoot it down."
chaoText="Eaten Ability: SPREAD SHOT#Power: 11 (DPS: 47 (Up to 3x if all 3 bullets hit))#Fire Rate: 4.2/sec#This fires a bit slower than your standard shot and deals the same damage, however it fires 3 projectiles like a spread cannon. Its potential DPS is better than a lot of weapons on single targets, but you have to be nearly point blank to do that."
devText="N/A"

myTurtle=instance_create(x,y,oCW_RocketT)
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
    x-=runAcc

    if instance_exists(myTurtle)
    {
      bulletTime+=1
      if bulletTime>=60 and x>96
      {
        if bulletTime mod 12=0
        {
          var tNewAttack,tDir,bulletNum;
          if bulletCycle=0
          {
            tDir=point_direction(myTurtle.x-22,myTurtle.y+23,oPlayer1.x,oPlayer1.y)
            tDir-=30
            bulletNum=3
            bulletCycle=1
          }
          else
          {
            tDir=point_direction(myTurtle.x-22,myTurtle.y+23,oPlayer1.x,oPlayer1.y)
            tDir-=15
            bulletNum=2
            bulletCycle=0
          }

          for(i=0;i<bulletNum;i+=1)
          {
            tNewAttack=instance_create(myTurtle.x-22,myTurtle.y+23,oPassBullet)
            tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
            tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.direction=tDir
            tDir+=30
          }
          bulletCheck+=1
          if bulletCheck>=bulletMax
          {
            bulletCheck=0
            bulletTime=0
          }
        }
      }
    }

    if x<=-48 {instance_destroy()}
  }
  enemyStepEvent()
}
