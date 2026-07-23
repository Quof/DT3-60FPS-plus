#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: stopTime
event_inherited()
image_speed=0
image_xscale=-1
bActive=1

//Enemy base statistics
eName="CHAOS Heavy Gunner"
eLevel=27
maxLife=170
life=maxLife
pointWorth=11
atkPower=6
affiliation=7

runAcc=6
moveProg=0
rocketEfScl=1

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
    if oGame.time mod 8=0
    {
      if rocketEfScl=0.5 {rocketEfScl=0.75}
      else {rocketEfScl=0.5}
    }

    moveProg+=1
    if moveProg>=1 and moveProg<=99
    {
      x-=runAcc
      if moveProg>=stopTime {moveProg=100}
    }
    else if moveProg=130
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(28*image_xscale),y,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=3
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(28*image_xscale),y,oPlayer1.x,oPlayer1.y-26)
      tNewAttack.image_xscale=1.5; tNewAttack.image_yscale=1.5
    }
    else if moveProg=190
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(28*image_xscale),y,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=3
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(28*image_xscale),y,oPlayer1.x,oPlayer1.y-26)
      tNewAttack.image_xscale=1.5; tNewAttack.image_yscale=1.5
    }
    else if moveProg>=250
    {
      x-=runAcc
      if x<=-16 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sMMExplosion,0,x-(13*image_xscale),y,rocketEfScl,rocketEfScl,image_angle,c_white,image_alpha)
event_inherited()
