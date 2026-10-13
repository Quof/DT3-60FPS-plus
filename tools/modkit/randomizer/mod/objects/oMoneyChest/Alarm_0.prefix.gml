//Randomizer: in a randomizer game the chest is a location: opened already, it's the open chest; otherwise it holds its
//location's item, and sparkles (as the game's equipment chests do) unless that's Internetz. Otherwise as the game's own
if global.rndActive=1
{
  rndLoc=-1
  if variable_local_exists("objectNum") {rndLoc=rndLocFind(2,objectNum)}
  if rndLoc<0 {instance_destroy(); exit}
  if rndIsGot(rndLoc)
  {
    newChestDummy=instance_create(x,y,oChestOpenDummy)
    newChestDummy.image_yscale=image_yscale
    instance_destroy()
    exit
  }
  indexCheck="0"
  rndItem=rndPlaced(rndLoc)
  specialChest=rndChestSpecial(rndLoc)
  exit
}
