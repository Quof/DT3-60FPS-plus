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
eName="CHAOS Fish Bot"
eLevel=27
maxLife=280
life=maxLife
pointWorth=19
atkPower=6
affiliation=7

runAcc=0.5
moveProg=0

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

    if x<room_width+16
    {
      if y<yThres {y+=0.5}
    }

    moveProg+=1
    if moveProg mod 80=0 and y<240
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(24*image_xscale),y,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(24*image_xscale),y,oPlayer1.x,oPlayer1.y-26)
      tNewAttack.image_xscale=1.1; tNewAttack.image_yscale=1.1
    }

    if image_xscale=1
    {
      if x>=room_width+48 {instance_destroy()}
    }
    else
    {
      if x<=-48 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
