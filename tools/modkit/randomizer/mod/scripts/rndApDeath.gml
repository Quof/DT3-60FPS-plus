//Randomizer, Archipelago: a DeathLink death from the multiworld newer than the last one (rndApDeathTime): the player
//dies, unless they're dying already, paused or can't now
var t;
t=rndApDeathTime()
if t<=global.rndApDeathSeen {exit}
global.rndApDeathSeen=t
if !instance_exists(oPlayer1) or instance_exists(oGameOver) or global.gamePaused=true or global.bCanGameOver!=1 {exit}
global.rndApDeathGot=1
oPlayer1.life=0
rndMsg("DeathLink:#"+global.rndApDeathCause,2)
