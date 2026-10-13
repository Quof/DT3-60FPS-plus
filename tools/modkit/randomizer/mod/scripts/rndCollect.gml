//Randomizer: the player takes a location's item (argument0: the location's number): it's marked taken and given
if rndIsGot(argument0) {exit}
global.rndGot=rndSetChar(global.rndGot,argument0+1,"1")
rndGive(rndPlaced(argument0))
