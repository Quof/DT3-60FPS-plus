//Randomizer: whether the player has an empty bottle (the game's bottles, oPlayer1.pBottles: "1" empty, "2" and "3"
//filled), which a vending machine fills (its drinks); without one, it sells hints (oVendingMachine). 1 when there's no
//player to ask
var i;
if !instance_exists(oPlayer1) {return 1}
for(i=0;i<2;i+=1) {if oPlayer1.pBottles[i]="1" {return 1}}
return 0
