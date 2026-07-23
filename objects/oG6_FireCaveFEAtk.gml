#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveSpd
image_xscale=-1
image_speed=0.33
fireDelay=10
swapFire=0
atkPower=8
atkAmt=40
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=moveSpd
  fireDelay+=1
  if fireDelay>=22
  {
    var tNewAttack,tDir;
    swapFire+=1
    if swapFire mod 2=0 {tDir=0}
    else {tDir=11.25}
    for(i=0;i<atkAmt;i+=1)
    {
      tNewAttack=instance_create(x,y,oPassBullet)
      tNewAttack.sprite_index=sPT_FE_Fireball; tNewAttack.atkPower=atkPower; tNewAttack.decayTime=-100
      tNewAttack.bCanBeBlocked=1; tNewAttack.blockCost=300; tNewAttack.bParryOpp=1; tNewAttack.damageType="ELEMENTAL"
      tNewAttack.direction=tDir; tNewAttack.depth=9; tNewAttack.bulletSpeed=5; tNewAttack.image_speed=0.33
      tDir+=360/atkAmt
    }
    fireDelay=0
  }
}
else {speed=0}
