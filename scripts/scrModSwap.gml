/*
mods change (added): swaps two mods in the list (scrModInit's load order sort).
argument0, argument1: the two places in the list
*/
var a,b,t;
a=argument0; b=argument1
t=global.modFolder[a]; global.modFolder[a]=global.modFolder[b]; global.modFolder[b]=t
t=global.modName[a]; global.modName[a]=global.modName[b]; global.modName[b]=t
t=global.modAuthor[a]; global.modAuthor[a]=global.modAuthor[b]; global.modAuthor[b]=t
t=global.modVersion[a]; global.modVersion[a]=global.modVersion[b]; global.modVersion[b]=t
t=global.modDesc[a]; global.modDesc[a]=global.modDesc[b]; global.modDesc[b]=t
t=global.modLegacy[a]; global.modLegacy[a]=global.modLegacy[b]; global.modLegacy[b]=t
t=global.modOrder[a]; global.modOrder[a]=global.modOrder[b]; global.modOrder[b]=t
t=global.modFallback[a]; global.modFallback[a]=global.modFallback[b]; global.modFallback[b]=t
t=global.modFallbackX[a]; global.modFallbackX[a]=global.modFallbackX[b]; global.modFallbackX[b]=t
t=global.modFallbackY[a]; global.modFallbackY[a]=global.modFallbackY[b]; global.modFallbackY[b]=t
t=global.modLoaded[a]; global.modLoaded[a]=global.modLoaded[b]; global.modLoaded[b]=t
t=global.modEnabled[a]; global.modEnabled[a]=global.modEnabled[b]; global.modEnabled[b]=t
