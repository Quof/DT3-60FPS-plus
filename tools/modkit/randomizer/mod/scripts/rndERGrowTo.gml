//Randomizer: making a shuffle (rndERShuffle): an entry reached with everything (argument0; -1: nowhere), if it wasn't:
//its room seen, and it's gone on from (rndERGrow's stack)
var v;
v=argument0
if v<0 {exit}
if global.rndSSeen[v]=global.rndSStamp {exit}
global.rndSSeen[v]=global.rndSStamp
global.rndSRoom[global.rndEERoom[v]]=global.rndSStamp
ds_stack_push(global.rndSStack,v)
