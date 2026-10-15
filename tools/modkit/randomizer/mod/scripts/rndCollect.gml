//Randomizer: the player takes a location's item (argument0: the location's number): it's marked taken and given. In an
//Archipelago game, the check goes to the client instead (rndApCheck), and the item comes from the server; a Nightmare
//Gate's reward (location type 18) isn't one of its locations: it gives the gate's own instrument
if rndIsGot(argument0) {exit}
global.rndGot=rndSetChar(global.rndGot,argument0+1,"1")
global.rndTrackDirty=1
if global.rndAP=1
{
  if global.rndLocType[argument0]=18 {rndGiveKP(26,global.rndLocNum[argument0]); exit}
  rndApCheck(argument0)
  rndApFound(argument0)
  exit
}
rndGive(rndPlaced(argument0))
