//Evil Boss Gallery: one of the game's sprites (argument0) recoloured for an evil fight: the mod's evil\<argument1>.png
//(a strip of the same frames) and .ini (as a mod sprite's) put in its place (sprite_assign), the game's kept aside
//(global.evgSprO/evgSprB, put back by evgSprRestore). Nothing if the file isn't there
var f,tFrames,tXo,tYo,tSep,tBb,tLe,tTo,tRi,tBo,tKind,tTol,tIdx,tB;
f=global.evgDir+"evil\"+argument1
if global.evgDir="" {exit}
if !file_exists(f+".png") {exit}
ini_open(f+".ini")
tFrames=ini_read_real("sprite","frames",1); tXo=ini_read_real("sprite","xorig",0); tYo=ini_read_real("sprite","yorig",0)
tSep=ini_read_real("sprite","sepmasks",0); tBb=ini_read_real("sprite","bboxmode",0); tLe=ini_read_real("sprite","left",0)
tTo=ini_read_real("sprite","top",0); tRi=ini_read_real("sprite","right",0); tBo=ini_read_real("sprite","bottom",0)
tKind=ini_read_real("sprite","kind",0); tTol=ini_read_real("sprite","tolerance",0)
ini_close()
tIdx=sprite_add(f+".png",tFrames,0,0,tXo,tYo)
if tIdx<0 {exit}
sprite_collision_mask(tIdx,tSep,tBb,tLe,tTo,tRi,tBo,tKind,tTol)
tB=sprite_duplicate(argument0)
sprite_assign(argument0,tIdx)
sprite_delete(tIdx)
global.evgSprO[global.evgSprN]=argument0
global.evgSprB[global.evgSprN]=tB
global.evgSprN+=1
