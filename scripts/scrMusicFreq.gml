/*
remastered music change (added): sets a music track's playback rate as if its file were 22050 Hz, as all of the original
music was (MusicOld). Every rate the game sets on music was picked for those files: 22050 is normal speed, 11025 half
speed, 44100 double, and so on. The remastered files in Music aren't all 22050 Hz (most are 44100; some are 24000, 32000,
48000 or 96000), so the rate is scaled to the file's own. That one comes from SuperSound's bytes a second: 4 a sample for
the music (16-bit stereo), the same way playSound gets a sound effect's (2 a sample, mono). If that isn't a sample rate,
the rate is set as given, as before.
argument0: the music's sound (e.g. global.msc_BowserFight)
argument1: the rate for a 22050 Hz file
*/
var tRate,tFreq;
if !SS_IsHandleValid(argument0) {exit}
tRate=SS_GetSoundBytesPerSecond(argument0)/4
if tRate!=11025 and tRate!=16000 and tRate!=22050 and tRate!=24000 and tRate!=32000 and tRate!=44100 and tRate!=48000 and tRate!=88200 and tRate!=96000 {tRate=22050}
tFreq=argument1*tRate/22050
if tFreq>200000 {tFreq=200000} //DirectSound's highest
if tFreq<100 {tFreq=100} //and lowest
SS_SetSoundFreq(argument0,tFreq)
