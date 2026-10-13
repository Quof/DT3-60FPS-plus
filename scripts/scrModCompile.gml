/*
mods change (added): compiles a piece of mod code (gm82core's code_compile) and returns its index, or -1 if it doesn't
compile (the error goes in the log). The same code text is only compiled once.
argument0: code (already through scrModFixCode)
argument1: where it's from, for the log
*/
var tIdx;
if ds_map_exists(global.modCodeCache,argument0) {return ds_map_find_value(global.modCodeCache,argument0)}
//(code that doesn't compile would end the game in code_compile: scrModCanCompile)
if !scrModCanCompile(argument0)
{
  scrModLog("  ERROR compiling "+argument1+": "+error_last)
  return -1
}
//tIdx=code_compile(argument0)
//(a space first: gm82core's code_compile turns a "return" the code starts with into its own return without looking at
//what comes after it, so code starting with a name like returnRoom came out broken; elsewhere it checks)
tIdx=code_compile(" "+argument0)
if tIdx<0
{
  scrModLog("  ERROR compiling "+argument1+": "+error_last)
  return -1
}
global.modCodeArgc[tIdx]=code_get_argcount(tIdx)
global.modCodeMode[tIdx]=0
ds_map_add(global.modCodeCache,argument0,tIdx)
return tIdx
