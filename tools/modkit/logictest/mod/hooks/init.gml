//Logic Test: the game's variables are set up (the title screen, a new game, a save being loaded), and once when the
//mods are loaded. Its own variables are set once (ltInit), and the runner (oLTRunner, persistent) is made
ltInit()
if !instance_exists(oLTRunner) {instance_create(0,0,oLTRunner)}
