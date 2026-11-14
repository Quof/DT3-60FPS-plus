//Evil Boss Gallery: the boss gallery's records kept aside as an evil fight starts in the game's room (the boss's own
//defeat writes its win into them: evgRecRestore puts them back)
var i;
for(i=0;i<65;i+=1)
{
  global.evgRecT[i]=global.bossGalleryTime[i]
  global.evgRecTN[i]=global.bossGalleryTimeN[i]
  global.evgRecHN[i]=global.bossGalleryHitsN[i]
  global.evgRecPN[i]=global.bossGalleryPlatN[i]
}
global.evgRecOk=1
