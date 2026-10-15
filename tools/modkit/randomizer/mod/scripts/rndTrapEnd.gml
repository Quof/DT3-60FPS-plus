//Randomizer: an enemy trap beaten (the oRndTrap<n> running this, as its barriers go): marked so for good (the save keeps
//global.rndTrapDone), no trap going in the room any more, and the trap's object goes at the end of the step
global.rndTrapDone=rndSetChar(global.rndTrapDone,trapId+1,"1")
global.rndTrapActive=-1
global.rndTrackDirty=1
trapEnd=1
