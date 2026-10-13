if activated=0 and other.bCanHitSwitch=1 and other.weaponTag<100
{
  playSound(global.snd_SwitchHit,0,1,1)
  with oSequenceCrystal
  {
    current = 0
    x=positionsX[current]
    y=positionsY[current]
  }
  activated=1
  //alarm[0] = 15
  alarm[0] = 15/gDeltaTime //60fps change: alarms count frames
}
