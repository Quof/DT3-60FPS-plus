//Randomizer: in a randomizer game, Chao's Item Finder alert is for the locations still in the room (rndItemFinder),
//with a ! for an ability, an ability set's item or a key. Otherwise as the game's own
if global.rndActive=1
{
  if global.itemFinder=1
  {
    treasureFind+=1*gDeltaTime
    if treasureFind=35
    {
      var tFind;
      tFind=rndItemFinder()
      if tFind>0
      {
        if global.optChaoItemWarn=1 {playSound(global.snd_Chao_Hey,0,1,20050+random(4000))}
        if tFind=2 {showEmote(oIdentifier,0,-6,sEmExcite)}
        else {showEmote(oIdentifier,0,-6,sEmTreasure)}
        heartEmote=100
      }
    }
  }
  exit
}
