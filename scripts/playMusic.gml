/*
This script is called when playing music
use: playMusic(file,play,loop)

argument0: which file to play
argument1: 0=playing, 1=pause, 2=resume
argument2: only used when playing, 0=loop, 1=play
*/

var tempMusic,tempPlay,tempLoop;
tempMusic=argument0
tempPlay=argument1
tempLoop=argument2

if global.optMusic>0
{
  if tempPlay=0 //start music
  {
    if SS_IsHandleValid(tempMusic)
    {
      if tempLoop=0 //loop
      {
        if !SS_IsSoundLooping(tempMusic)
        {
          SS_LoopSound(tempMusic)
          SS_SetSoundVol(tempMusic,global.optMusic*100)
        }
      }
      else //play once
      {
        if !SS_IsSoundPlaying(tempMusic)
        {
          SS_PlaySound(tempMusic)
          SS_SetSoundVol(tempMusic,global.optMusic*100)
        }
      }
    }
  }
  else if tempPlay=1 //pause music
  {
    if SS_IsHandleValid(tempMusic)
      SS_PauseSound(tempMusic)
  }
  else if tempPlay=2 //resume music
  {
    if SS_IsHandleValid(tempMusic)
    {
      SS_ResumeSound(tempMusic)
      SS_SetSoundVol(tempMusic,global.optMusic*100)
    }
  }

  if global.modeSpeed=1 {SS_SetSoundFreq(tempMusic,44100)}
}
