//Randomizer: a way into a room as the spoiler log names it (argument0: the way in): its room (area name and room) and
//where it has the player come in
var e,r;
e=argument0
r=global.rndEERoom[e]
return global.rndERLabel[r]+" ("+global.rndERName[r]+") at "+string(global.rndEEX[e])+","+string(global.rndEEY[e])
