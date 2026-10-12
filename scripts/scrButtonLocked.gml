/*
input bleed change (added): 1 while the player's button argument0 (scrController code) is locked by scrButtonLockHeld,
which lasts until it's let go. The caller then treats the button as not held.
argument0: scrController code
*/
if kBtnLock[argument0]=1
{
  if scrButtonHeldDirect(argument0)=0 {kBtnLock[argument0]=0}
}
return kBtnLock[argument0]
