//Randomizer: the pause menu's Teleport's text in a randomizer game: where it goes (rndTeleport)
var g;
g=rndTeleportGate()
if g>=0 {return "Teleport out of "+global.rndTpName[g]}
return "Teleport to - Central City - North (where the run started)"
