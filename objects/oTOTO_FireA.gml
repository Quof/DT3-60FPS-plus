#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-4,-4,4,4)
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
bCanBeBlocked=1
blockCost=300
bParryOpp=1
atkTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkTime+=1
  speed=mySpd
  image_angle=direction
  if atkType=0
  {
    if isCollisionSolid()
    {
      myAtk=instance_create(x,y,oTOTO_FireA)
      myAtk.atkType=1; myAtk.mySpd=10; myAtk.atkPower=atkPower-1
      myAtk.direction=random_range(0,10); myAtk.image_xscale=2; myAtk.image_yscale=2
      myAtk=instance_create(x,y,oTOTO_FireA)
      myAtk.atkType=1; myAtk.mySpd=10; myAtk.atkPower=atkPower-1
      myAtk.direction=random_range(170,180); myAtk.image_xscale=2; myAtk.image_yscale=2
      instance_destroy()
    }
  }
  else if atkType=1
  {
    image_alpha-=0.04
    if image_alpha<=0.25 {bCanDealDamage=false}
    if image_alpha<=0 {instance_destroy()}
  }
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkTime>=30 {instance_destroy()}
