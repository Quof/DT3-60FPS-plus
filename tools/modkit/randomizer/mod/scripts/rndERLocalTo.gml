//Randomizer: rndERLocal's look past an end's way back in: an entry got to (argument0; -1: nowhere) that neither it nor
//the shuffle has reached: new (global.rndSLE), and gone on from
var v;
v=argument0
if v<0 {exit}
if global.rndSLVis[v]=global.rndSLStamp or global.rndSSeen[v]=global.rndSStamp {exit}
global.rndSLVis[v]=global.rndSLStamp
global.rndSLE=1
ds_stack_push(global.rndSLStack,v)
