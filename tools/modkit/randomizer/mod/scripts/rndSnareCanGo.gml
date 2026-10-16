//Randomizer: whether a Teleport Trap can take the player now (rndSnareTeleport): in one of the game's rooms with the
//player in it, not in a boss fight or the boss gallery (it waits till that's over), the game going on (not paused, not
//the game over screen)
if global.rndActive=0 or !instance_exists(oPlayer1) or instance_exists(oGameOver) {return 0}
if global.rndFight>=0 or global.bBossGallery=1 or room=rBossGallery or global.gamePaused=true {return 0}
return 1
