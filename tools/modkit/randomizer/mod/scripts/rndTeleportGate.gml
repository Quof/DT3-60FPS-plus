//Randomizer: the gate the player is in, for the pause menu's Teleport (rndTeleport): its place in rndTp* (rndgen.py's
//TELEPORT_GATES: the Access Gates' and the Nightmare Gates' areas, global.location), or -1 outside them. With Entrance
//Rando Chaos, every door shuffled, -1 anywhere: the Teleport goes where the game started
var i;
if global.rndERMode=3 {return -1}
for(i=0;i<global.rndTpN;i+=1) {if global.rndTpArea[i]=global.location {return i}}
return -1
