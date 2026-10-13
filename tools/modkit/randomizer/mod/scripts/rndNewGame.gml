//Randomizer: a new game (the roomStart hook, in the intro room). The world is the game's endgame world (rndWorld: every
//area open), without the CHAOS invasion, and with the instrument quest and the Abomination still to do; the player has
//only walking (initGameVars set everything else to none). The items are placed (rndGenerate), the spoiler log written
//(rndLog), and the game starts in the first room, where the intro would have taken the player
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
global.rndActive=1
global.rndWon=0
rndAbilApply()
rndLog()
randomize()
room_goto(rMain_1)
