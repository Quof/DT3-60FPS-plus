//Randomizer: whether a chest location's item makes the chest sparkle, as the game's equipment chests do (argument0: the
//location's number): anything but Internetz; in an Archipelago game, another world's item too
//var id;
var tId; //bug fix (not a 60fps change): tId, not id: GameMaker's own instance id can't be a var, so the script didn't compile and the game left it out
if global.rndAP=1
{
  if global.rndApLocKnown[argument0]=1
  {
    if global.rndApLocOwn[argument0]=1
    {
      //id=global.rndApLocItem[argument0]-global.rndApBase
      //return (id div 10000)!=2
      tId=global.rndApLocItem[argument0]-global.rndApBase //bug fix: tId (see the var line)
      return (tId div 10000)!=2 //bug fix: tId
    }
  }
  return 1
}
return global.rndItemKind[rndPlaced(argument0)]!=2
