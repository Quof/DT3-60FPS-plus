/*
gm82snd change (added): the gm82snd pan (-1 left to 1 right) for a SuperSound pan (SS_SetSoundPan: -10000 to 10000,
DirectSound's, which turns the other side down 1dB every 100).
argument0: SuperSound pan
*/
if argument0=0 {return 0}
return sign(argument0)*(1-power(10,-min(abs(argument0),10000)/2000))
