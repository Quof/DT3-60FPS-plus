//Randomizer: whether a chest location's item makes the chest sparkle, as the game's equipment chests do (argument0: the
//location's number): anything but Internetz; in an Archipelago game, another world's item too
var id;
if global.rndAP=1
{
  if global.rndApLocKnown[argument0]=1
  {
    if global.rndApLocOwn[argument0]=1
    {
      id=global.rndApLocItem[argument0]-global.rndApBase
      return (id div 10000)!=2
    }
  }
  return 1
}
return global.rndItemKind[rndPlaced(argument0)]!=2
