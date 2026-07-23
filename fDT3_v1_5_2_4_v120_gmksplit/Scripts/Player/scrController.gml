/* !scriptId=139 */
/*
Input functions
argument0: What control code to look for.

returns 1 if the button is pressed down
*/

var tKeyCode;
tKeyCode=argument0

if global.optGamePad=0 //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ OFF @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
{
  if tKeyCode=1 //Move left
  {
    if keyboard_check(ord(global.ctrlLeft)) or keyboard_check(vk_left) {return 1}
    else {return 0}
  }
  else if tKeyCode=2 //Move right
  {
    if keyboard_check(ord(global.ctrlRight)) or keyboard_check(vk_right) {return 1}
    else {return 0}
  }
  else if tKeyCode=3 //Look up
  {
    if keyboard_check(ord(global.ctrlUp)) or keyboard_check(vk_up) {return 1}
    else {return 0}
  }
  else if tKeyCode=4 //Duck
  {
    if keyboard_check(ord(global.ctrlDown)) or keyboard_check(vk_down) {return 1}
    else {return 0}
  }
  
  if tKeyCode=11 //Skip
  {
    if keyboard_check(ord("M")) {return 1}
    else {return 0}
  }
  else if tKeyCode=12 //Pause
  {
    if keyboard_check(ord("P")) {return 1}
    else {return 0}
  }
  
  if tKeyCode=5 //Jump
  {
    if keyboard_check(ord(global.ctrlJump)) {return 1}
    else {return 0}
  }
  else if tKeyCode=6 //Action A
  {
    if keyboard_check(ord(global.ctrlActA)) {return 1}
    else {return 0}
  }
  else if tKeyCode=7 //Action B
  {
    if keyboard_check(ord(global.ctrlActB)) {return 1}
    else {return 0}
  }
  else if tKeyCode=8 //Action C
  {
    if keyboard_check(ord(global.ctrlActC)) {return 1}
    else {return 0}
  }
  else if tKeyCode=9 //Character Swap
  {
    if keyboard_check(ord(global.ctrlCharSwap)) {return 1}
    else {return 0}
  }
  else if tKeyCode=10 //Ability Swap
  {
    if keyboard_check(ord(global.ctrlAbilSwap)) {return 1}
    else {return 0}
  }
  else if tKeyCode=13 //Dash left
  {
    if keyboard_check(ord(global.ctrlDashLeft)) {return 1}
    else {return 0}
  }
  else if tKeyCode=14 //Dash right
  {
    if keyboard_check(ord(global.ctrlDashRight)) {return 1}
    else {return 0}
  }
}
else //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ON @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
{
  if tKeyCode=1 //Move left
  {
    if keyboard_check(ord(global.ctrlLeft)) or keyboard_check(vk_left) {return 1}
    else if (joystick_xpos(0)<=-global.optStickDeadZone or joystick_pov(0)=270 or joystick_pov(0)=225 or joystick_pov(0)=315) and global.optGamePad=1 {return 1}
    else {return 0}
  }
  else if tKeyCode=2 //Move right
  {
    if keyboard_check(ord(global.ctrlRight)) or keyboard_check(vk_right) {return 1}
    else if (joystick_xpos(0)>=global.optStickDeadZone or joystick_pov(0)=90 or joystick_pov(0)=45 or joystick_pov(0)=135) and global.optGamePad=1 {return 1}
    else {return 0}
  }
  else if tKeyCode=3 //Look up
  {
    if keyboard_check(ord(global.ctrlUp)) or keyboard_check(vk_up) {return 1}
    else if (joystick_ypos(0)<=-global.optStickDeadZone or joystick_pov(0)=0 or joystick_pov(0)=45 or joystick_pov(0)=315) and global.optGamePad=1 {return 1}
    else {return 0}
  }
  else if tKeyCode=4 //Duck
  {
    if keyboard_check(ord(global.ctrlDown)) or keyboard_check(vk_down) {return 1}
    else if (joystick_ypos(0)>=global.optStickDeadZone or joystick_pov(0)=135 or joystick_pov(0)=180 or joystick_pov(0)=225) and global.optGamePad=1 {return 1}
    else {return 0}
  }
  
  if global.optGamepadSetup=5 or global.optGamepadSetup=6 //Switch Pro / Hitbox
  {
    if tKeyCode=11 //Skip
    {
      if keyboard_check(ord("M")) {return 1}
      else if joystick_check_button(0,9) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=12 //Pause
    {
      if keyboard_check(ord("P")) {return 1}
      else if joystick_check_button(0,10) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=7 //DS4
  {
    if tKeyCode=11 //Skip
    {
      if keyboard_check(ord("M")) {return 1}
      else if joystick_check_button(0,9) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=12 //Pause
    {
      if keyboard_check(ord("P")) {return 1}
      else if joystick_check_button(0,10) or joystick_check_button(0,14) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else //All else
  {
    if tKeyCode=11 //Skip
    {
      if keyboard_check(ord("M")) {return 1}
      else if joystick_check_button(0,7) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=12 //Pause
    {
      if keyboard_check(ord("P")) {return 1}
      else if joystick_check_button(0,8) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  
  if global.optGamepadSetup=1 //======================================== 1.0 JERRY ========================================
  {
    if tKeyCode=5 //Jump
    {
      if keyboard_check(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(0,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if keyboard_check(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(0,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if keyboard_check(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(0,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if keyboard_check(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(0,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if keyboard_check(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(0,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if keyboard_check(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(0,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if keyboard_check(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_zpos(0)>=0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if keyboard_check(ord(global.ctrlDashRight)) {return 1}
      else if joystick_zpos(0)<=-0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=2 //======================================== 1.1 JEREMY ========================================
  {
    if tKeyCode=5 //Jump
    {
      if keyboard_check(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(0,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if keyboard_check(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(0,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if keyboard_check(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(0,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if keyboard_check(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(0,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if keyboard_check(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(0,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if keyboard_check(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(0,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if keyboard_check(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_zpos(0)>=0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if keyboard_check(ord(global.ctrlDashRight)) {return 1}
      else if joystick_zpos(0)<=-0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=3 //======================================== 1.2 CLAIRE ========================================
  {
    if tKeyCode=6 //Action A
    {
      if keyboard_check(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(0,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=5 //Jump
    {
      if keyboard_check(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(0,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if keyboard_check(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(0,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if keyboard_check(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(0,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if keyboard_check(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(0,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if keyboard_check(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(0,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if keyboard_check(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_zpos(0)>=0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if keyboard_check(ord(global.ctrlDashRight)) {return 1}
      else if joystick_zpos(0)<=-0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=4 //======================================== 1.3 CHAO ========================================
  {
    if tKeyCode=6 //Action A
    {
      if keyboard_check(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(0,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=5 //Jump
    {
      if keyboard_check(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(0,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if keyboard_check(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(0,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if keyboard_check(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(0,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if keyboard_check(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(0,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if keyboard_check(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(0,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if keyboard_check(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_zpos(0)>=0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if keyboard_check(ord(global.ctrlDashRight)) {return 1}
      else if joystick_zpos(0)<=-0.2 and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=5 //======================================== 2.0 SWITCH PRO CONTROLLER ========================================
  {
    if tKeyCode=5 //Jump
    {
      if keyboard_check(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(0,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if keyboard_check(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(0,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if keyboard_check(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(0,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if keyboard_check(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(0,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if keyboard_check(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(0,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if keyboard_check(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(0,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if keyboard_check(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_check_button(0,7) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if keyboard_check(ord(global.ctrlDashRight)) {return 1}
      else if joystick_check_button(0,8) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=6 //======================================== 2.1 HITBOX ========================================
  {
    if tKeyCode=5 //Jump
    {
      if keyboard_check(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(0,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if keyboard_check(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(0,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if keyboard_check(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(0,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if keyboard_check(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(0,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if keyboard_check(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(0,7) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if keyboard_check(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(0,8) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if keyboard_check(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_check_button(0,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if keyboard_check(ord(global.ctrlDashRight)) {return 1}
      else if joystick_check_button(0,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
  else if global.optGamepadSetup=7 //======================================== 2.2 DUALSHOCK 4 CONTROLLER ========================================
  {
    if tKeyCode=5 //Jump
    {
      if keyboard_check(ord(global.ctrlJump)) {return 1}
      else if joystick_check_button(0,2) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=6 //Action A
    {
      if keyboard_check(ord(global.ctrlActA)) {return 1}
      else if joystick_check_button(0,1) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=7 //Action B
    {
      if keyboard_check(ord(global.ctrlActB)) {return 1}
      else if joystick_check_button(0,4) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=8 //Action C
    {
      if keyboard_check(ord(global.ctrlActC)) {return 1}
      else if joystick_check_button(0,3) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=9 //Character Swap
    {
      if keyboard_check(ord(global.ctrlCharSwap)) {return 1}
      else if joystick_check_button(0,5) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=10 //Ability Swap
    {
      if keyboard_check(ord(global.ctrlAbilSwap)) {return 1}
      else if joystick_check_button(0,6) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=13 //Dash left
    {
      if keyboard_check(ord(global.ctrlDashLeft)) {return 1}
      else if joystick_check_button(0,7) and global.optGamePad=1 {return 1}
      else {return 0}
    }
    else if tKeyCode=14 //Dash right
    {
      if keyboard_check(ord(global.ctrlDashRight)) {return 1}
      else if joystick_check_button(0,8) and global.optGamePad=1 {return 1}
      else {return 0}
    }
  }
}
