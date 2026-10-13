//Randomizer: a new game (the roomStart hook, in the intro room). The world is the game's endgame world (rndWorld: every
//area open), without the CHAOS invasion, and with the instrument quest and the Abomination still to do; the player has
//only walking (initGameVars set everything else to none). The items are placed (rndGenerate), the spoiler log written
//(rndLog), and the game starts in the first room, where the intro would have taken the player. An Archipelago game
//(the title screen's code 'ap', with the DT3+ Client connected) has its items in the multiworld instead: none are
//placed here, its checks go to the client and its items come from it (rndApStart, rndApPoll)
var tTry,tOk;
rndWorld()
global.CHAOS_Invasion=0
global.CHAOS_Upgrade=0
global.eGateProg="00000000"
global.gateHProg=0
global.abomAttempts=0
global.gameProgress=global.rndWorldProg
global.activeCharacter=0
global.activeAbility[0]=0
global.activeAbility[1]=0
//not the game completed, even over a slot whose save had it (the title's New Game keeps it from there): Bubble Tower B
//and the Gate 6 DLC stay shut
global.gameCompleted=0

if global.rndApNext=1
{
  if rndApReadSession()=0
  {
    show_message("Archipelago: the DT3+ Client isn't connected to a multiworld. Start it from the Archipelago Launcher and connect, then start the new game. This new game is a Randomizer game on its own instead.")
  }
  else
  {
    global.rndAP=1
    global.rndApSeedLine=global.rndApSession
    global.rndApRecv=0
    global.rndApDeaths=0
    global.rndSeed=global.rndApShopSeed
    rndVanillaPlace()
    random_set_seed(global.rndApShopSeed)
    rndShopShuffle()
    randomize()
    if file_exists(global.rndApPath+"goal.txt") {file_delete(global.rndApPath+"goal.txt")}
    rndApStart()
  }
  global.rndApNext=0
}
if global.rndAP=0
{
  randomize()
  if global.rndNextSeed>=0 {global.rndSeed=global.rndNextSeed}
  else {global.rndSeed=irandom(999999)}
  global.rndNextSeed=-1
  tOk=0
  for(tTry=0;tTry<20 and tOk=0;tTry+=1)
  {
    random_set_seed(global.rndSeed+tTry*7919)
    tOk=rndGenerate()
  }
  if tOk=0
  {
    show_message("Randomizer: the items couldn't be placed for seed "+string(global.rndSeed)+" (its logic.txt asks for more than the locations allow). They're left in their own places.")
    rndVanillaPlace()
  }
  rndShopShuffle()
}
global.rndActive=1
global.rndWon=0
rndAbilApply()
if global.rndAP=0 {rndLog()}
randomize()
//where the opening scene leaves the player: on the ground of the first room, not paused (the intro paused the game,
//and its scene doesn't run past the story)
global.newMapX=240
global.newMapY=2048
global.gamePaused=false
room_goto(rMain_1)
