/*
mods change (added): adds a line to the mod loading log (written to Mods\mod_log.txt when loading is done).
argument0: text
*/
global.modLog+=argument0+chr(13)+chr(10)
