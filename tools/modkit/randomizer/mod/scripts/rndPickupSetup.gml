//Randomizer: a pickup becomes its location's item (a pickup's alarm 0, a frame after it's made: its creation code has set
//objectNum by then). argument0: its location type. Taken already, or not a location: it goes. It keeps rndLoc and
//rndItem for its collision (rndCollect)
rndLoc=-1
if variable_local_exists("objectNum") {rndLoc=rndLocFind(argument0,objectNum)}
if rndLoc<0 {instance_destroy(); exit}
if rndIsGot(rndLoc) {instance_destroy(); exit}
rndItem=rndPlaced(rndLoc)
rndItemLook(rndItem)
