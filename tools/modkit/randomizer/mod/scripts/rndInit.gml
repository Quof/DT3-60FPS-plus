//Randomizer: its variables, off (the init hook: the title screen, a new game, a save being loaded). Its data (rndData:
//the locations, items, shops and bosses) is set up once
var i,p,s;
if !variable_global_exists("rndLocN")
{
  rndData()
  //each location's requirements (rndData's strings: a digit for each of the first 12 progression items, then two for
  //keys) as numbers, and each item's progression item (-1: none)
  for(i=0;i<global.rndLocN;i+=1)
  {
    s=global.rndLocReq[i]
    for(p=0;p<12;p+=1) {global.rndReqV[i,p]=real(string_char_at(s,p+1))}
    global.rndReqV[i,12]=real(string_copy(s,13,2))
  }
  for(i=0;i<global.rndItemN;i+=1) {global.rndItemProg[i]=rndProgOf(global.rndItemKind[i],global.rndItemParam[i])}
  global.rndNextSeed=-1
  //Archipelago: the next new game is an Archipelago game (the title screen's code 'ap'), and the folder where the game
  //and the DT3+ Client trade files: %LOCALAPPDATA%\DT3PlusArchipelago\, made if it isn't there
  global.rndApNext=0
  global.rndApPath=environment_get_variable("LOCALAPPDATA")
  if global.rndApPath="" {global.rndApPath=working_directory}
  global.rndApPath+="\DT3PlusArchipelago\"
  if !directory_exists(global.rndApPath) {directory_create(global.rndApPath)}
}
global.rndMsgQuiet=0
//Archipelago: this game is one (rndAP), its seed line ("seed|<seed>|<slot>": the client's files must start with it),
//how many received items it has given, its own deaths sent (DeathLink); the client's session (rndApReadSession)
global.rndAP=0
global.rndApSeedLine=""
global.rndApRecv=0
global.rndApDeaths=0
global.rndApSession=""
global.rndApSessDeath=0
global.rndApShopSeed=0
global.rndApDeathLink=0
global.rndApDeathSeen=0
global.rndApDeathGot=0
global.rndApDeathCause=""
global.rndApDying=0
global.rndApPollT=0
global.rndApLocLoaded=0
global.rndVersion=1
global.rndActive=0
global.rndSeed=0
global.rndWon=0
global.rndWorldProg=5641 //past every story event (5640 is the Hexor fight's)
global.rndFight=-1
global.rndRoomBoss=-1 //the boss whose room the player is in, not beaten yet (the roomStart hook), or -1
global.rndRoomSide=0
global.rndFightLastX=0
global.rndFightLastY=0
global.rndFightRetRoom=rMain_1
global.rndInRoom=rMain_1 //where the player came into the room they're in (the roomStart hook): rndBossStart's way back
global.rndInX=240
global.rndInY=2048
global.rndFightLoseRoom=rMain_1
global.rndFightLoseX=240
global.rndFightLoseY=2048
global.rndFightRetX=0
global.rndFightRetY=0
for(i=0;i<12;i+=1) {global.rndOwn[i]=0}
global.rndKeyOwn=string_repeat("0",50) //the doors (objectNum) whose keys have been found
global.rndGot=string_repeat("0",global.rndLocN)
global.rndPlace=""
global.rndBossDone=string_repeat("0",global.rndBossN)
global.rndEShopStr=""
for(i=0;i<global.rndEShopN;i+=1) {global.rndEShopNew[i]=global.rndEShopEquip[i]}
