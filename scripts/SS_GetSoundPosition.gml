/*
gm82snd change (added): SuperSound's SS_GetSoundPosition(handle): how far a playing sound is, in bytes
(SS_GetSoundBytesPerSecond a second). 0 if it isn't playing.
argument0: handle
*/
var tInst;
if !ds_map_exists(global.ssName,argument0) {return 0}
tInst=scrSSInstance(argument0)
if tInst=0 {return 0}
return floor(sound_get_pos(tInst,unit_seconds)*ds_map_find_value(global.ssBps,argument0))
