//Randomizer: the game is about to make room argument0 (an exit, a save loaded, the game over screen's retry, a gate's
//turning back): one of the Highlands' rooms (rndHLRoom) is made as it was before the CHAOS Warship's attack, which the
//endgame world is past. Its own code and its instances' creation code look at gameProgress: from 4940 on, the attack's
//purple sky, fog and music (oHighlandChanges), CHAOS's enemies and the people who came after it, in place of the
//Highlands' own enemies and music. Made with gameProgress 4935 (rndHLProg) they're as before the attack, and the
//roomStart hook puts the endgame's back as the room starts, before anything else reads it. 4935 is no story step's (the
//story's are 4930, 4940...), and is past 4930, below which Upper Crossroad's rubble (an invisible solid and its tiles)
//goes, so the room logic's rooms are as it has them (the hook takes out the one exit 4935 has that the endgame hasn't)
if global.rndActive=0 {exit}
if !rndHLRoom(argument0) {exit}
global.gameProgress=4935
global.rndHLProg=1
