//Randomizer: whether the player is in The Executive's fight (the mod's fight of boss type 64, in his own room: Boss
//Rando leaves him there). It gives both characters Gate 6's two sets whole, as the game's own fight does (his phases are
//made for them: rndAbilApply, rndAbilClamp), so it needs nothing of the player's (roomlogic\bosses.txt)
if global.rndFight>=0 {if global.rndBossType[global.rndFight]=64 {return true}}
return false
