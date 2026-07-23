#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: yThres
event_inherited()
image_speed=0
if x>240 {image_xscale=-1}
bActive=1

//Enemy base statistics
eName="CHAOS Beetle Bot"
eLevel=28
maxLife=1100
life=maxLife
pointWorth=45
atkPower=6
affiliation=7

runAcc=0.4
moveProg=0
moveWaveY=pi/2

jeremyText="Just shoot it down."
chaoText="N/A"
devText="N/A"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true
  {
    x+=runAcc*image_xscale

    moveWaveY+=0.1
    y+=sin(moveWaveY)

    moveProg+=1
    if moveProg=70
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(26*image_xscale),y-19,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(26*image_xscale),y-19,oPlayer1.x,oPlayer1.y-26)
      tNewAttack.image_xscale=1.25; tNewAttack.image_yscale=1.25
    }
    else if moveProg=90
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(17*image_xscale),y,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(17*image_xscale),y,oPlayer1.x,oPlayer1.y-26)
      tNewAttack.image_xscale=1.25; tNewAttack.image_yscale=1.25
    }
    else if moveProg=110
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(12*image_xscale),y+19,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(12*image_xscale),y+19,oPlayer1.x,oPlayer1.y-26)
      tNewAttack.image_xscale=1.25; tNewAttack.image_yscale=1.25
      moveProg=0
    }

    if image_xscale=1
    {
      if x>=room_width+64 {instance_destroy()}
    }
    else
    {
      if x<=-64 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
