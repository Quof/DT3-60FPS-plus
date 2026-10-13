//Randomizer, Archipelago: an Archipelago game starting or being loaded. What its locations hold (rndApReadLocations;
//again later while the client hasn't scouted them yet: rndApPoll), its checks written out whole for the client
//(rndApWriteChecks, so ones made while it was away get sent), its DeathLink setting from the client's session when
//that's this game's, and the DeathLink deaths from before now passed over
var i;
for(i=0;i<global.rndLocN;i+=1)
{
  global.rndApLocKnown[i]=0
  global.rndApLocOwn[i]=0
  global.rndApLocItem[i]=0
  global.rndApLocName[i]=""
  global.rndApLocPlayer[i]=""
  global.rndApLocFlags[i]=0
}
global.rndApLocLoaded=0
global.rndApPollT=0
global.rndApDying=0
global.rndApDeathGot=0
global.rndApDeathLink=0
if global.rndApSession=global.rndApSeedLine {global.rndApDeathLink=global.rndApSessDeath}
rndApReadLocations()
rndApWriteChecks()
global.rndApDeathSeen=rndApDeathTime()
