/*
Input functions
argument0: What control code to look for.

returns 1 if the button is pressed down
*/

//gamepad change: the gamepad is read once per frame by scrGamepadPoll (Game Maker 8.2's joystick extension, with the
//buttons set in Options > Control > Change Gamepad Bindings) into global.gpHeld. The old version, which read GM8's joystick
//functions with fixed preset layouts, is kept below, commented out.
var tKeyCode,tKey;
tKeyCode=argument0
tKey=0

//socd change: the four directions go through scrSOCD (SOCD handling, last input wins: dipswitch socdLastInput), which
//reads them with scrDirHeld (these four lines, keyboard and gamepad)
//if tKeyCode=1 {tKey=scrKeyboardCheck(ord(global.ctrlLeft)) or scrKeyboardCheck(vk_left)} //Move left
//else if tKeyCode=2 {tKey=scrKeyboardCheck(ord(global.ctrlRight)) or scrKeyboardCheck(vk_right)} //Move right
//else if tKeyCode=3 {tKey=scrKeyboardCheck(ord(global.ctrlUp)) or scrKeyboardCheck(vk_up)} //Look up
//else if tKeyCode=4 {tKey=scrKeyboardCheck(ord(global.ctrlDown)) or scrKeyboardCheck(vk_down)} //Duck
if tKeyCode>=1 and tKeyCode<=4 {return scrSOCD(tKeyCode)} //Move left/right, look up, duck //socd change
else if tKeyCode=5 {tKey=scrKeyboardCheck(ord(global.ctrlJump))} //Jump
else if tKeyCode=6 {tKey=scrKeyboardCheck(ord(global.ctrlActA))} //Action A
else if tKeyCode=7 {tKey=scrKeyboardCheck(ord(global.ctrlActB))} //Action B
else if tKeyCode=8 {tKey=scrKeyboardCheck(ord(global.ctrlActC))} //Action C
else if tKeyCode=9 {tKey=scrKeyboardCheck(ord(global.ctrlCharSwap))} //Character Swap
else if tKeyCode=10 {tKey=scrKeyboardCheck(ord(global.ctrlAbilSwap))} //Ability Swap
//else if tKeyCode=11 {tKey=scrKeyboardCheck(ord("M"))} //Skip
//else if tKeyCode=12 {tKey=scrKeyboardCheck(ord("P"))} //Pause
else if tKeyCode=11 {tKey=scrKeyboardCheck(ord(global.ctrlSkip))} //Skip //controls change: set in CONTROLS now (M by default)
else if tKeyCode=12 {tKey=scrKeyboardCheck(ord(global.ctrlPause))} //Pause //controls change: set in CONTROLS now (P by default)
else if tKeyCode=13 {tKey=scrKeyboardCheck(ord(global.ctrlDashLeft))} //Dash left
else if tKeyCode=14 {tKey=scrKeyboardCheck(ord(global.ctrlDashRight))} //Dash right
//gamepad change (added): menu Confirm/Back. On the keyboard they're the Jump/Action A keys as before; on a gamepad they're
//always A (Cross) and B (Circle), whatever Jump and Action A are set to (scrGamepadPoll)
//else if tKeyCode=15 {tKey=scrKeyboardCheck(ord(global.ctrlJump))} //Menu confirm
//else if tKeyCode=16 {tKey=scrKeyboardCheck(ord(global.ctrlActA))} //Menu back
//controls change: menu Confirm/Cancel have their own keys now (J/K by default, as the Jump/Action A keys were), and
//their own buttons in the GAMEPAD list
else if tKeyCode=15 {tKey=scrKeyboardCheck(ord(global.ctrlConfirm))} //Menu confirm
else if tKeyCode=16 {tKey=scrKeyboardCheck(ord(global.ctrlCancel))} //Menu back

if tKey {return 1}
if global.optGamePad=1 {return global.gpHeld[tKeyCode]}
return 0

