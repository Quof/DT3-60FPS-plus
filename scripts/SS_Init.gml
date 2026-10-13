/*
gm82snd change (added): the game's sound ran on the SuperSound v1 extension (its SS_ functions). These SS_ scripts take
its place on Game Maker 8.2 Sound (gm82snd, which plays through FMOD), under the same names and with the same
arguments and units, so everything that calls them works as before:
- a handle (SS_LoadSound) is one sound with one copy, so playing it again starts it over
- volume, frequency and pan stay set on a handle between plays, in SuperSound's units: volume 0-10000 (each 100 below
  10000 is 1dB quieter), frequency in Hz, pan -10000 to 10000, positions and lengths in bytes
- handles count up from 1 and are never reused, so a freed one (SS_FreeSound) stays invalid
SS_Init sets up the handle tables. oInitializeGame calls it once, before loadExtFiles.
*/
if variable_global_exists("ssName") {return 1}
global.ssNext=1                   //the next handle SS_LoadSound gives out
global.ssName=ds_map_create()     //handle: its gm82snd sound
global.ssInst=ds_map_create()     //handle: the gm82snd instance playing it, 0 if none
global.ssLoop=ds_map_create()     //handle: 1 if that instance loops
global.ssLastLoop=ds_map_create() //handle: 1 if it was last played looping (SS_ResumeSound starts a stopped one that way)
global.ssPaused=ds_map_create()   //handle: 1 while paused
global.ssVol=ds_map_create()      //handle: volume, 0-10000
global.ssFreq=ds_map_create()     //handle: frequency, Hz
global.ssPan=ds_map_create()      //handle: pan, -10000 to 10000
global.ssRate=ds_map_create()     //handle: the file's sample rate
global.ssBps=ds_map_create()      //handle: the file's bytes a second, as SuperSound counted them (scrSSFormat)
global.ssLevel=ds_map_create()    //handle: 1, or global.ssStereoLevel for a stereo file
//FMOD plays a mono sound centered at 71% (-3dB) on each side, where SuperSound (DirectSound) played it at 100%. Both play
//stereo at 100%. Stereo files (the music, DT_Slam and DT_CVItemGet) are turned down by the same 3dB so the sound effects
//and the music keep the balance they had. 1 keeps the music as loud as before, with the effects 3dB quieter than it
global.ssStereoLevel=0.70710678
return 1
