/*
argument0: a gamepad code (see scrGamepadInit)
returns 1 while it's held on the current pad. Uses the axis/hat values scrGamepadPoll read this frame.
*/
var c,d;
c=argument0
d=global.gpDevice
if c<=0 or d<0 {return 0}

if c<=12 //---------- Named buttons ----------
{
  if c=7 //L2: more than about a third of the way in
  {
    if global.gpAxL2>=0 and global.gpL2Ready and global.gpOrderSure {return global.gpAxis[global.gpAxL2]>-0.4}
    return 0
  }
  if c=8 //R2
  {
    if global.gpAxR2>=0 and global.gpR2Ready {return global.gpAxis[global.gpAxR2]>-0.4}
    return 0
  }
  //quick restart change (added): L1/R1 held through a Quick Restart don't count until they're let go and pressed again
  //(the player made after the restart would see them as just pressed: the dashes by default). scrGamepadPoll lets go
  if (c=5 and global.qrLockL1=1) or (c=6 and global.qrLockR1=1) {return 0}
  if global.gpLayout=2 {return joystick_check_button(d,global.gpRaw2[c])}
  return joystick_check_button(d,global.gpRaw1[c])
}
if c<=16 //---------- D-pad ----------
{
  if global.gpLayout=2 {return joystick_check_button(d,c-2)} //buttons 11-14
  if c=13 {return global.gpHatY<0}
  if c=14 {return global.gpHatY>0}
  if c=15 {return global.gpHatX<0}
  return global.gpHatX>0
}
if c<=20 //---------- Left stick ----------
{
  if global.gpAxes<2 {return 0}
  if c=17 {return global.gpAxis[1]<=-global.optStickDeadZone}
  if c=18 {return global.gpAxis[1]>=global.optStickDeadZone}
  if c=19 {return global.gpAxis[0]<=-global.optStickDeadZone}
  return global.gpAxis[0]>=global.optStickDeadZone
}
if c<=24 //---------- Right stick ----------
{
  if global.gpAxRY<0 {return 0}
  if c=21 {return global.gpAxis[global.gpAxRY]<=-global.optStickDeadZone}
  if c=22 {return global.gpAxis[global.gpAxRY]>=global.optStickDeadZone}
  if c=23 {return global.gpAxis[global.gpAxRX]<=-global.optStickDeadZone}
  return global.gpAxis[global.gpAxRX]>=global.optStickDeadZone
}
//if c>=100 and c<200 {return joystick_check_button(d,c-100)} //---------- Raw button ----------
if c>=100 and c<200 //---------- Raw button ---------- //quick restart change: L1/R1 set as raw buttons are locked the same way
{
  if global.gpLayout=2 {if (global.qrLockL1=1 and c-100=global.gpRaw2[5]) or (global.qrLockR1=1 and c-100=global.gpRaw2[6]) {return 0}}
  else {if (global.qrLockL1=1 and c-100=global.gpRaw1[5]) or (global.qrLockR1=1 and c-100=global.gpRaw1[6]) {return 0}}
  return joystick_check_button(d,c-100)
}
if c>=200 and c<232 //---------- Raw axis ----------
{
  var a;
  a=(c-200) div 2
  if a>=global.gpAxes {return 0}
  if (c mod 2)=0 {return global.gpAxis[a]>0.5}
  return global.gpAxis[a]<-0.5
}
return 0
