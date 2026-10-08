/*
Reads the gamepad once per frame (oKeyCodesHighFPS's Begin Step) into global.gpHeld[action], which scrController uses
when Gamepad Input is on. Every action is checked on its own, so any number of them can be held at once; the d-pad
hat is split into its horizontal and vertical parts, so up+right on it counts as both Up and Right.
Codes, layouts and the gp* variables are explained in scrGamepadInit.
*/
var i,tCount,tName;

//---------- Pick the pad, again whenever pads are plugged in or unplugged ----------
tCount=joystick_count()
if joystick_found() or (global.gpDevice=-1 and tCount>0) or global.gpDevice>=tCount
{
  global.gpDevice=-1
  //the first one that looks like a gamepad (wheels, flight sticks and some other devices show up as joysticks too)
  for(i=0;i<tCount;i+=1)
  {
    if joystick_buttons(i)>=10 and joystick_axes(i)>=4 {global.gpDevice=i; break}
  }
  if global.gpDevice=-1 and tCount>0 {global.gpDevice=0}

  global.gpName=""
  if global.gpDevice>=0
  {
    global.gpName=joystick_name(global.gpDevice)
    global.gpAxes=min(joystick_axes(global.gpDevice),16)
    global.gpHasHat=joystick_has_pov(global.gpDevice)
    global.gpAxL2=4; global.gpAxR2=5; global.gpAxRX=2; global.gpAxRY=3 //layout 2, and layout 1's RawInput order until checked below
    global.gpOrderSure=1
    if global.gpHasHat=0 and joystick_buttons(global.gpDevice)>=15 {global.gpLayout=2} //PlayStation/Switch
    else {global.gpLayout=1; global.gpOrderSure=0} //Xbox/XInput (and anything unknown): axis order checked below
    if global.gpAxes<6 //no trigger axes (pads with digital L2/R2 have them as buttons, which can be set in the list)
    {
      global.gpAxL2=-1; global.gpAxR2=-1
      if global.gpAxes<4 {global.gpAxRX=-1; global.gpAxRY=-1}
      global.gpOrderSure=1
    }
    global.gpL2Ready=0
    global.gpR2Ready=0
    global.gpOrderXInput=0
    global.gpOrderRawInput=0
    //button names: PlayStation pads get their own (scrGamepadName)
    tName=string_upper(global.gpName)
    global.gpPlayStation=(global.gpLayout=2 and (string_pos("PS3",tName)>0 or string_pos("PS4",tName)>0 or string_pos("PS5",tName)>0 or string_pos("DUALSHOCK",tName)>0 or string_pos("DUALSENSE",tName)>0 or string_pos("PLAYSTATION",tName)>0))
    global.gpPS5=(string_pos("PS5",tName)>0 or string_pos("DUALSENSE",tName)>0)
  }
  else {global.gpLayout=0; global.gpAxes=0; global.gpHasHat=0}
}

for(i=0;i<=16;i+=1) {global.gpHeld[i]=0}
global.gpQuickRestart=0 //quick restart change (added)
global.gpFrames+=1 //key carry change: counted with or without a pad (the screen transition key carry, scrKeyCarry, uses it too)
if global.gpDevice<0 {exit}
//Only while the game window has focus (gm82core's window_has_focus, updated in its Begin Step), so the pad doesn't play
//the game from the background. Skipped for the first frames, before gm82core has set it.
//global.gpFrames+=1
if global.gpFrames>2 {if !window_has_focus() {exit}}

//quick restart change (added): L1/R1 held through a Quick Restart count again once they're let go (scrGamepadCheck)
if global.qrLockL1=1 or global.qrLockR1=1
{
  var tRawL1,tRawR1;
  if global.gpLayout=2 {tRawL1=global.gpRaw2[5]; tRawR1=global.gpRaw2[6]}
  else {tRawL1=global.gpRaw1[5]; tRawR1=global.gpRaw1[6]}
  if global.qrLockL1=1 {if !joystick_check_button(global.gpDevice,tRawL1) {global.qrLockL1=0}}
  if global.qrLockR1=1 {if !joystick_check_button(global.gpDevice,tRawR1) {global.qrLockR1=0}}
}

//---------- Read the axes and the hat once ----------
for(i=0;i<global.gpAxes;i+=1) {global.gpAxis[i]=joystick_axis(global.gpDevice,i)}
if global.gpHasHat {global.gpHatX=joystick_pov_x(global.gpDevice); global.gpHatY=joystick_pov_y(global.gpDevice)}
else {global.gpHatX=0; global.gpHatY=0}

//Layout 1 axis order: an unpressed trigger rests at -1, a stick at 0. When one of axes 2/4 sits at -1 and the other at
//0 for 30 frames in a row (right after plugging in, everything is usually at rest), that one is L2. L2 isn't read until
//then (R2 is axis 5 either way).
if global.gpLayout=1 and global.gpOrderSure=0
{
  if global.gpAxis[2]<=-0.9 and abs(global.gpAxis[4])<0.1 {global.gpOrderXInput+=1} else {global.gpOrderXInput=0}
  if global.gpAxis[4]<=-0.9 and abs(global.gpAxis[2])<0.1 {global.gpOrderRawInput+=1} else {global.gpOrderRawInput=0}
  if global.gpOrderXInput>=30 //XInput driver: LX LY L2 RX RY R2
  {
    global.gpAxL2=2; global.gpAxRX=3; global.gpAxRY=4
    global.gpL2Ready=0
    global.gpOrderSure=1
  }
  else if global.gpOrderRawInput>=30 //RawInput (SDL's default for Xbox pads) / Windows.Gaming.Input: LX LY RX RY L2 R2
  {
    global.gpAxL2=4; global.gpAxRX=2; global.gpAxRY=3
    global.gpL2Ready=0
    global.gpOrderSure=1
  }
}
if global.gpAxL2>=0 {if global.gpAxis[global.gpAxL2]<=-0.9 {global.gpL2Ready=1}}
if global.gpAxR2>=0 {if global.gpAxis[global.gpAxR2]<=-0.9 {global.gpR2Ready=1}}

//---------- Actions ----------
//for(i=1;i<=14;i+=1)
//{
//  if i!=11 and i!=12 {global.gpHeld[i]=scrGamepadCheck(global.gpBind[i])}
//}
//global.gpHeld[11]=scrGamepadCheck(9)   //Skip cutscene: BACK
//global.gpHeld[12]=scrGamepadCheck(10)  //Pause: START
//global.gpHeld[15]=scrGamepadCheck(1)   //Menu confirm: A (Cross)
//global.gpHeld[16]=scrGamepadCheck(2)   //Menu back: B (Circle)
//controls change: Cutscene Skip, Pause and the menu's Confirm/Cancel are set in the GAMEPAD list too now
for(i=1;i<=16;i+=1) {global.gpHeld[i]=scrGamepadCheck(global.gpBind[i])}
//quick restart change (added): Quick Restart is always L1 + R1, whatever they're set to (scrQuickRestartInput)
global.gpQuickRestart=(scrGamepadCheck(5) and scrGamepadCheck(6))
//The left stick always moves as well, like the arrow keys next to the keyboard controls
if global.gpAxes>=2
{
  if global.gpAxis[0]<=-global.optStickDeadZone {global.gpHeld[1]=1}
  if global.gpAxis[0]>=global.optStickDeadZone {global.gpHeld[2]=1}
  if global.gpAxis[1]<=-global.optStickDeadZone {global.gpHeld[3]=1}
  if global.gpAxis[1]>=global.optStickDeadZone {global.gpHeld[4]=1}
}
