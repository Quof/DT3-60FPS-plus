#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=1.33
image_yscale=1.33
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  direction=point_direction(x,y,posX,posY)
  if point_distance(x,y,posX,posY)<=bulletSpeed
  {
    for(i=0;i<13;i+=1)
    {
      tAtk=instance_create(posX,posY,oPassBullet)
      tAtk.sprite_index=sWarmasterC_IceShard; tAtk.atkPower=atkPower; tAtk.bulletSpeed=9
      tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=spreadDir; tAtk.image_angle=spreadDir
      spreadDir-=7.5
    }
    instance_destroy()
  }
}
else {speed=0} //spreadStart