/*
var tKeyCode;
tKeyCode=argument0

if global.optGamePad=0 //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ OFF @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
{
  if tKeyCode=1 //Move left
  {
    if scrKeyboardCheck(ord(global.ctrlLeft)) or scrKeyboardCheck(vk_left) {return 1}
    else {return 0}
  }
  else if tKeyCode=2 //Move right
  {
    if scrKeyboardCheck(ord(global.ctrlRight)) or scrKeyboardCheck(vk_right) {return 1}
    else {return 0}
  }
  else if tKeyCode=3 //Look up
  {
    if scrKeyboardCheck(ord(global.ctrlUp)) or scrKeyboardCheck(vk_up) {return 1}
    else {return 0}
  }
  else if tKeyCode=4 //Duck
  {
    if scrKeyboardCheck(ord(global.ctrlDown)) or scrKeyboardCheck(vk_down) {return 1}
    else {return 0}
  }

  if tKeyCode=11 //Skip
  {
    if scrKeyboardCheck(ord("M")) {return 1}
    else {return 0}
  }
  else if tKeyCode=12 //Pause
  {
    if scrKeyboardCheck(ord("P")) {return 1}
    else {return 0}
  }

  if tKeyCode=5 //Jump
  {
    if scrKeyboardCheck(ord(global.ctrlJump)) {return 1}
    else {return 0}
  }
  else if tKeyCode=6 //Action A
  {
    if scrKeyboardCheck(ord(global.ctrlActA)) {return 1}
    else {return 0}
  }
  else if tKeyCode=7 //Action B
  {
    if scrKeyboardCheck(ord(global.ctrlActB)) {return 1}
    else {return 0}
  }
  else if tKeyCode=8 //Action C
  {
    if scrKeyboardCheck(ord(global.ctrlActC)) {return 1}
    else {return 0}
  }
  else if tKeyCode=9 //Character Swap
  {
    if scrKeyboardCheck(ord(global.ctrlCharSwap)) {return 1}
    else {return 0}
  }
  else if tKeyCode=10 //Ability Swap
  {
    if scrKeyboardCheck(ord(global.ctrlAbilSwap)) {return 1}
    else {return 0}
  }
  else if tKeyCode=13 //Dash left
  {
    if scrKeyboardCheck(ord(global.ctrlDashLeft)) {return 1}
    else {return 0}
  }
  else if tKeyCode=14 //Dash right
  {
    if scrKeyboardCheck(ord(global.ctrlDashRight)) {return 1}
    else {return 0}
  }
}
else //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ON @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
{
  if tKeyCode=1 //Move left
  {
    if scrKeyboardCheck(ord(global.ctrlLeft)) or scrKeyboardCheck(vk_left) {return 1}
    else if (joystick_xpos(1)<=-global.optStickDeadZone or joystick_pov(1)=270 or joystick_pov(1)=225 or joystick_pov(1)=315) and global.optGamePad=1 {return 1}
    else {return 0}
  }
  else if tKeyCode=2 //Move right
  {
    if scrKeyboardCheck(ord(global.ctrlRight)) or scrKeyboardCheck(vk_right) {return 1}
    else if (joystick_xpos(1)>=global.optStickDeadZone or joystick_pov(1)=90 or joystick_pov(1)=45 or joystick_pov(1)=135) and global.optGamePad=1 {return 1}
    else {return 0}
  }
  else if tKeyCode=3 //Look up
  {
    if scrKeyboardCheck(ord(global.ctrlUp)) or scrKeyboardCheck(vk_up) {return 1}
    else if (joystick_ypos(1)<=-global.optStickDeadZone or joystick_pov(1)=0 or joystick_pov(1)=45 or joystick_pov(1)=315) and global.optGamePad=1 {return 1}
    else {return 0}
  }
  else if tKeyCode=4 //Duck
  {
    if scrKeyboardCheck(ord(global.ctrlDown)) or scrKeyboardCheck(vk_down) {return 1}
    else if (joystick_ypos(1)>=global.optStickDeadZone or joystick_pov(1)=135 or joystick_pov(1)=180 or joystick_pov(1)=225) and global.optGamePad=1 {return 1}
    else {return 0}
  }

  if global.optGamepadSetup=5 or global.optGamepadSetup=6 //Switch Pro / Hitbox
  {
    if tKeyCode=11 //Skip
    {
      if scrKeyboardCheck(ord("M")) {return 1}
      else if joystick_check_button(1,9) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=12 //Pause
    {
      if scrKeyboardCheck(ord("P")) {return 1}
      else if joystick_check_button(1,10) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=7 //DS4
  {
    if tKeyCode=11 //Skip
    {
      if scrKeyboardCheck(ord("M")) {return 1}
      else if joystick_check_button(1,9) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=12 //Pause
    {
      if scrKeyboardCheck(ord("P")) {return 1}
      else if joystick_check_button(1,10) or joystick_check_button(1,14) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else //All else
  {
    if tKeyCode=11 //Skip
    {
      if scrKeyboardCheck(ord("M")) {return 1}
      else if joystick_check_button(1,7) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=12 //Pause
    {
      if scrKeyboardCheck(ord("P")) {return 1}
      else if joystick_check_button(1,8) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }

  if global.optGamepadSetup=1 //======================================== 1.0 JERRY ========================================
  {
    if tKeyCode=5 //Jump
    {
      if scrKeyboardCheck(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(1,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if scrKeyboardCheck(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(1,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if scrKeyboardCheck(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(1,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if scrKeyboardCheck(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(1,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if scrKeyboardCheck(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(1,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if scrKeyboardCheck(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(1,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if scrKeyboardCheck(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_zpos(1)>=0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if scrKeyboardCheck(ord(global.ctrlDashRight)) {return 1}
      else if joystick_zpos(1)<=-0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=2 //======================================== 1.1 JEREMY ========================================
  {
    if tKeyCode=5 //Jump
    {
      if scrKeyboardCheck(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(1,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if scrKeyboardCheck(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(1,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if scrKeyboardCheck(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(1,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if scrKeyboardCheck(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(1,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if scrKeyboardCheck(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(1,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if scrKeyboardCheck(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(1,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if scrKeyboardCheck(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_zpos(1)>=0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if scrKeyboardCheck(ord(global.ctrlDashRight)) {return 1}
      else if joystick_zpos(1)<=-0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=3 //======================================== 1.2 CLAIRE ========================================
  {
    if tKeyCode=6 //Action A
    {
      if scrKeyboardCheck(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(1,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=5 //Jump
    {
      if scrKeyboardCheck(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(1,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if scrKeyboardCheck(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(1,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if scrKeyboardCheck(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(1,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if scrKeyboardCheck(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(1,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if scrKeyboardCheck(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(1,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if scrKeyboardCheck(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_zpos(1)>=0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if scrKeyboardCheck(ord(global.ctrlDashRight)) {return 1}
      else if joystick_zpos(1)<=-0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=4 //======================================== 1.3 CHAO ========================================
  {
    if tKeyCode=6 //Action A
    {
      if scrKeyboardCheck(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(1,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=5 //Jump
    {
      if scrKeyboardCheck(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(1,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if scrKeyboardCheck(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(1,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if scrKeyboardCheck(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(1,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if scrKeyboardCheck(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(1,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if scrKeyboardCheck(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(1,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if scrKeyboardCheck(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_zpos(1)>=0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if scrKeyboardCheck(ord(global.ctrlDashRight)) {return 1}
      else if joystick_zpos(1)<=-0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=5 //======================================== 2.0 SWITCH PRO CONTROLLER ========================================
  {
    if tKeyCode=5 //Jump
    {
      if scrKeyboardCheck(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(1,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if scrKeyboardCheck(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(1,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if scrKeyboardCheck(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(1,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if scrKeyboardCheck(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(1,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if scrKeyboardCheck(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(1,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if scrKeyboardCheck(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(1,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if scrKeyboardCheck(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_check_button(1,7) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if scrKeyboardCheck(ord(global.ctrlDashRight)) {return 1}
      else if joystick_check_button(1,8) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=6 //======================================== 2.1 HITBOX ========================================
  {
    if tKeyCode=5 //Jump
    {
      if scrKeyboardCheck(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(1,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if scrKeyboardCheck(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(1,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if scrKeyboardCheck(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(1,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if scrKeyboardCheck(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(1,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if scrKeyboardCheck(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(1,7) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if scrKeyboardCheck(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(1,8) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if scrKeyboardCheck(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_check_button(1,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if scrKeyboardCheck(ord(global.ctrlDashRight)) {return 1}
      else if joystick_check_button(1,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=7 //======================================== 2.2 DUALSHOCK 4 CONTROLLER ========================================
  {
    if tKeyCode=5 //Jump
    {
      if scrKeyboardCheck(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(1,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if scrKeyboardCheck(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(1,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if scrKeyboardCheck(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(1,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if scrKeyboardCheck(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(1,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if scrKeyboardCheck(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(1,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if scrKeyboardCheck(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(1,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if scrKeyboardCheck(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_check_button(1,7) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if scrKeyboardCheck(ord(global.ctrlDashRight)) {return 1}
      else if joystick_check_button(1,8) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
}
*/
