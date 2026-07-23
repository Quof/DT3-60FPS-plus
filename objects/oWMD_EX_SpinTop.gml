#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.bBossGallery=1 {warTarget=oCHAOS_Warmaster_EX}
else {warTarget=oFedex}

//Top
event_inherited()
image_speed=0.33
image_angle=270

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2
myDist=16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if myDist<64 {myDist+=16}
  myDir+=8
  x=warTarget.x+lengthdir_x(myDist,myDir)
  y=warTarget.y-26+lengthdir_y(myDist,myDir)
  image_angle=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())

  atkTime+=1
  if atkTime>=28
  {
    var tEffect,tAtk;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.7; tEffect.image_yscale=0.7
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

    tAtk=instance_create(x,y+7,oPassBullet)
    tAtk.sprite_index=sWarmasterD_EX_Ball; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6
    tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.image_speed=0.33; tAtk.direction=image_angle
    instance_destroy()
  }
}
