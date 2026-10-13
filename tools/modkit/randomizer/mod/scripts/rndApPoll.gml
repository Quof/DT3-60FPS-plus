//Randomizer, Archipelago: every frame of an Archipelago game (oRndWatcher). Every 10 ticks: what its locations hold if
//the client hadn't scouted them yet, the items received (rndApItems) and DeathLink deaths from the multiworld
//(rndApDeath). Every frame: the player's own game over, sent as a DeathLink death (not one a DeathLink death caused, or
//the pause menu's)
if global.rndApDeathLink=1
{
  if instance_exists(oGameOver)
  {
    if global.rndApDying=0
    {
      global.rndApDying=1
      if global.rndApDeathGot=0 and oGameOver.checkQuickGO=0 //(oGameOver keeps quickGameOver, the pause menu's, as it starts)
      {
        global.rndApDeaths+=1
        rndApWrite("death_out.txt",string(global.rndApDeaths))
      }
      global.rndApDeathGot=0
    }
  }
  else {global.rndApDying=0}
}
global.rndApPollT+=1*gDeltaTime
if global.rndApPollT<10 {exit}
global.rndApPollT=0
//the client connecting to this game's multiworld after it was loaded: its DeathLink setting, from then on
if global.rndApSession!=global.rndApSeedLine
{
  rndApReadSession()
  if global.rndApSession=global.rndApSeedLine
  {
    global.rndApDeathLink=global.rndApSessDeath
    global.rndApDeathSeen=rndApDeathTime()
  }
}
if global.rndApLocLoaded=0 {rndApReadLocations()}
rndApItems()
if global.rndApDeathLink=1 {rndApDeath()}
