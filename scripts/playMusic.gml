/*
This script is called when playing music
use: playMusic(file,play,loop)

argument0: which file to play
argument1: 0=playing, 1=pause, 2=resume
argument2: only used when playing, 0=loop, 1=play
*/

var tempMusic,tempPlay,tempLoop,tempVol;
tempMusic=argument0
tempPlay=argument1
tempLoop=argument2

if global.optMusic>0
{
  //var sliderDb, totalDb;
  //sliderDb = 20*log10(global.optMusic/100) // slider position
  //totalDb = sliderDb + global.currentMusicGain
  //if totalDb>0 {totalDb=0} // never exceed full volume
  //tempVol = totalDb*100
  //if tempVol<-10000 {tempVol=0}
  //remastered music change: in scrMusicVolume now, so the Music Volume option, the title music and scene fades use the
  //same volume. totalDb*100 was also always 0 or below there: SuperSound's volume runs 0-10000 (10000 is full, each 100
  //below that is 1dB quieter), so the dB goes on top of 10000
  tempVol=scrMusicVolume(global.currentMusicGain)

  if tempPlay=0 //start music
  {
    if SS_IsHandleValid(tempMusic)
    {
      if tempLoop=0 //loop
      {
        if !SS_IsSoundLooping(tempMusic)
        {
          SS_LoopSound(tempMusic)
          SS_SetSoundVol(tempMusic,tempVol) //was global.optMusic*100
        }
      }
      else //play once
      {
        if !SS_IsSoundPlaying(tempMusic)
        {
          SS_PlaySound(tempMusic)
          SS_SetSoundVol(tempMusic,tempVol) //was global.optMusic*100
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
      SS_SetSoundVol(tempMusic,tempVol) //was global.optMusic*100
    }
  }

  if global.modeSpeed=1 {SS_SetSoundFreq(tempMusic,44100)}
}
