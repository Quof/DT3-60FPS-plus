//Evil Boss Gallery: an evil fight in the game's own room (evgKind 2; the roomStart hook makes one there as the room
//starts). The boss's sprites recoloured for the fight (evgSprSwap: the game's sprites, put back when it's over) and the
//boss gallery's records kept aside (evgRecSnap: the boss's own defeat writes its win into them, evgWin puts them back)
evgSprSwap(global.evgFight)
evgRecSnap()
global.evgSprRoom=room
