if reHitTime=0 and other.bCanHitSwitch=1 and global.gamePaused=false
{
  playSound(global.snd_RBSwitch,0,1,1)
  if global.rbSwitchBlueOn=false
    global.rbSwitchBlueOn=true
  else
    global.rbSwitchBlueOn=false
  with oRBswitch
    reHitTime=20
  //screen_redraw(); sleep(100)
}
