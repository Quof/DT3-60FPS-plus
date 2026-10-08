/*
remastered music change (added): the SuperSound volume for music (0-10000: 10000 is full volume, each 100 below it is
1dB quieter) at the Music Volume option (global.optMusic, 0-100), with a track's loudness adjustment on top. playMusic
and everything else that sets the music's volume (the Music Volume option, the title music, scenes that fade the music
from where it is) use it, so they all agree.
argument0: the track's adjustment in dB (getReplayGain; global.currentMusicGain is the one for the music playing)
*/
var tDb,tVol;
if global.optMusic<=0 {return 0}
tDb=20*log10(global.optMusic/100)+argument0
if tDb>0 {tDb=0} //never over full volume
tVol=round(10000+tDb*100)
if tVol<0 {tVol=0}
return tVol
