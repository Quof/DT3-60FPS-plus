/*
mods change (added): adds a mod's new object, room, sprite, background or font to the name maps (scrModFind), and makes
its name usable in code: names that aren't the game's own resources become global variables holding the index
(globalvar), so a mod's code can say oMyEnemy or rMyRoom like the game's code does.
argument0: name
argument1: index
argument2: "obj", "room", "spr", "bg" or "font"
*/
var tMap,tName;
tName=argument0
if argument2="obj" {tMap=global.modNameObj}
else if argument2="room" {tMap=global.modNameRoom}
else if argument2="spr" {tMap=global.modNameSpr}
else if argument2="bg" {tMap=global.modNameBg}
else {tMap=global.modNameFont}
if ds_map_exists(tMap,tName) {ds_map_replace(tMap,tName,argument1)}
else {ds_map_add(tMap,tName,argument1)}
if !scrModIsName(tName) {scrModLog("  not usable as a name in code: "+tName); exit}
if !variable_global_exists(tName) {execute_string("globalvar "+tName+";")}
variable_global_set(tName,argument1)
