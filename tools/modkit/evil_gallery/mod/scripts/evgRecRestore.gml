//Evil Boss Gallery: the boss gallery's records back as evgRecSnap kept them
var i;
if global.evgRecOk=1
{
  for(i=0;i<65;i+=1)
  {
    global.bossGalleryTime[i]=global.evgRecT[i]
    global.bossGalleryTimeN[i]=global.evgRecTN[i]
    global.bossGalleryHitsN[i]=global.evgRecHN[i]
    global.bossGalleryPlatN[i]=global.evgRecPN[i]
  }
}
global.evgRecOk=0
