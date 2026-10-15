//Randomizer: a new game (in the intro room: the options window's Start Game, oRndOptions, or the roomStart hook for an
//Archipelago game). The world is the game's endgame world (rndWorld: every area open), without the CHAOS invasion, and
//with the instrument quest and the Abomination still to do; the player can walk and jump (initGameVars set everything
//else to none). The items are placed (rndGenerate), the equipment shops shuffled and the spoiler log written (rndLog) as
//the options say, and the game starts in Central City - North, where the door from Greatest Stretch comes in. An
//Archipelago game (the title screen's code 'ap', with the DT3+ Client connected) has its items in the multiworld
//instead: none are placed here, its checks go to the client and its items come from it (rndApStart, rndApPoll).
//With the option Entrance Rando (global.rndOptER: 1 Gate Swap, 2 Overworld, 3 Chaos), the mode's doors are shuffled
//first (rndERShuffle); with Boss Rando (rndOptBR), the bosses (rndBRShuffle); with Instrument Randomization
//(rndOptIR), the instruments are in the pool. A shuffle is kept only if with everything it reaches every place the
//game's own doors do and the goal (rndEREverything: the doors), the items can be placed with what the doors and bosses
//let through (rndGenerate, with the room logic's reach) and the seed plays through (rndERPlay); else another is tried.
//Not with Archipelago
var tTry,tOk,tER,tBR,tIR,tBit,tGo,d,i;
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
  //the entrances and the bosses shuffled, and the items placed with them
  global.rndERMode=0
  global.rndBRMode=0
  global.rndIRMode=0
  tER=global.rndOptER
  tBR=global.rndOptBR
  tIR=global.rndOptIR
  if tER>0 or tBR>0 or tIR>0
  {
    if rndERLoad()=0
    {
      show_message("Randomizer: Entrance Rando, Boss Rando and Instrument Randomization need the mod's room logic data (data\rndER.txt), which isn't there or doesn't fit this build. The entrances, the bosses and the instruments are left as they are.")
      tER=0
      tBR=0
      tIR=0
    }
  }
  if tER>0 or tBR>0 or tIR>0
  {
    tBit=1
    if tER=2 {tBit=2}
    else if tER=3 {tBit=4}
    global.rndIRMode=tIR
    for(tTry=0;tTry<60 and tOk=0;tTry+=1)
    {
      random_set_seed(global.rndSeed+tTry*7919)
      io_handle()
      tGo=1
      if tER>0 {tGo=rndERShuffle(tBit)}
      else {for(d=0;d<global.rndEDN;d+=1) {global.rndERPart[d]=-1}}
      if tGo=1
      {
        if tBR>0 {rndBRShuffle()}
        if tER>0 {io_handle(); tGo=rndEREverything()}
      }
      if tGo=1
      {
        global.rndReach=1
        if rndGenerate()=1 {tOk=rndERPlay()}
        global.rndReach=0
      }
    }
    rndERFree()
    if tOk=1
    {
      global.rndERMode=tER
      global.rndBRMode=tBR
      if tER>0 {rndERMapBuild()}
    }
    else
    {
      for(i=0;i<global.rndBossN;i+=1) {global.rndBRFight[i]=i}
      global.rndIRMode=0
      show_message("Randomizer: no shuffle of the entrances, bosses and instruments worked out for seed "+string(global.rndSeed)+" (60 were tried). They're left as they are.")
    }
  }
  if tOk=0
  {
    for(tTry=0;tTry<20 and tOk=0;tTry+=1)
    {
      random_set_seed(global.rndSeed+tTry*7919)
      tOk=rndGenerate()
    }
  }
  if tOk=0
  {
    show_message("Randomizer: the items couldn't be placed for seed "+string(global.rndSeed)+" (its logic.txt asks for more than the locations allow). They're left in their own places.")
    rndVanillaPlace()
  }
  if global.rndOptShops=1 {rndShopShuffle()}
  else
  {
    global.rndEShopStr=""
    rndShopFromString()
  }
}
global.rndActive=1
global.rndWon=0
//jumping: the player has it from the start (it isn't one of the items)
global.rndOwn[0]=1
rndAbilApply()
if global.rndAP=0 and global.rndOptLog=1 {rndLog()}
randomize()
//Central City - North, in front of the door from Greatest Stretch, not paused (the intro paused the game, and its scene
//doesn't run past the story)
global.newMapX=608
global.newMapY=320
global.gamePaused=false
room_goto(rCCity_NorthA)
