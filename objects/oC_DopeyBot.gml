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
eName="CHAOS Dopey Bot"
eLevel=37
maxLife=140
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=1

animate=0
runAcc=2
moveProg=0
moveTime=0

jeremyText="Just shoot it down."
chaoText="Eaten Ability: DRILL SHOT#Power: 30 (DPS: 100)#Fire Rate: 3.3/sec#It starts slow, but then gains some decent speed. It doesn't have all that much going for it other than raw power, but that's not too bad in some situations. It also fires through rocks!"
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
  if bActive=true
  {
    animate+=1
    if moveProg=0
    {
      if animate=6 {image_index=1}
      else if animate=12 {image_index=2}
      else if animate>=18 {image_index=0; animate=0}
    }
    else
    {
      if animate=6 {image_index=4}
      else if animate>=12 {image_index=3; animate=0}
    }

    if bIsSucked=0
    {
      if moveProg=0
      {
        x-=runAcc
        if x<=400
        {
          animate=0; image_index=3
          if global.shooterDifficulty>=2
          {
            var tNewAttack,tDir;
            tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
            tDir-=7
            for(i=0;i<3;i+=1)
            {
              tNewAttack=instance_create(x,y,oPassBullet)
              tNewAttack.sprite_index=sC_SparkNeedle; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
              tNewAttack.decayTime=-100; tNewAttack.direction=tDir
              tDir+=7
            }
          }
          moveProg+=1
        }
      }
      else if moveProg=1
      {
        moveTime+=1
        if moveTime>=50
        {
          image_xscale=1
          direction=point_direction(x,y,oPlayer1.x,oPlayer1.y)
          image_angle=direction-90
          moveTime=0; moveProg+=1
        }
      }
      else if moveProg=2
      {
        moveTime+=1
        if moveTime>=15 {moveProg+=1}
      }
      else if moveProg=3
      {
        speed=8
      }
    }
    else {speed=0}
  }
  enemyStepEvent()
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moveProg=3 {instance_destroy()}
