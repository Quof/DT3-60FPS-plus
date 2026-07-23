/*
This script fades out the music
argument0: which file to fade
argument1: how much to fade the music
use: fadeVolume(ind,fade)
*/

var tempMusic,tempFade;
tempMusic=argument0
tempFade=argument1

if global.optMusic>0
{
  var newVol;
  newVol=SS_GetSoundVol(tempMusic)
  newVol-=tempFade
  SS_SetSoundVol(tempMusic,newVol)
}
