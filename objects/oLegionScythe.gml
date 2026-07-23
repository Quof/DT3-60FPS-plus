#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0

var tEffect,tEfSpawnDir;
tEfSpawnDir=0
for(i=0;i<36;i+=1)
{

  tEffect=instance_create(x,y,oEffectB)
  tEffect.x=x+lengthdir_x(48,tEfSpawnDir); tEffect.y=y+lengthdir_y(48,tEfSpawnDir); tEffect.type=3
  tEffect.sprite_index=sMMchargeEffect1
  tEffect.image_speed=0; tEffect.direction=tEfSpawnDir; tEffect.image_angle=tEfSpawnDir
  tEffect.speed=random(0.5)+1.5; tEffect.friction=random(0.01)+0.02; tEffect.fadeSpd=0.03
  tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  tEfSpawnDir+=360/36
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle+=20
  atkProg+=1
  if atkProg>=60 {speed=6}
}
else
  speed=0
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
