#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Seeker Orb
event_inherited()
image_speed=0.33
image_alpha=0.1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2
atkTime=0
currHspd=0
currVspd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  if atkTime>=1 and atkTime<=8
  {
    image_alpha+=0.1
    if atkTime=8 {bCanDealDamage=1}
  }
  else if atkTime>=9
  {
    myDist=player_sprite_center()
    myDist=round(myDist/32)
    if myDist>9 {myDist=9}
    else if myDist<3 {myDist=3}
    maxSpeed=myDist

    if x>oPlayer1.x
    {
      if currHspd>-maxSpeed {currHspd-=0.25}
      else {currHspd=-maxSpeed}
    }
    else if x<oPlayer1.x
    {
      if currHspd<maxSpeed {currHspd+=0.25}
      else {currHspd=maxSpeed}
    }
    if y>returnPlayerYCenter()
    {
      if currVspd>-maxSpeed {currVspd-=0.25}
      else {currVspd=-maxSpeed}
    }
    else if y<returnPlayerYCenter()
    {
      if currVspd<maxSpeed {currVspd+=0.25}
      else {currVspd=maxSpeed}
    }
    hspeed=currHspd; vspeed=currVspd

    if rWarshipZ_E3 //EX MODE
    {
      if atkTime>=190
      {
        bCanDealDamage=0
        image_alpha-=0.1
      }
      if atkTime>=200 {instance_destroy()}
    }
    else
    {
      if atkTime>=175
      {
        bCanDealDamage=0
        image_alpha-=0.1
      }
      if atkTime>=185 {instance_destroy()}
    }
  }
}
else {hspeed=0; vspeed=0}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="EXPLOSION"
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_destroy()
}
