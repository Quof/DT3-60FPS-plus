/*
gm82snd change (added): SuperSound's SS_IsSoundPlaying(handle): 1 while a sound plays, once or looping. As in SuperSound,
a paused one counts as playing (SS_IsSoundPaused tells them apart).
argument0: handle
*/
if !ds_map_exists(global.ssName,argument0) {return 0}
return (scrSSInstance(argument0)!=0)
