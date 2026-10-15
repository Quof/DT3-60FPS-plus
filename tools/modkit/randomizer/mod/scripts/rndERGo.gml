//Randomizer: an entry reached in a state (argument0: the entry, argument1: the state): queued once (rndERRun goes on
//from it, as the node entry*rndEGsN+state)
var ri;
if ds_grid_get(global.rndRGSeen,argument1,argument0)=1 {exit}
ds_grid_set(global.rndRGSeen,argument1,argument0,1)
ri=global.rndEERoom[argument0]
global.rndRRoomIn[ri]=1
if global.rndERArea[ri]>=0 {global.rndRAreaIn[global.rndERArea[ri]]=1}
ds_queue_enqueue(global.rndRQueue,argument0*global.rndEGsN+argument1)
