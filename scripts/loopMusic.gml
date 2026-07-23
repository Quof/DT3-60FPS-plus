/*
This script is called to check when music loops
use: loopMusic()
*/

var tSoundPos;
if SS_IsSoundLooping(global.msc_AbominationA)
{
  tSoundPos=SS_GetSoundPosition(global.msc_AbominationA)
  if tSoundPos>=300000
  {
    SS_SetSoundPosition(global.msc_AbominationA,50)
  }
}
