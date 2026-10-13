/*
mods change (added): name -> index maps of the game's objects, rooms, sprites, backgrounds and fonts, for reading a
mod's files (which name things the way the room editor does). A mod's own resources are added to them as they're made
(scrModRegister). Resource indexes can have gaps, so each list is read until 1000 indexes in a row don't exist. Also
sets up global.modOvr, the mods' versions of the game's scripts (none yet: scrModOverride).
*/
var i,tMiss;
global.modNameObj=ds_map_create()
global.modNameRoom=ds_map_create()
global.modNameSpr=ds_map_create()
global.modNameBg=ds_map_create()
global.modNameFont=ds_map_create()
global.modNameScr=ds_map_create()
i=0; tMiss=0
while tMiss<1000 {if script_exists(i) {ds_map_add(global.modNameScr,script_get_name(i),i); global.modOvr[i]=-1; tMiss=0} else {tMiss+=1}; i+=1}
i=0; tMiss=0
while tMiss<1000 {if object_exists(i) {ds_map_add(global.modNameObj,object_get_name(i),i); tMiss=0} else {tMiss+=1}; i+=1}
i=0; tMiss=0
while tMiss<1000 {if room_exists(i) {ds_map_add(global.modNameRoom,room_get_name(i),i); tMiss=0} else {tMiss+=1}; i+=1}
i=0; tMiss=0
while tMiss<1000 {if sprite_exists(i) {ds_map_add(global.modNameSpr,sprite_get_name(i),i); tMiss=0} else {tMiss+=1}; i+=1}
i=0; tMiss=0
while tMiss<1000 {if background_exists(i) {ds_map_add(global.modNameBg,background_get_name(i),i); tMiss=0} else {tMiss+=1}; i+=1}
i=0; tMiss=0
while tMiss<1000 {if font_exists(i) {ds_map_add(global.modNameFont,font_get_name(i),i); tMiss=0} else {tMiss+=1}; i+=1}
