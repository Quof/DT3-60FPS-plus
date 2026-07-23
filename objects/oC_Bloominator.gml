#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_angle=180

//Enemy base statistics
eName="CHAOS Bloominator"
eLevel=37
maxLife=130
life=maxLife
pointWorth=10
atkPower=12
affiliation=7
weaponGive=6

animate=0
moveDir=0
moveProg=0
runAcc=2
bulletTime=0
if global.shooterDifficulty=1 {bulletMod=6}
else {bulletMod=5}
bulletDir=0
bulletCheck=0
movePass=0

jeremyText="Just shoot it down."
chaoText="Eaten Ability: LASER BEAM#Power: 5 (DPS: 75)#Fire Rate: 15/sec#This laser fires straight and pierces through enemies. It may be weak, but it has the highest fire rate of all weapons."
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
    if moveProg=0 //Fly in
    {
      x-=runAcc
      if x<=432 {moveProg+=1}
    }
    else if moveProg=1 //Slight wait
    {
      bulletTime+=1
      if bulletTime>=15 {bulletTime=0; moveProg+=1}
    }
    else if moveProg=2 //Angle up
    {
      image_angle-=3
      if image_angle<=155 {moveProg+=1}
    }
    else if moveProg=3 //Fire (go down)
    {
      image_angle+=2
      bulletTime+=1
      if bulletTime mod bulletMod=0
      {
        var tNewAttack;
        tNewAttack=instance_create(x+lengthdir_x(19,45+image_angle),y+lengthdir_y(19,45+image_angle),oPassBullet)
        tNewAttack.sprite_index=sC_BloomShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
        tNewAttack.decayTime=-100; tNewAttack.direction=image_angle
        tNewAttack=instance_create(x+lengthdir_x(19,-45+image_angle),y+lengthdir_y(19,-45+image_angle),oPassBullet)
        tNewAttack.sprite_index=sC_BloomShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
        tNewAttack.decayTime=-100; tNewAttack.direction=image_angle
      }
      if image_angle>=205 {moveProg+=1}
    }
    else if moveProg=4 //Slight wait
    {
      bulletTime+=1
      if bulletTime>=15 {bulletTime=0; moveProg+=1}
    }
    else if moveProg=5 //Fire (go up)
    {
      image_angle-=2
      bulletTime+=1
      if bulletTime mod bulletMod=0
      {
        var tNewAttack;
        tNewAttack=instance_create(x+lengthdir_x(19,45+image_angle),y+lengthdir_y(19,45+image_angle),oPassBullet)
        tNewAttack.sprite_index=sC_BloomShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
        tNewAttack.decayTime=-100; tNewAttack.direction=image_angle
        tNewAttack=instance_create(x+lengthdir_x(19,-45+image_angle),y+lengthdir_y(19,-45+image_angle),oPassBullet)
        tNewAttack.sprite_index=sC_BloomShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8
        tNewAttack.decayTime=-100; tNewAttack.direction=image_angle
      }
      if image_angle<=155
      {
        movePass+=1
        if movePass>=2 {moveProg=7}
        else {moveProg=6}
      }
    }
    else if moveProg=6 //Longer wait (Go to 3)
    {
      bulletTime+=1
      if bulletTime>=40 {bulletTime=0; moveProg=3}
    }
    else if moveProg=7 //Angle down (stop at mid)
    {
      image_angle+=3
      if image_angle>=180 {image_angle=180; moveProg+=1}
    }
    else if moveProg=8 //Slight wait
    {
      bulletTime+=1
      if bulletTime>=15 {bulletTime=0; moveProg+=1}
    }
    else if moveProg=9
    {
      x-=runAcc
    }

    if x<=-32 {instance_destroy()}
  }
  enemyStepEvent()
}
