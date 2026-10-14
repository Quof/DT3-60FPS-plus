//Randomizer: the Item Finder isn't one of the items shuffled: its pickup gives it, as in the game. In a randomizer game
//Chao's alert also tells which items open the way on (rndItemFinder), and the message says so. Otherwise as the game's
//own
if global.rndActive=1
{
  playSound(global.snd_HeartPiece,0,1,1)
  showEmote(oIdentifier,0,-6,sEmHappy)
  msgCreate(0,0,"","You found the [Item Finder]. When entering a map, Chao shows a treasure icon if an item is in it, or a ! if it holds an ability, an ability set's item or a key.",6,3,oMessagePerson,0)
  newMessage.fadingTime=360
  awardAwesome(100000)
  global.itemFinder=1
  instance_destroy()
  exit
}
