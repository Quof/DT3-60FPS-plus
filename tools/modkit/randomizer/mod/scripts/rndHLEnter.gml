//Randomizer: the game is about to make room argument0 (an exit, a save loaded, the game over screen's retry, a gate's
//turning back, a Teleport Trap; any other way in, the roomStart hook makes it again with this): one of the Highlands'
//rooms (rndHLRoom) is made as it was before the CHAOS Warship's attack, which the endgame world is past. Its own code
//and its instances' creation code look at gameProgress: from 4940 on, the attack's purple sky, fog and music
//(oHighlandChanges), CHAOS's enemies and the people who came after it, in place of the Highlands' own enemies and
//music; from 4930 to 4960 the Teleporting Stone (oWarpStatue) is off, and from 4930 to 4940 the player's Create turns
//Chao's scan off and starts the attack's walk through the world (oEvCh19WorldEv), and the Hex circles hit harder. Made
//with gameProgress 4925 (rndHLProg) it's the Highlands as they were, nothing shut, and the roomStart hook puts the
//endgame's back as the room starts, before anything else reads it. 4925 is no story step's (the story's are 4920,
//4930...) and past every one these rooms' earlier story looks at (4570: Upper Crossroad's people from before). Below
//4930 Upper Crossroad has no rubble (the attack's: an invisible solid and its tiles at the end of its lower way, which
//only shuts the way to rTS_A, gone in the endgame), and its way to the Hidden Bot Village leads to the village as it
//was: the hook takes out the way to rTS_A and sends that one to the destroyed village, as the endgame and the room
//logic have them
if global.rndActive=0 {exit}
if !rndHLRoom(argument0) {exit}
global.gameProgress=4925
global.rndHLProg=1
