#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bActive=1

//Enemy base statistics
eName="CHAOS Small Bot"
eLevel=27
maxLife=40
life=maxLife
pointWorth=6
atkPower=6
affiliation=7

runAcc=2
moveProg=0
if x>240 {image_xscale=-1}

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

    if oGame.time mod 10=0
    {
      var tEffect;
      tEffect=instance_create(x-(11*image_xscale),y-3,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sSamusMissileEffect; tEffect.newBlend=-1
      tEffect.speed=random(0.5)+1; tEffect.image_speed=0.25
      tEffect.fadeSpd=0.1; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      if image_xscale=1 {tEffect.direction=random_range(245,260)}
      else {tEffect.direction=random_range(280,295)}
    }

    moveProg+=1
    if moveProg>=1 and moveProg<=999
    {
      if image_xscale=1
      {
        if x>=160 {moveProg=1000}
      }
      else
      {
        if x<=352 {moveProg=1000}
      }
    }
    else if moveProg=1001
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(10*image_xscale),y,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(10*image_xscale),y,oPlayer1.x,oPlayer1.y-26)
      tNewAttack.image_xscale=1.1; tNewAttack.image_yscale=1.1
    }
    else if moveProg>=1002 and moveProg<=1031
    {
      y+=1
    }
    else if moveProg>=1092 and moveProg<=1121
    {
      y-=1
    }
    else if moveProg>=1130
    {
      if image_xscale=1
      {
        if x>=room_width+16 {instance_destroy()}
      }
      else
      {
        if x<=-16 {instance_destroy()}
      }
    }
  }
  enemyStepEvent()
}
