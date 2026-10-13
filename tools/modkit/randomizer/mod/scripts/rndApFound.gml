//Randomizer, Archipelago: the message for a location's item as it's checked (argument0: its number). Another world's says
//whose it is; this world's own comes back from the server like any received item, with its own message (rndApItems)
if global.rndApLocKnown[argument0]=1
{
  if global.rndApLocOwn[argument0]=1 {exit}
  playSound(global.snd_HeartPiece,0,1,1)
  rndMsg("You found "+global.rndApLocName[argument0]+"#for "+global.rndApLocPlayer[argument0]+"!",2)
  exit
}
playSound(global.snd_HeartPiece,0,1,1)
rndMsg("You found an item for the multiworld!",1)
