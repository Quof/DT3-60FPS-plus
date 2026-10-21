//Randomizer: its variables, off (the init hook: the title screen, a new game, a save being loaded). Its data (rndData:
//the locations, items, shops and bosses) is set up once
var i;
if !variable_global_exists("rndLocN")
{
  rndData()
  rndOneWayData() //(the one way exits that show an arrow: their ONE WAY signs, the roomStart hook)
  rndVisitData() //(the room logic's ways into rooms, by where they put the player: rndVisitArrive)
  rndLocData() //(each room's area: rndLocAhead)
  global.rndLocPre=0
  global.rndLocOld=0
  //each item's progression item (rndProgOf; -1: none)
  for(i=0;i<global.rndItemN;i+=1) {global.rndItemProg[i]=rndProgOf(global.rndItemKind[i],global.rndItemParam[i])}
  //each location's layer in the placement (rndGenerate; -1 till a new game's placed its items)
  for(i=0;i<global.rndLocN;i+=1) {global.rndGLayer[i]=-1}
  global.rndNextSeed=-1
  //the new game's options (oRndOptions), as last chosen (DT3Options.dts, section Randomizer): Guarantee Early Weapons
  //(rndGenerate), Ability Spread (0 Near, 1 Normal, 2 Far: rndGenerate), the equipment shops shuffled, Entrance Rando
  //(0 Off, 1 Gate Swap, 2 Area, 3 Chaos), Boss Rando (0 Off, 1 On), Instrument Randomization (0 Off, 1 On) and the
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
  //(Traps: how long they last, 0 Off, 2, 5 or 10 minutes: rndSnareApply, rndSnareTime; kept before as 0 Off, 1 On, 5
  //minutes)
  global.rndOptSnare=ini_read_real("Randomizer","trapmins",5*ini_read_real("Randomizer","traps",0))
  global.rndOptSkipTD=ini_read_real("Randomizer","skiptd",0) //(Skip Tower Defense: 0 Off, 1 On, rndSkipTDApply)
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
//the trap items (the option Traps: rndSnareApply, rndSnareSpring): on in this game or not and which (rndSnareSet: 2
//this build's, 1 a save's from before the Wind Orb), each trap's time left (30fps ticks: Darkness 1, Rocketeer 2,
//Achilles 4, Wind Orb 5; rndSnareTime each, the option's 2, 5 or 10 minutes), a Teleport Trap waiting to take the
//player (rndSnarePend) or having just done it (rndSnareArrive), the ways into rooms kept for it (rndSnareHist*), and each
//trap's name on the HUD (the drawHUD hook). An Archipelago world's time for them: rndApSessTrapMins (the client's)
var k;
global.rndSnareMode=0
global.rndSnareSet=2
global.rndSnareTime=9000
for(k=0;k<=5;k+=1) {global.rndSnareT[k]=0}
global.rndSnarePend=0
global.rndSnareArrive=0
global.rndSnareHistN=0
global.rndSnareHUD[1]="Darkness"; global.rndSnareHUD[2]="Rocketeers"; global.rndSnareHUD[3]=""; global.rndSnareHUD[4]="Achilles"
global.rndSnareHUD[5]="Wind Orb"
global.rndApSessTrapMins=5
//the trackers' state (tracker\state.js) to be written again: oRndWatcher writes it (rndTrackWrite)
global.rndTrackDirty=0
//Archipelago: this game is one (rndAP), its seed line ("seed|<seed>|<slot>": the client's files must start with it),
//how many received items it has given, its own deaths sent (DeathLink); the client's session (rndApReadSession)
global.rndAP=0
global.rndApSeedLine=""
global.rndApRecv=0
global.rndApNMSeen=1 //(rndApStart: 0 till rndApItems has looked for Nightmare abilities received before and not given)
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
//the entrance randomizer: off, or the mode the game's doors are shuffled in (1 Gate Swap, 2 Area, 3 Chaos; a save's 2
//from before the area mode, Overworld, keeps its own shuffle: its
//doors in the game, rndERMapBuild and rndERApplyExit). Boss Rando: off or on, and the boss fought at each boss's place
//(rndBRFight: its own when off; rndBossStart). Instrument Randomization: off (each instrument is its gate's reward) or
//on (the instruments are in the pool). rndReach: rndGenerate works out what the items reach from the rooms
//(rndERReachStart: while a new game's seed with any of them is made)
global.rndERMode=0
//(the Check Tracker's Entrance Tracker's: the doors' ends found, the ways in visited and the exits that aren't doors'
//ends gone through, a character each, and the room before this one's number in the door data: rndERSeenArrive; the
//ways in visited in every game, rndVisitArrive)
global.rndERSeen=""
global.rndERVisit=""
global.rndERExit=""
global.rndERPrevRoom=-1
//(the way in the player is in this room by and the states they came in with, rndVisitArrive)
global.rndVisitIn=-1
global.rndVisitCarry=""
//the vending machines' hints (oVendingMachine): how many bought (the next one's price: rndHintCost), and the locations
//hinted (a character each)
global.rndHintN=0
global.rndHinted=string_repeat("0",global.rndLocN)
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
global.rndCharSeen=0 //(the character the player was the frame before, oRndWatcher: a room whose code switches it as they come in switches back, the roomStart hook)
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
global.rndPrevRoom=-1 //where they came into the room before it (-1: none since the game was started or loaded): the way back
global.rndPrevX=0     //from a fight that would start again at once where they came into its room (rndBossStart)
global.rndPrevY=0
global.rndFightGrace=-1 //the boss place whose fight was just given up: it doesn't start again till the player's out of
global.rndFightGraceNew=0 //where it starts, or in another room (rndBossEnd, oRndWatcher, the roomStart hook)
global.rndFightLoseRoom=rCCity_NorthA
global.rndFightLoseX=608
global.rndFightLoseY=320
global.rndFightRetX=0
global.rndFightRetY=0
for(i=0;i<17;i+=1) {global.rndOwn[i]=0} //(0-11 the abilities and sets, 12 the Varia Suit: rndProgOf; 13-16 the Nightmare abilities, rndNM)
global.rndKeyOwn=string_repeat("0",50) //the doors (objectNum) whose keys have been found
global.rndGot=string_repeat("0",global.rndLocN)
//the enemy traps beaten (rndData's rndTrap*: each one's room and object, traps.py), and the one going in the room (-1:
//none)
global.rndTrapDone=string_repeat("0",global.rndTrapN)
global.rndTrapActive=-1
global.rndPlace=""
global.rndBossDone=string_repeat("0",global.rndBossN)
global.rndBossSeen=string_repeat("0",global.rndBossN) //(the places whose fight has been started: rndBossPreview, rndBossStart)
global.rndGateReach="00000000" //(the Nightmare Gates whose boss's room the player has been in: their first room's way straight to it, the roomStart hook)
//a boss's AP to give once the player is back from its fight (rndBossAPAward: -1 none, -2 the Abomination), and whether
//the Abomination's beating has been seen (oRndWatcher: as if so till a new game or a load says otherwise)
global.rndBossAPPending=-1
global.rndAbomAPSeen=1
global.rndEShopStr=""
for(i=0;i<global.rndEShopN;i+=1) {global.rndEShopNew[i]=global.rndEShopEquip[i]}
//the Program Chips (Chip Randomizer: rndChipApply puts them in the items or not), which the player has (a character a
//gate: Access Gate 1-6), and what takes them (rndChipPortals: 1 each Access Gate's portal and the Nightmare Gate portal
//beside it, a new game's; 0 a portal into an Access Gate's rooms, that gate's chip, a game made before: rndPortalChip)
rndChipApply(0)
global.rndChipOwn=string_repeat("1",global.rndChipN)
global.rndChipPortals=1
global.rndApSessChips=0
global.rndApSessChipPortals=0
//Skip Tower Defense: off till a new game or a save has it on (rndSkipTDApply: tower defense's rewards in the logic)
rndSkipTDApply(0)
global.rndApSessSkipTD=0
//the location (global.location) of the room the player was last in: coming into Gate 5 (location 49) from outside it
//sets its checkpoint (the roomStart hook)
global.rndLastLoc=-1
//1 while a Highlands room is being made as before the CHAOS Warship's attack (rndHLEnter: gameProgress 4935 till the
//roomStart hook puts the endgame's back)
global.rndHLProg=0
