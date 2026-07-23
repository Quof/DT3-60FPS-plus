#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-7,7,7)
image_xscale=2; image_yscale=2
image_speed=0.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
bCanBeBlocked=1
blockCost=450
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
  if isCollisionSolid()
  {
    myAtk=instance_create(x,y,oDamageExplosion)
    myAtk.atkPower=atkPower; myAtk.sprite_index=sBombExplosion
    myAtk.image_xscale=1.75; myAtk.image_yscale=1.75; myAtk.decayTime=-100

    instance_destroy()
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
