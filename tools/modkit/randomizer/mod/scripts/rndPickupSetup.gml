//Randomizer: a pickup becomes its location's item (a pickup's alarm 0, a frame after it's made: its creation code has set
//objectNum by then). argument0: its location type. Taken already, or not a location: it goes. It keeps rndLoc and
//rndItem for its collision (rndCollect), and takes the item's look where its own sprite was (rndItemFit)
var tSpr,tFrm;
rndLoc=-1
if variable_local_exists("objectNum") {rndLoc=rndLocFind(argument0,objectNum)}
if rndLoc<0 {instance_destroy(); exit}
if rndIsGot(rndLoc) {instance_destroy(); exit}
rndItem=rndPlaced(rndLoc)
tSpr=sprite_index
tFrm=floor(image_index)
if image_speed>0 {tFrm=-1}
//(an Archipelago game's Nightmare Gate reward isn't one of its locations: it's the gate's own instrument)
if global.rndAP=1 and global.rndLocType[rndLoc]!=18 {rndApLook(rndLoc)}
else if global.rndAP=1 {rndItemLookKP(26,global.rndLocNum[rndLoc])}
else {rndItemLook(rndItem)}
rndItemFit(tSpr,tFrm)
