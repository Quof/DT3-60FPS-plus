/*
mods change (added): once every mod's objects are set up (scrModLoadAll), which of the 30fps mods' objects have their
built-in motion (speed, gravity, path speed) held still between 30fps ticks (scrModLegacyFreeze): all but those made
from the visual effect objects whose motion oGame already scales to the frame rate (its step event), which keep that
(only their alarms count in 30fps steps). global.modLegacyMap has the ones held still.
*/
var i,tObj,tP,tEff,n;
for(i=0;i<global.modLegacyCount;i+=1)
{
  tObj=global.modLegacyObj[i]
  tEff=0
  tP=tObj
  n=0
  while tP>=0 and n<50
  {
    if tP=oEffect or tP=oEffectB or tP=oEffectC or tP=oEffectGrav or tP=oEffectSpark or tP=oEffect_B_Stop or tP=oKillEffect {tEff=1; break}
    tP=object_get_parent(tP)
    n+=1
  }
  global.modLegacyMotion[i]=1-tEff
  if tEff=0 {if !ds_map_exists(global.modLegacyMap,tObj) {ds_map_add(global.modLegacyMap,tObj,1)}}
  else {scrModLog("  "+object_get_name(tObj)+": an effect object: its motion is scaled by oGame, not held between 30fps ticks")}
}
