#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type,atkDelay
event_inherited()
image_blend=c_gray

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false

tEfCir=instance_create(x,y,oEfCircleBlast)
tEfCir.image_alpha=0.5; tEfCir.myRad=6; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1

bulletSpeed=7
atkProg=0
atkTime=0

lineAlpha=0.4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0
  {
    //image_angle+=8
    image_angle+=8*gDeltaTime //60fps change: spun 2x/4x as fast at 60/120fps
    atkTime+=1*gDeltaTime
    if atkTime>=atkDelay
    {
      if type=0
      {
        image_angle=point_direction(x,y,oPlayer1.x,oPlayer1.y-32)
      }
      else if type=1
      {
        image_angle=myDir
      }
      _direction=image_angle
      image_blend=c_white
      bCanDealDamage=true
      atkTime=0; atkProg=1
    }
  }
  else if atkProg=1
  {
    atkTime+=1*gDeltaTime
    if atkTime>=15 {atkTime=0; atkProg=2}
  }
  else if atkProg=2
  {
    //if bulletSpeed<2 {bulletSpeed+=0.1}
    //else if bulletSpeed>=2 and bulletSpeed<=15 {bulletSpeed+=1}
    //_speed=bulletSpeed
    var tA; tA=0 //60fps change (added): the speed-up was per frame (top speed reached 2x/4x sooner at 60/120fps); now per 30fps tick (scrTickAcc), speed changes then moves
    if bulletSpeed<2 {tA=0.1} else if bulletSpeed>=2 and bulletSpeed<=15 {tA=1} //60fps change (added): same conditions as above
    bulletSpeed=scrTickAcc(bulletSpeed,tA,0) //60fps change (added)
    _speed=bulletSpeed+scrTickAccB(0) //60fps change: scrTickAccB corrects the move for the speed-up spread over the tick
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
redDmgHit(0)
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if atkProg>=1
{
  //if lineAlpha=0.3 {lineAlpha=0.6}
  //else {lineAlpha=0.3}
  if gDeltaDoTicks {if lineAlpha=0.3 {lineAlpha=0.6} else {lineAlpha=0.3}} //60fps change: the aim line flickered every frame (2x/4x as fast at 60/120fps)
  draw_set_alpha(lineAlpha)
  draw_set_color(c_red)
  draw_line(x,y,x+lengthdir_x(540,image_angle),y+lengthdir_y(540,image_angle))
}
draw_self()
