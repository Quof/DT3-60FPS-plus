#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-4,-4,4,4)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
grav=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks != 1 { exit; }
if global.gamePaused=false
{
  yVel+=grav
  if xVel>0
    image_angle-=10
  else if xVel<0
    image_angle+=10

  if isCollisionTop(1)
    instance_destroy()
  if isCollisionBottom(1)
    yVel=-5.5
  if isCollisionLeft(1)
    instance_destroy()
  if isCollisionRight(1)
    instance_destroy()
  moveTo(xVel,yVel)

  if y>room_height+32
    instance_destroy()
}
#define Collision_oMarioLava
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if checkScreenArea(x,y,48)=1 {playSound(global.snd_Flame1,0,0.92,50000)}
var tEffect;
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sMMSmokeCloud; tEffect.image_blend=c_maroon
tEffect.image_speed=0.33; tEffect.xSpd=0; tEffect.ySpd=-3
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//magicInterpDrawStart()
event_inherited()
//magicInterpDrawEnd()
