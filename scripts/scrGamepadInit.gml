/*
Gamepad support, using Game Maker 8.2's joystick extension (gm82joy: SDL2 joysticks, ids and buttons count from 0).
Called once from oKeyCodesHighFPS's Create. scrGamepadPoll reads the pad every frame, scrController uses the result.

The gamepad controls (global.gpBind[action], action = the kCode number used by scrController/oKeyCodes) are saved
as these codes, so they mean the same button on any pad SDL knows the layout of:
  0 nothing
  1 A (bottom face button: Cross)     2 B (right: Circle)     3 X (left: Square)     4 Y (top: Triangle)
  5 L1   6 R1   7 L2   8 R2   9 BACK (Select/Share/View)   10 START (Options/Menu)   11 L3   12 R3 (stick clicks)
  13-16 d-pad up/down/left/right    17-20 left stick up/down/left/right    21-24 right stick up/down/left/right
  100+n raw button n                200+2*a axis a pushed + (201+2*a: pushed -), for pads SDL has no layout for

SDL's raw joystick layout depends on the pad:
  layout 1 - Xbox pads and anything XInput (also DS4Windows, Steam's virtual pads): A B X Y L1 R1 BACK START L3 R3
             are buttons 0-9, the d-pad is the hat, L2/R2 are axes. Unknown pads are read this way too.
  layout 2 - PlayStation and Switch pads (SDL's HIDAPI drivers, no hat): A B X Y BACK GUIDE START L3 R3 L1 R1
             are buttons 0-10, the d-pad is buttons 11-14, sticks are axes 0-3, L2/R2 are axes 4/5.
*/
var i;

global.gpDevice=-1    //joystick being read (-1: none)
global.gpName=""      //its name, as SDL reports it
global.gpLayout=0     //1 or 2, see above
global.gpAxes=0       //number of axes on the pad
global.gpHasHat=0
global.gpPlayStation=0 //1: show PlayStation button names (scrGamepadName)
global.gpPS5=0
//Axis numbers of L2, R2 and the right stick. Layout 1 has two orders, depending on the driver SDL picked:
//XInput (L2 = axis 2, right stick = 3/4) or RawInput/Windows.Gaming.Input (right stick = 2/3, L2 = 4).
//scrGamepadPoll works out which one by looking at which axis rests at -1 (an unpressed trigger).
global.gpAxL2=4
global.gpAxR2=5
global.gpAxRX=2
global.gpAxRY=3
global.gpOrderXInput=0   //frames in a row each order has looked right
global.gpOrderRawInput=0
global.gpOrderSure=0     //1 once the order is known; until then L2 isn't read (axis 4 could be the right stick)
//SDL reports every axis as 0 for a frame when a pad is plugged in, which would look like a half-pressed trigger.
//A trigger only counts once it has been seen resting.
global.gpL2Ready=0
global.gpR2Ready=0

for(i=0;i<=16;i+=1) {global.gpHeld[i]=0}  //per action (15/16: menu Confirm/Back), read by scrController
global.gpFrames=0     //frames since startup: window_has_focus() is only read once gm82core has updated it (scrGamepadPoll)
//key carry change (added): left/right keys held through a screen transition (scrKeyCarry), by key code
for(i=0;i<256;i+=1) {global.kbCarry[i]=0; global.kbWasHeld[i]=0}
//socd change (added): scrSOCD's state. socdHeld: each direction (1-4) at the last check; socdLast: per pair (0 left/right,
//1 up/down) the direction pressed last; socdTie: the one that wins when both are pressed at once
for(i=1;i<=4;i+=1) {global.socdHeld[i]=0}
global.socdTie[0]=2  //right
global.socdTie[1]=3  //up
global.socdLast[0]=global.socdTie[0]
global.socdLast[1]=global.socdTie[1]
for(i=0;i<16;i+=1)
{
  global.gpAxis[i]=0     //this frame's axis values
  global.gpCapBase[i]=0  //axis values when the GAMEPAD list started waiting for a button (scrGamepadCapture)
}
global.gpHatX=0
global.gpHatY=0
//the options aren't loaded yet when this runs (rIntro), and the poll needs this
if !variable_global_exists("optStickDeadZone") {global.optStickDeadZone=0.4}

//Raw button for codes 1-12 (-1: it's an axis), per layout
global.gpRaw1[1]=0; global.gpRaw1[2]=1; global.gpRaw1[3]=2; global.gpRaw1[4]=3; global.gpRaw1[5]=4; global.gpRaw1[6]=5
global.gpRaw1[7]=-1; global.gpRaw1[8]=-1; global.gpRaw1[9]=6; global.gpRaw1[10]=7; global.gpRaw1[11]=8; global.gpRaw1[12]=9
global.gpRaw2[1]=0; global.gpRaw2[2]=1; global.gpRaw2[3]=2; global.gpRaw2[4]=3; global.gpRaw2[5]=9; global.gpRaw2[6]=10
global.gpRaw2[7]=-1; global.gpRaw2[8]=-1; global.gpRaw2[9]=4; global.gpRaw2[10]=6; global.gpRaw2[11]=7; global.gpRaw2[12]=8

//Rows of the GAMEPAD list (pause menu, Options > Control > Change Gamepad Bindings) -> action, same order as CONTROLS
global.gpRowAct[1]=3   //Up
global.gpRowAct[2]=4   //Down
global.gpRowAct[3]=1   //Left
global.gpRowAct[4]=2   //Right
global.gpRowAct[5]=5   //Jump
global.gpRowAct[6]=9   //Swap Character
global.gpRowAct[7]=10  //Swap Ability Set
global.gpRowAct[8]=6   //Action A
global.gpRowAct[9]=7   //Action B
global.gpRowAct[10]=8  //Action C
global.gpRowAct[11]=13 //Dash Left
global.gpRowAct[12]=14 //Dash Right
global.gpRowName[1]="Up"; global.gpRowName[2]="Down"; global.gpRowName[3]="Left"; global.gpRowName[4]="Right"
global.gpRowName[5]="Jump"; global.gpRowName[6]="Swap Character"; global.gpRowName[7]="Swap Ability Set"
global.gpRowName[8]="Action A"; global.gpRowName[9]="Action B"; global.gpRowName[10]="Action C"
//global.gpRowName[11]="Dash Left"; global.gpRowName[12]="Dash Right"
global.gpRowName[11]="Dash Back"; global.gpRowName[12]="Dash Forward" //dash rename change: named as in the CONTROLS/GAMEPAD lists

scrGamepadDefaults()
