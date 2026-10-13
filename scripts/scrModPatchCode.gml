/*
mods change (added): compiles a code file named in a patch line, or returns -1 for "-" (none) or a missing file.
argument0: the patch's folder
argument1: the code file's name
argument2: the room, for the log
*/
if argument1="-" or argument1="" {return -1}
if !file_exists(argument0+argument1) {scrModLog("  ERROR: "+argument2+" patch: no file "+argument1); return -1}
return scrModCompile(scrModFixCode(scrModReadFile(argument0+argument1)),argument2+" patch "+argument1)
