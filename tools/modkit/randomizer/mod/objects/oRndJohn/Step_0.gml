//Randomizer: the prompt's controls while it's open, every frame (oKeyCodesHighFPS: each press on its one frame, at any
//frame rate): Up/Down move the cursor, Confirm takes the option on it, Back is Cancel. Turn Debug Mode On: debug mode on,
//and he says how to use it; Cancel: what he said goes. The game carries on either way (a button pressed while it was
//paused isn't read by the player till it's let go: scrButtonLockHeld, so Confirm doesn't also jump)
if rjOpen=0 {exit}
if oKeyCodesHighFPS.kCodePressed[3]=1 or oKeyCodesHighFPS.kCodePressed[4]=1
{
  playSound(global.snd_MenuCursor,0,1,1)
  rjCur=1-rjCur
}
else if oKeyCodesHighFPS.kCodePressed[15]=1 and rjCur=0
{
  playSound(global.snd_MenuConfirm,0,0.95,1)
  rjOpen=0
  depth=50
  global.gamePaused=false
  global.debugMenu=1
  boxSize=2
  stringToShow="Right click to turn on left-click mouse movement, R to turn on invincibility. Don't mess with Game Progress."
  npcTextBox()
}
else if oKeyCodesHighFPS.kCodePressed[15]=1 or oKeyCodesHighFPS.kCodePressed[16]=1
{
  playSound(global.snd_MenuCancel,0,1,1)
  rjOpen=0
  depth=50
  global.gamePaused=false
  with (oMessageNPCchat) {if idCheck=other.id {instance_destroy()}}
}
