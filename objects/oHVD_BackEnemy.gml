#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
eventProg=0
eventTime=0
image_blend=c_gray
image_xscale=0.4
image_yscale=0.4

currHspd=choose(-3,3); currVspd=choose(-3,3)
maxSpeed=4
speedBoost=0

if global.gameProgress>=4950 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //Movement
  speedBoost=0
  if random(100)<1 {speedBoost=1}

  if x>xstart
  {
    //if currHspd>-maxSpeed {currHspd-=0.2-random(0.2); if speedBoost=1 {currHspd-=4*gDeltaTime}}
    if currHspd>-maxSpeed {currHspd-=(0.2-random(0.2))*gDeltaTime; if speedBoost=1 {currHspd-=4*gDeltaTime}} //60fps change: the base drift was per frame, so these background enemies swerved 2x/4x as hard at 60/120fps
    //else {currHspd+=0.25; if speedBoost=1 {currHspd+=4*gDeltaTime}}
    else {currHspd+=(0.25)*gDeltaTime; if speedBoost=1 {currHspd+=4*gDeltaTime}} //60fps change: the base drift was per frame, so these background enemies swerved 2x/4x as hard at 60/120fps
  }
  else if x<xstart
  {
    //if currHspd<maxSpeed {currHspd+=0.2+random(0.2); if speedBoost=1 {currHspd+=4*gDeltaTime}}
    if currHspd<maxSpeed {currHspd+=(0.2+random(0.2))*gDeltaTime; if speedBoost=1 {currHspd+=4*gDeltaTime}} //60fps change: the base drift was per frame, so these background enemies swerved 2x/4x as hard at 60/120fps
    //else {currHspd-=0.25; if speedBoost=1 {currHspd-=4*gDeltaTime}}
    else {currHspd-=(0.25)*gDeltaTime; if speedBoost=1 {currHspd-=4*gDeltaTime}} //60fps change: the base drift was per frame, so these background enemies swerved 2x/4x as hard at 60/120fps
  }
  if y>ystart
  {
    //if currVspd>-maxSpeed {currVspd-=0.2-random(0.2); if speedBoost=1 {currVspd-=2.5*gDeltaTime}}
    if currVspd>-maxSpeed {currVspd-=(0.2-random(0.2))*gDeltaTime; if speedBoost=1 {currVspd-=2.5*gDeltaTime}} //60fps change: the base drift was per frame, so these background enemies swerved 2x/4x as hard at 60/120fps
    //else {currVspd+=0.25; if speedBoost=1 {currVspd+=2.5*gDeltaTime}}
    else {currVspd+=(0.25)*gDeltaTime; if speedBoost=1 {currVspd+=2.5*gDeltaTime}} //60fps change: the base drift was per frame, so these background enemies swerved 2x/4x as hard at 60/120fps
  }
  else if y<ystart
  {
    //if currVspd<maxSpeed {currVspd+=0.2+random(0.2); if speedBoost=1 {currVspd+=2.5*gDeltaTime}}
    if currVspd<maxSpeed {currVspd+=(0.2+random(0.2))*gDeltaTime; if speedBoost=1 {currVspd+=2.5*gDeltaTime}} //60fps change: the base drift was per frame, so these background enemies swerved 2x/4x as hard at 60/120fps
    //else {currVspd-=0.25; if speedBoost=1 {currVspd-=2.5*gDeltaTime}}
    else {currVspd-=(0.25)*gDeltaTime; if speedBoost=1 {currVspd-=2.5*gDeltaTime}} //60fps change: the base drift was per frame, so these background enemies swerved 2x/4x as hard at 60/120fps
  }
  _hspeed=currHspd; _vspeed=currVspd

  if _hspeed>0 {image_xscale=0.4}
  else {image_xscale=-0.4}
}
else {_hspeed=0; _vspeed=0}
correctHSpeedVSpeed(self)
