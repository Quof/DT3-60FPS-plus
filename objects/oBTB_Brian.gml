#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mapProg=0
mapTime=0
mySoundFreq=22050
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if mapProg=0
  {
    if oPlayer1.x>=944
    {
      mapProg=1
    }
  }
  else if mapProg=1
  {
    //SS_SetSoundFreq(global.msc_MarioWorld,mySoundFreq)
    scrMusicFreq(global.msc_MarioWorld,mySoundFreq) //remastered music change: scaled to the file's own sample rate (scrMusicFreq)
    mySoundFreq-=100*gDeltaTime
    if mySoundFreq<=1500
    {
      //SS_SetSoundFreq(global.msc_MarioWorld,22050)
      scrMusicFreq(global.msc_MarioWorld,22050) //remastered music change: scaled to the file's own sample rate (scrMusicFreq)
      SS_StopSound(global.msc_MarioWorld)
      mapProg=2
    }
  }
}
