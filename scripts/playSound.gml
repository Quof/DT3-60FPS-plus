/*
This script is called when playing sound
use: playSound(file,loop,volume,freq)

argument0: which sound to play
argument1: 0=play, 1=loop
argument2: sound volume
argument3: sound frequency
*/
if global.optSound>0 and global.bSoundCanPlay=1
{
  var tSound,tLoop,tVolume,tFreq;
  tSound=argument0
  tLoop=argument1
  tVolume=argument2
  tFreq=argument3

  //tVolume=tVolume-(1-(global.optSound/100))
  //sound volume change: in dB like the music (scrMusicVolume): the Sound slider and the volume given here are amplitudes
  //(0.9 = 90%), plus the sound's own loudness adjustment (scrSoundGainInit). Before, both came off SS_SetSoundVol's range
  //in hundredths, which is in dB/100, so 0.9 at Sound 95% was -15dB.
  if tVolume<=0 {tVolume=0}
  else
  {
    var tDb;
    tDb=20*log10(global.optSound/100)+20*log10(tVolume)
    if ds_map_exists(global.sndGain,tSound) {tDb+=ds_map_find_value(global.sndGain,tSound)}
    if tDb>0 {tDb=0} //never over the file's own volume
    tVolume=1+tDb/100
    if tVolume<0 {tVolume=0}
  }

  if tLoop=0
    SS_PlaySound(tSound)
  else if tLoop=1
    SS_LoopSound(tSound)
  SS_SetSoundVol(tSound,tVolume*10000)

  if tFreq!=1
  {
    if global.modeSpeed=1 {SS_SetSoundFreq(tSound,tFreq*2)}
    else {SS_SetSoundFreq(tSound,tFreq)}
  }
  else
  {
    var tempFreq;
    if global.modeSpeed=1 {tempFreq=SS_GetSoundBytesPerSecond(tSound)}
    else {tempFreq=SS_GetSoundBytesPerSecond(tSound)/2}
    SS_SetSoundFreq(tSound,tempFreq)
  }
}
