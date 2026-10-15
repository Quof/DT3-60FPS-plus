//Randomizer: its variables, off (the init hook: the title screen, a new game, a save being loaded). Its data (rndData:
//the locations, items, shops and bosses) is set up once
var i;
if !variable_global_exists("rndLocN")
{
  rndData()
  //each item's progression item (rndProgOf; -1: none)
  for(i=0;i<global.rndItemN;i+=1) {global.rndItemProg[i]=rndProgOf(global.rndItemKind[i],global.rndItemParam[i])}
  //each location's layer in the placement (rndGenerate; -1 till a new game's placed its items)
  for(i=0;i<global.rndLocN;i+=1) {global.rndGLayer[i]=-1}
  global.rndNextSeed=-1
  //the new game's options (oRndOptions), as last chosen (DT3Options.dts, section Randomizer): Guarantee Early Weapons
  //(rndGenerate), Ability Spread (0 Near, 1 Normal, 2 Far: rndGenerate), the equipment shops shuffled, Entrance Rando
  //(0 Off, 1 Gate Swap, 2 Overworld, 3 Chaos), Boss Rando (0 Off, 1 On), Instrument Randomization (0 Off, 1 On) and the
  //spoiler log written (rndNewGame)
  ini_open(global.saveDir+"DT3Options.dts")
  global.rndOptWeapons=ini_read_real("Randomizer","weapons",0)
  global.rndOptSpread=ini_read_real("Randomizer","spread",1)
  global.rndOptShops=ini_read_real("Randomizer","shops",1)
  global.rndOptER=ini_read_real("Randomizer","er",0)
  global.rndOptBR=ini_read_real("Randomizer","br",0)
  global.rndOptIR=ini_read_real("Randomizer","ir",0)
  global.rndOptLog=ini_read_real("Randomizer","log",1)
  global.rndOptChips=ini_read_real("Randomizer","chips",0) //(Chip Randomizer: 0 Off, 1 On)
  ini_close()
  //Archipelago: the next new game is an Archipelago game (the title screen's code 'ap'), and the folder where the game
  //and the DT3+ Client trade files: %LOCALAPPDATA%\DT3PlusArchipelago\, made if it isn't there
  global.rndApNext=0
  global.rndApPath=environment_get_variable("LOCALAPPDATA")
  if global.rndApPath="" {global.rndApPath=working_directory}
  global.rndApPath+="\DT3PlusArchipelago\"
  if !directory_exists(global.rndApPath) {directory_create(global.rndApPath)}
}
global.rndMsgQuiet=0
//the trackers' state (tracker\state.js) to be written again: oRndWatcher writes it (rndTrackWrite)
global.rndTrackDirty=0
//Archipelago: this game is one (rndAP), its seed line ("seed|<seed>|<slot>": the client's files must start with it),
//how many received items it has given, its own deaths sent (DeathLink); the client's session (rndApReadSession)
global.rndAP=0
global.rndApSeedLine=""
global.rndApRecv=0
global.rndApDeaths=0
global.rndApSession=""
global.rndApSessDeath=0
global.rndApShopSeed=0
global.rndApSessShops=1
global.rndApSessER=0
global.rndApSessERHash=""
global.rndApSessERPart=""
global.rndApSessBR=0
global.rndApSessBRFight=""
global.rndApSessBRTypes=""
global.rndApSessIR=0
global.rndApDeathLink=0
global.rndApDeathSeen=0
global.rndApDeathGot=0
global.rndApDeathCause=""
global.rndApDying=0
global.rndApPollT=0
global.rndApLocLoaded=0
global.rndVersion=2
global.rndActive=0
//the entrance randomizer: off, or the mode the game's doors are shuffled in (1 Gate Swap, 2 Overworld, 3 Chaos: its
//doors in the game, rndERMapBuild and rndERApplyExit). Boss Rando: off or on, and the boss fought at each boss's place
//(rndBRFight: its own when off; rndBossStart). Instrument Randomization: off (each instrument is its gate's reward) or
//on (the instruments are in the pool). rndReach: rndGenerate works out what the items reach from the rooms
//(rndERReachStart: while a new game's seed with any of them is made)
global.rndERMode=0
global.rndBRMode=0
global.rndIRMode=0
global.rndReach=0
for(i=0;i<global.rndBossN;i+=1) {global.rndBRFight[i]=i}
global.rndSeed=0
global.rndWon=0
global.rndWorldProg=5641 //past every story event (5640 is the Hexor fight's)
global.rndFight=-1
global.rndFightSlot=-1
//(a boss whose fight is several in a row, rndBossChain*: which of them is on, 0 its own; and the player's life and ammo
//in it, for the next one: rndBossNextLink)
global.rndFightLink=0
for(i=0;i<5;i+=1) {global.rndChainSt[i]=0}
global.rndCharLast=0 //(Jerry or Claire, whichever was played last: the roomStart hook switches back to them)
//(abilities a room took away: the room whose code did (the mod's abilSetRemove), the area they stay away in, and the
//ability sets picked before: the roomStart hook)
global.rndAbilHeldRoom=-1
global.rndAbilGroup=""
global.rndActSave[0]=0
global.rndActSave[1]=0
global.rndActReg[0]=0 //(each character's last set other than Gate 6's, for leaving Gate 6: rndPickSets)
global.rndActReg[1]=0
global.rndRoomWait=-1 //the CHAOS Warmaster's room before the Abomination is beaten (the roomStart hook, oRndWatcher)
global.rndRoomBoss=-1 //the boss whose room the player is in, not beaten yet (the roomStart hook), or -1
global.rndRoomSide=0
global.rndFightLastX=0
global.rndFightLastY=0
global.rndFightRetRoom=rCCity_NorthA
global.rndInRoom=rCCity_NorthA //where the player came into the room they're in (the roomStart hook): rndBossStart's way back
global.rndInX=608
global.rndInY=320
global.rndFightLoseRoom=rCCity_NorthA
global.rndFightLoseX=608
global.rndFightLoseY=320
global.rndFightRetX=0
global.rndFightRetY=0
for(i=0;i<13;i+=1) {global.rndOwn[i]=0} //(0-11 the abilities and sets, 12 the Varia Suit: rndProgOf)
global.rndKeyOwn=string_repeat("0",50) //the doors (objectNum) whose keys have been found
global.rndGot=string_repeat("0",global.rndLocN)
//the enemy traps beaten (rndData's rndTrap*: each one's room and object, traps.py), and the one going in the room (-1:
//none)
global.rndTrapDone=string_repeat("0",global.rndTrapN)
global.rndTrapActive=-1
global.rndPlace=""
global.rndBossDone=string_repeat("0",global.rndBossN)
global.rndBossSeen=string_repeat("0",global.rndBossN) //(the places whose fight has been started: rndBossPreview, rndBossStart)
//a boss's AP to give once the player is back from its fight (rndBossAPAward: -1 none, -2 the Abomination), and whether
//the Abomination's beating has been seen (oRndWatcher: as if so till a new game or a load says otherwise)
global.rndBossAPPending=-1
global.rndAbomAPSeen=1
global.rndEShopStr=""
for(i=0;i<global.rndEShopN;i+=1) {global.rndEShopNew[i]=global.rndEShopEquip[i]}
//the Program Chips (Chip Randomizer: rndChipApply puts them in the items or not), which the player has (a character a
//gate: Access Gate 1-6), the gate of the room they were last in (-1 not known yet: the roomStart hook turns them back
//at a gate they lack the chip of, rndGateBounce) and the gate a turning back is to be told for (rndLockMsg)
rndChipApply(0)
global.rndChipOwn=string_repeat("1",global.rndChipN)
global.rndLastGate=-1
global.rndLockMsg=0
global.rndApSessChips=0
