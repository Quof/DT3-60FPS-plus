/*
mods change (added): the index of a named object, room, sprite, background or font (the game's own or a mod's), or of
one of the game's scripts, or -1. "" (no name, as in an object with no sprite) is -1 too.
argument0: name
argument1: "obj", "room", "spr", "bg", "font" or "scr"
*/
var tMap;
if argument0="" {return -1}
if argument1="obj" {tMap=global.modNameObj}
else if argument1="room" {tMap=global.modNameRoom}
else if argument1="spr" {tMap=global.modNameSpr}
else if argument1="bg" {tMap=global.modNameBg}
else if argument1="scr" {tMap=global.modNameScr}
else {tMap=global.modNameFont}
if ds_map_exists(tMap,argument0) {return ds_map_find_value(tMap,argument0)}
return -1
