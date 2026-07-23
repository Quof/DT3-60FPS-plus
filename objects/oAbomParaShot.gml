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
atkPower=12
lifeTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  image_angle=direction
  lifeTime+=1
  if lifeTime>=1 and lifeTime<=35
  {
    var tEffect,tScale;
    tScale=random(0.17)
    tEffect=instance_create(x+random_range(-8,8),y+random_range(-8,8),oEffect)
    tEffect.sprite_index=sAbom_Tentacle; tEffect.image_speed=0.33; tEffect.image_alpha=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=15; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_xscale=0.13+tScale; tEffect.image_yscale=0.13+tScale; tEffect.image_angle=random(360)
  }
  if lifeTime=50
  {
    direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
  }

  if lifeTime>=1 and lifeTime<=35 {speed=5.5}
  else if lifeTime>=50 {speed=10}
  else {speed=0}
}
else {speed=0}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lifeTime>=50 {instance_destroy()}
