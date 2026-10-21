//Randomizer: whether a chest location's item makes the chest sparkle, as the game's equipment chests do (argument0: the
//location's number): a progression item (rndProgOf: an ability or set, a key, an Air Upgrade, a cursed piece, a Program
//Chip...) or a trap item. In an Archipelago game another world's item when
//it's progression (its flags' bit 1), and one not scouted yet
var tId,k,p;
if global.rndAP=1
{
  if global.rndApLocKnown[argument0]!=1 {return 1}
  if global.rndApLocOwn[argument0]!=1 {return (global.rndApLocFlags[argument0] & 1)=1}
  tId=global.rndApLocItem[argument0]-global.rndApBase
  k=tId div 10000
  p=tId mod 10000
}
else
{
  tId=rndPlaced(argument0)
  k=global.rndItemKind[tId]
  p=global.rndItemParam[tId]
}
return rndProgOf(k,p)>=0 or k=29
