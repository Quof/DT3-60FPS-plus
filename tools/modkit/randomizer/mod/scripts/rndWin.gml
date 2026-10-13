//Randomizer: the Warmaster beaten (after the instruments and the Abomination): the game's credits roll. An Archipelago
//game tells the client it's won (goal.txt)
global.rndWon=1
global.gameProgress=global.rndWorldProg
if global.rndAP=1 {rndApWrite("goal.txt","1")}
room_goto(rEnd_PartC)
