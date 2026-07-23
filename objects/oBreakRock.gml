#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  yVel+=0.2
  if isCollisionBottom(1)
    yVel=0
  if yVel>12
    yVel=12
  if y>room_height+24
    instance_destroy()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="EXPLOSION" and other.weaponTag<100
{
  playSound(global.snd_BoxBreak,0,0.88,13000)
  awardAwesome(50)
  for(i=0;i<8;i+=1)
  {
    tEffect=instance_create(x+2+random(sprite_width-4),y+2+random(sprite_height-4),oEffect)
    tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
  instance_destroy()
}
