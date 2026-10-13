//Randomizer: the player takes a location's item (argument0: the location's number): it's marked taken and given. In an
//Archipelago game, the check goes to the client instead (rndApCheck), and the item comes from the server
if rndIsGot(argument0) {exit}
global.rndGot=rndSetChar(global.rndGot,argument0+1,"1")
if global.rndAP=1
{
  rndApCheck(argument0)
  rndApFound(argument0)
  exit
}
rndGive(rndPlaced(argument0))
