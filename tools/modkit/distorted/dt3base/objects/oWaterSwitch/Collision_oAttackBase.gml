if activated=0 and other.bCanHitSwitch=1 and other.weaponTag<100
{
  playSound(global.snd_SwitchHit,0,1,1)
  if global.location=10 //Gate 2: Water Palace
    global.wpWaterLevel=wLvlTarget
  oWaterVolume.targetWLevel=wLvlTarget
  with oWaterSwitch
    activated=0
  activated=1
}
