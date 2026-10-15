//Randomizer: whether an enemy trap (the oRndTrap<n> running this) may start now: the player inside its arena (ax1,ay1
//to ax2,ay2: where their feet are) and no other trap of the room going (the game has one enemy counter and its barriers
//are taken away all at once)
if global.rndTrapActive>=0 {return 0}
if oPlayer1.x<ax1 or oPlayer1.x>ax2 {return 0}
if oPlayer1.y<ay1 or oPlayer1.y>ay2 {return 0}
return 1
