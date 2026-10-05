#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type
event_inherited()
image_blend=c_gray

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false

extraHitFrameBuffer=0

atkPower=oHexor_Final.atkPower

bulletSpeed=7
atkProg=0
atkTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //if extraHitFrameBuffer>0 {extraHitFrameBuffer-=1*gDeltaTime}
  if extraHitFrameBuffer>0 and gDeltaDoTicks {extraHitFrameBuffer-=1} //60fps change: with -=1*gDeltaTime the buffer went 2, 3.5, 5... and never hit exactly 3, so these spikes couldn't damage the player at 60/120fps; now counted in 30fps ticks (see the player collision)

  if atkProg=0
  {
    if gDeltaDoTicks y-=2
    if y<=64
    {
      image_blend=c_white
      bCanDealDamage=true
      _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)
      atkTime=0; atkProg=1
    }
  }
  else if atkProg=1
  {
    _speed=bulletSpeed
  }
}
else {_speed=0}
correctSpeedDirection(self)
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//extraHitFrameBuffer+=2
//if extraHitFrameBuffer=3
//{
//  event_inherited()
//}
if gDeltaDoTicks //60fps change (added): counted on 30fps ticks, so a hit still needs 2 ticks of touching
{
  extraHitFrameBuffer+=2
  if extraHitFrameBuffer=3
  {
    event_inherited()
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Bobomb,0,0.92,38000)
tEfCir=instance_create(x,y,oEfCircleBlast)
tEfCir.image_alpha=0.75; tEfCir.myRad=8; tEfCir.radScl=2; tEfCir.fadeSpeed=0.08
instance_destroy()
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
