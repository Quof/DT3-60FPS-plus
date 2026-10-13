//Randomizer: in a randomizer game the capsule is a location (its scene ends with the location's item: the step event):
//it's gone once that's taken. Otherwise as the game's own
if global.rndActive=1
{
  x+=8
  image_xscale=0.5
  xCenter=2912
  yCenter=144
  sceneProg=0
  rndLoc=rndLocFind(16,1)
  if rndLoc<0 {instance_destroy()}
  else if rndIsGot(rndLoc) {instance_destroy()}
  exit
}
