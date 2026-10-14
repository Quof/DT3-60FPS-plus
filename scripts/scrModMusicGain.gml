/*
mods change (added): getReplayGain for a mod's music track (findMusic, when it plays one): mod.ini [music] gain (dB, 0
if not given) with getReplayGain's offset (refOffset there: keep them the same).
argument0: track number (one scrModMusicFind found)
*/
if !variable_global_exists("modMusic") {return 0}
if !ds_map_exists(global.modMusic,argument0) {return 0}
return global.modMusGain[ds_map_find_value(global.modMusic,argument0)]+1.5
