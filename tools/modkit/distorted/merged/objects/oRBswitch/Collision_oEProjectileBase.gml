if reHitTime=0 and global.gamePaused=false
{
  playSound(global.snd_RBSwitch,0,1,1)
  if global.rbSwitchBlueOn=false
    global.rbSwitchBlueOn=true
  else
    global.rbSwitchBlueOn=false
  with oRBswitch
    reHitTime=minDelay
  //screen_redraw(); sleep(100)
}
