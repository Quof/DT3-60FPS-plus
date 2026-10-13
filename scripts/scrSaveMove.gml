/*
saves folder change (added): moves a file from the game's folder into the Saves folder (global.saveDir) when the Saves
folder doesn't have it. It's moved, not copied, so it's only ever in one place. An empty file in the Saves folder
counts as not having it (scrFileHas). If the move fails, the file is copied instead so nothing is lost. Without a
Saves folder (global.saveDir is "") nothing happens.
argument0: file name, e.g. "DT3data.dts"
returns 1 if the file was brought into the Saves folder, else 0
*/
var tTo;
if global.saveDir="" {return 0}
if !scrFileHas(argument0) {return 0}
tTo=global.saveDir+argument0
if scrFileHas(tTo) {return 0}
if file_exists(tTo) {file_delete(tTo)}
file_rename(argument0,tTo)
if !file_exists(tTo) {file_copy(argument0,tTo)}
return file_exists(tTo)
