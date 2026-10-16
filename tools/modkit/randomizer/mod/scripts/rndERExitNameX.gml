//Randomizer: an exit as the spoiler log names it (argument0: the exit): its room (area name and room) and where it's
//placed
var tX,r;
tX=argument0
r=global.rndEXRoom[tX]
return global.rndERLabel[r]+" ("+global.rndERName[r]+") at "+string(global.rndEXX[tX])+","+string(global.rndEXY[tX])
