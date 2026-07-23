#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_xscale=-1
image_speed=0

//Enemy base statistics
eName="CHAOS Butterdroid"
eLevel=37
maxLife=50
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=5

animate=0
moveProg=0
runAcc=3
bulletTime=35
if global.shooterDifficulty=1 {bulletDelay=70; bulletMax=3; bulletMod=22}
else {bulletDelay=60; bulletMax=5; bulletMod=17}
bulletDir=0
bulletCheck=0

jeremyText="Just shoot it down."
chaoText="Eaten Ability: DUAL SHOT#Power: 14 (DPS: 60 (2x if both bullets hit))#Fire Rate: 4.2/sec#This fires 2 shots straight ahead. However, the shots will angle themselves up or down at the moment they are fired, toward the direction your ship is moving."
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
    if animate=3 {image_index=1}
    else if animate=6 {image_index=2}
    else if animate=9 {image_index=3}
    else if animate=12 {image_index=4}
    else if animate=15 {image_index=3}
    else if animate=18 {image_index=1}
    else if animate>=21 {image_index=0; animate=0}

    if bIsSucked=0
    {
      if moveProg=0
      {
        x-=runAcc
        if x<=400 {moveProg+=1}
      }
      else if moveProg>=1 and moveProg<=2
      {
        bulletTime+=1
        if bulletTime>=bulletDelay
        {
          if bulletTime mod 7=0
          {
            var tNewAttack;
            tNewAttack=instance_create(x,y,oPassBullet)
            tNewAttack.sprite_index=sC_ButterSpark; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
            tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y)
            bulletCheck+=1
            if bulletCheck>=bulletMax
            {
              bulletCheck=0
              bulletTime=0
              moveProg+=1
            }
          }
        }
      }
      else if moveProg=3
      {
        bulletTime+=1
        if bulletTime>=15 {bulletTime=0; moveProg+=1}
      }
      else if moveProg=4
      {
        x-=runAcc
        bulletTime+=1
        if bulletTime mod bulletMod=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sC_ButterSpark; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
          tNewAttack.decayTime=-100; tNewAttack.direction=90
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sC_ButterSpark; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
          tNewAttack.decayTime=-100; tNewAttack.direction=270
        }
      }
    }

    if x<=-32 {instance_destroy()}
  }
  enemyStepEvent()
}
