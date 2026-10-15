//Randomizer: a door's end as the spoiler log names it (argument0: the end): its room (area name and room) and where its
//exit is placed
var tX,r;
tX=global.rndEDExit[argument0]
r=global.rndEXRoom[tX]
return global.rndERLabel[r]+" ("+global.rndERName[r]+") at "+string(global.rndEXX[tX])+","+string(global.rndEXY[tX])
