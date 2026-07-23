#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rWarshipZ_E3
{
  image_xscale=1.05; image_yscale=1.05
}
//Spear Swirl
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkProg=0
atkTime=0

var tEffect,tDir;
tDir=0
for(i=0;i<16;i+=1)
{
  tEffect=instance_create(x+lengthdir_x(32,tDir),y+lengthdir_y(32,tDir),oEffect)
  tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.25+random(0.25); tEffect.direction=tDir; tEffect.speed=3
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  tDir+=360/16
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=30
  if atkProg=0
  {
    x=warTarget.x
    y=warTarget.y-27
  }
  else if atkProg=1
  {
    atkTime+=1
    if atkTime=1
    {
      direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    }
    else {speed=5}
  }
}
else {speed=0}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rWarshipZ_E3 //EX MODE
{
  if other.bCanPierce=0
  {
    with other
    {
      playSound(global.snd_MMBulletDeflect,0,1,1)
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
