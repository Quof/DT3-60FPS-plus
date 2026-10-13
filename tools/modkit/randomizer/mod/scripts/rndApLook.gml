//Randomizer, Archipelago: makes the instance look like a location's item (argument0: its number): this world's own as
//itself (rndItemLookKP), another world's (or one not scouted yet) as the Archipelago orb (the mod's sRndAPItem)
var id;
if global.rndApLocKnown[argument0]=1
{
  if global.rndApLocOwn[argument0]=1
  {
    id=global.rndApLocItem[argument0]-global.rndApBase
    rndItemLookKP(id div 10000,id mod 10000)
    exit
  }
}
sprite_index=sRndAPItem
image_index=0
image_speed=0
image_blend=c_white
