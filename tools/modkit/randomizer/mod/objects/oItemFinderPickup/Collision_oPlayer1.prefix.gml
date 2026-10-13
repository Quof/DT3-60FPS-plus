//Randomizer: in a randomizer game, the location's item. Otherwise as the game's own
if global.rndActive=1
{
  if variable_local_exists("rndLoc") {if rndLoc>=0 {rndCollect(rndLoc); instance_destroy()}}
  exit
}
