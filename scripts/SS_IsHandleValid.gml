/*
gm82snd change (added): SuperSound's SS_IsHandleValid(handle): 1 if the handle is a loaded sound (SS_LoadSound) that
hasn't been freed (SS_FreeSound). 0 (an unloaded music track) never is.
argument0: handle
*/
return ds_map_exists(global.ssName,argument0)
