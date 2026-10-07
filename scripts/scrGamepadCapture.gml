/*
For the GAMEPAD list (oPauseMenu, subMenu 14): returns the code (see scrGamepadInit) of something held on the pad right
now, or 0 if nothing is. The list waits for 0 before it starts listening, so whatever shows up after that is the new button.
Sticks have to be pushed halfway; axes that aren't a stick or a trigger have to move halfway from where they were when
the list started listening (global.gpCapBase).
*/
var d,i,n;
d=global.gpDevice
if d<0 {return 0}
if global.gpFrames>2 {if !window_has_focus() {return 0}} //the pad only counts while the game window has focus (scrGamepadPoll)

//---------- Buttons ----------
n=min(joystick_buttons(d),64)
for(i=0;i<n;i+=1)
{
  if joystick_check_button(d,i)
  {
    if global.gpLayout=2 //A B X Y BACK GUIDE START L3 R3 L1 R1 D-UP D-DOWN D-LEFT D-RIGHT
    {
      if i<=3 {return i+1}
      if i=4 {return 9}
      if i=6 {return 10}
      if i=7 {return 11}
      if i=8 {return 12}
      if i=9 {return 5}
      if i=10 {return 6}
      if i>=11 and i<=14 {return i+2}
      return 100+i
    }
    //A B X Y L1 R1 BACK START L3 R3
    if i<=5 {return i+1}
    if i=6 {return 9}
    if i=7 {return 10}
    if i=8 {return 11}
    if i=9 {return 12}
    return 100+i
  }
}

//---------- D-pad hat ----------
if global.gpHatY<0 {return 13}
if global.gpHatY>0 {return 14}
if global.gpHatX<0 {return 15}
if global.gpHatX>0 {return 16}

//---------- Axes ----------
for(i=0;i<global.gpAxes;i+=1)
{
  if i=global.gpAxL2 {if global.gpL2Ready and global.gpOrderSure and global.gpAxis[i]>-0.4 {return 7}}
  else if i=global.gpAxR2 {if global.gpR2Ready and global.gpAxis[i]>-0.4 {return 8}}
  else if i=0
  {
    if global.gpAxis[i]<=-0.5 {return 19}
    if global.gpAxis[i]>=0.5 {return 20}
  }
  else if i=1
  {
    if global.gpAxis[i]<=-0.5 {return 17}
    if global.gpAxis[i]>=0.5 {return 18}
  }
  else if i=global.gpAxRX
  {
    if global.gpAxis[i]<=-0.5 {return 23}
    if global.gpAxis[i]>=0.5 {return 24}
  }
  else if i=global.gpAxRY
  {
    if global.gpAxis[i]<=-0.5 {return 21}
    if global.gpAxis[i]>=0.5 {return 22}
  }
  else if abs(global.gpAxis[i]-global.gpCapBase[i])>=0.5
  {
    if global.gpAxis[i]>=0.5 {return 200+(i*2)}
    if global.gpAxis[i]<=-0.5 {return 201+(i*2)}
  }
}
return 0
