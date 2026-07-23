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
    if currHspd>-maxSpeed {currHspd-=0.2-random(0.2); if speedBoost=1 {currHspd-=4}}
    else {currHspd+=0.25; if speedBoost=1 {currHspd+=4}}
  }
  else if x<xstart
  {
    if currHspd<maxSpeed {currHspd+=0.2+random(0.2); if speedBoost=1 {currHspd+=4}}
    else {currHspd-=0.25; if speedBoost=1 {currHspd-=4}}
  }
  if y>ystart
  {
    if currVspd>-maxSpeed {currVspd-=0.2-random(0.2); if speedBoost=1 {currVspd-=2.5}}
    else {currVspd+=0.25; if speedBoost=1 {currVspd+=2.5}}
  }
  else if y<ystart
  {
    if currVspd<maxSpeed {currVspd+=0.2+random(0.2); if speedBoost=1 {currVspd+=2.5}}
    else {currVspd-=0.25; if speedBoost=1 {currVspd-=2.5}}
  }
  hspeed=currHspd; vspeed=currVspd

  if hspeed>0 {image_xscale=0.4}
  else {image_xscale=-0.4}
}
else {hspeed=0; vspeed=0}
