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
  if extraHitFrameBuffer>0 {extraHitFrameBuffer-=1}

  if atkProg=0
  {
    if type=0
    {
      x+=4
      if x>=room_width-12
      {
        atkProg=1
      }
    }
    else if type=1
    {
      x-=4
      if x<=12
      {
        atkProg=1
      }
    }
  }
  else if atkProg=1
  {
    atkTime+=1
    if atkTime>=30
    {
      image_blend=c_white
      bCanDealDamage=true
      if x>240 {direction=180}
      else {direction=0}
      atkTime=0; atkProg=2
    }
  }
  else if atkProg=2
  {
    speed=bulletSpeed
  }
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
extraHitFrameBuffer+=2
if extraHitFrameBuffer=3
{
  event_inherited()
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
