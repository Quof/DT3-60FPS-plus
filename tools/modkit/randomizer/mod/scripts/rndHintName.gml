//Randomizer: what a vending machine's hint names location argument0's item: as the multiworld names the items
//("Progressive Link", "Key: Access Gate 3: Transylvania": rndData's rndProgName by rndProgOf's number, rndKeyHint by
//the key's door; else the mod's own name, rndItemNameKP); in an Archipelago game, as the client scouted it, another
//world's with whose it is ("<player>'s <item>")
var it,k,p,g;
if global.rndAP=1
{
  if global.rndApLocKnown[argument0]!=1 {return "an item"}
  if global.rndApLocOwn[argument0]=1 {return global.rndApLocName[argument0]}
  return global.rndApLocPlayer[argument0]+"'s "+global.rndApLocName[argument0]
}
it=rndPlaced(argument0)
k=global.rndItemKind[it]
p=global.rndItemParam[it]
g=rndProgOf(k,p)
if g>=1 and g<=12 {return global.rndProgName[g]}
if k=14 {return global.rndKeyHint[p]}
return rndItemNameKP(k,p)
