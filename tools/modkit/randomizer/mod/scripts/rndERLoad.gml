//Randomizer: the entrance randomizer's tables (the mod's data\rndER.txt, written by rndgen from the room logic: the
//rooms' ways through, the exits, the events, the doors' ends; tools\modkit\randomizer\roomlogic\erflat.py says what each
//is), read once into global.rndE*. Returns 1, or 0 when the file isn't there or doesn't read right
var f,p,i,j,k,n,v,tDir;
if variable_global_exists("rndELoaded") {if global.rndELoaded=1 {return 1}}
p=""
for(i=0;i<global.modCount;i+=1)
{
  tDir=global.modDir+global.modFolder[i]+"\data\rndER.txt"
  if file_exists(tDir) {p=tDir; break}
}
if p="" {return 0}
f=file_text_open_read(p)
if rndERReadS(f)!="RNDER" {file_text_close(f); return 0}
if rndERRead(f)!=2 {file_text_close(f); return 0}
global.rndEHash=rndERReadS(f)
//the carried states (rb, water, crystal1-3): each one's number of values, its place in a state's number, whether it's
//kept within some rooms (the Forest Palace's crystals: one more value outside them, parked)
global.rndEGN=rndERRead(f)
global.rndEScN=0
for(i=0;i<global.rndEGN;i+=1)
{
  global.rndEGVals[i]=rndERRead(f)
  global.rndEGMult[i]=rndERRead(f)
  global.rndEGScoped[i]=rndERRead(f)
  if global.rndEGScoped[i]=1 {global.rndESc[global.rndEScN]=i; global.rndEScN+=1}
}
//(the parked values' numbers: each scoped group's values, the parked one too)
global.rndEParkN=1
for(i=0;i<global.rndEScN;i+=1) {global.rndEParkN*=global.rndEGVals[global.rndESc[i]]}
global.rndEStartGs=rndERRead(f)
global.rndEGsN=rndERRead(f)
global.rndEKeyBase=rndERRead(f)
global.rndEEvBase=rndERRead(f)
//rooms: name, what the spoiler log calls it, area, in the scope, carried groups, resets, its boss fight
global.rndERN=rndERRead(f)
for(i=0;i<global.rndERN;i+=1)
{
  global.rndERName[i]=rndERReadS(f)
  global.rndERLabel[i]=rndERReadS(f)
  global.rndERArea[i]=rndERRead(f)
  global.rndERScope[i]=rndERRead(f)
  global.rndERCarN[i]=rndERRead(f)
  for(j=0;j<global.rndERCarN[i];j+=1) {global.rndERCar[i,j]=rndERRead(f)}
  global.rndERResN[i]=rndERRead(f)
  for(j=0;j<global.rndERResN[i];j+=1) {global.rndERResG[i,j]=rndERRead(f); global.rndERResV[i,j]=rndERRead(f)}
  global.rndERBossF[i]=rndERRead(f)
  global.rndERBossC[i]=rndERRead(f)
}
//entries (ways into rooms): room, x, y, their ways
global.rndEEN=rndERRead(f)
for(i=0;i<global.rndEEN;i+=1)
{
  global.rndEERoom[i]=rndERRead(f)
  global.rndEEX[i]=rndERRead(f)
  global.rndEEY[i]=rndERRead(f)
  global.rndEEWayF[i]=rndERRead(f)
  global.rndEEWayC[i]=rndERRead(f)
}
//ways (an entry in one state of its room's own carried groups): its rows
global.rndEWN=rndERRead(f)
for(i=0;i<global.rndEWN;i+=1)
{
  global.rndEWSt[i]=rndERRead(f)
  global.rndEWRowF[i]=rndERRead(f)
  global.rndEWRowC[i]=rndERRead(f)
}
//rows: 1 an exit (its number, the state it's left in), 2 a place (rndData's location), 3 a spot (its event); what it takes
global.rndEQN=rndERRead(f)
for(i=0;i<global.rndEQN;i+=1)
{
  global.rndEQKind[i]=rndERRead(f)
  global.rndEQTgt[i]=rndERRead(f)
  global.rndEQLeave[i]=rndERRead(f)
  global.rndEQAltF[i]=rndERRead(f)
  global.rndEQAltC[i]=rndERRead(f)
}
//alternatives: their requirements; requirements: a number (an item rndProgOf has, a key KEY_BASE+objectNum, an event
//EV_BASE+event) and how many
global.rndEAN=rndERRead(f)
for(i=0;i<global.rndEAN;i+=1) {global.rndEAReqF[i]=rndERRead(f); global.rndEAReqC[i]=rndERRead(f)}
global.rndEKN=rndERRead(f)
for(i=0;i<global.rndEKN;i+=1) {global.rndEKIx[i]=rndERRead(f); global.rndEKC[i]=rndERRead(f)}
//exits: room, where it is, where it leads (an entry; one that goes by a group: one a value), what going through takes
//on top, its door's end (-1: none)
global.rndEXN=rndERRead(f)
for(i=0;i<global.rndEXN;i+=1)
{
  global.rndEXRoom[i]=rndERRead(f)
  global.rndEXX[i]=rndERRead(f)
  global.rndEXY[i]=rndERRead(f)
  global.rndEXDest[i]=rndERRead(f)
  global.rndEXSg[i]=rndERRead(f)
  global.rndEXSdN[i]=rndERRead(f)
  for(j=0;j<global.rndEXSdN[i];j+=1) {global.rndEXSd[i,j]=rndERRead(f)}
  global.rndEXExF[i]=rndERRead(f)
  global.rndEXExC[i]=rndERRead(f)
  global.rndEXEnd[i]=rndERRead(f)
}
//events: their ways (1 a room got into, 2 an area: which; what else it takes; its mode: 0 always, 1 only without
//Instrument Randomization, 2 only with it: rndERRun)
global.rndEVN=rndERRead(f)
for(i=0;i<global.rndEVN;i+=1)
{
  global.rndEVWayN[i]=rndERRead(f)
  for(j=0;j<global.rndEVWayN[i];j+=1)
  {
    global.rndEVKind[i,j]=rndERRead(f)
    global.rndEVWhat[i,j]=rndERRead(f)
    global.rndEVAltF[i,j]=rndERRead(f)
    global.rndEVAltC[i,j]=rndERRead(f)
    global.rndEVMode[i,j]=rndERRead(f)
  }
}
//the goal: the events and rooms the shuffle has to reach with everything
global.rndEGoalEvN=rndERRead(f)
for(i=0;i<global.rndEGoalEvN;i+=1) {global.rndEGoalEv[i]=rndERRead(f)}
global.rndEGoalRmN=rndERRead(f)
for(i=0;i<global.rndEGoalRmN;i+=1) {global.rndEGoalRm[i]=rndERRead(f)}
//the doors' ends: exit, way back in, the modes it's shuffled in (1 Gate Swap, 2 Overworld, 4 Chaos), the game's
//partner, its class (what the Metroid door in front of its exit needs: 0 none, 1 any weapon, 2 missiles; the shuffle
//pairs only ends of one class, so the player only comes in behind a Metroid door by going through one)
global.rndEDN=rndERRead(f)
for(i=0;i<global.rndEDN;i+=1)
{
  global.rndEDExit[i]=rndERRead(f)
  global.rndEDBack[i]=rndERRead(f)
  global.rndEDMode[i]=rndERRead(f)
  global.rndEDPair[i]=rndERRead(f)
  global.rndEDCls[i]=rndERRead(f)
}
global.rndEStart=rndERRead(f)
//each location: reached with everything through the game's own doors (a shuffle has to reach those too)
global.rndELocN=rndERRead(f)
for(i=0;i<global.rndELocN;i+=1) {global.rndEBase[i]=rndERRead(f)}
//everything: how many of each progression item there are, and every key (rndEREverything)
global.rndEHvN=rndERRead(f)
for(i=0;i<global.rndEHvN;i+=1) {global.rndEHvIx[i]=rndERRead(f); global.rndEHvC[i]=rndERRead(f)}
//with everything, from each entry: the exits and places it gets to (for making a shuffle)
for(i=0;i<global.rndEEN;i+=1)
{
  global.rndEOutN[i]=rndERRead(f)
  for(j=0;j<global.rndEOutN[i];j+=1) {global.rndEOut[i,j]=rndERRead(f)}
  global.rndELocsN[i]=rndERRead(f)
  for(j=0;j<global.rndELocsN[i];j+=1) {global.rndELocs[i,j]=rndERRead(f)}
}
//Boss Rando: each boss's fight's needs (its alternatives) and whether it's shuffled (the final boss isn't); each room's
//and exit's boss (its room, its via exit; -1: none). rndERTry takes the fight of the boss fought there (rndBRFight)
global.rndEBN=rndERRead(f)
for(i=0;i<global.rndEBN;i+=1)
{
  global.rndEBReqF[i]=rndERRead(f)
  global.rndEBReqC[i]=rndERRead(f)
  global.rndEBShuf[i]=rndERRead(f)
}
for(i=0;i<global.rndERN;i+=1) {global.rndERSlot[i]=rndERRead(f)}
for(i=0;i<global.rndEXN;i+=1) {global.rndEXSlot[i]=rndERRead(f)}
//the Access Gates: the Program Chips' requirement numbers (rndEChipBase+gate) and each room's gate (0 none): going into a
//gate's rooms from outside it takes its chip (rndERTry)
global.rndEChipBase=rndERRead(f)
for(i=0;i<global.rndERN;i+=1) {global.rndERGate[i]=rndERRead(f)}
v=rndERReadS(f)
file_text_close(f)
if v!="END" or global.rndELocN!=global.rndLocN or global.rndEBN!=global.rndBossN {return 0}
//the requirement numbers there are (items, keys, events)
global.rndEReqN=global.rndEEvBase+global.rndEVN
//each row's entry (a row belongs to one way of one entry: a row instance is row*rndEGsN+state)
for(i=0;i<global.rndEEN;i+=1)
{
  for(j=global.rndEEWayF[i];j<global.rndEEWayF[i]+global.rndEEWayC[i];j+=1)
  {
    for(k=global.rndEWRowF[j];k<global.rndEWRowF[j]+global.rndEWRowC[j];k+=1) {global.rndEQEntry[k]=i}
  }
}
//the areas there are (rooms' and events')
global.rndEAreaN=1
for(i=0;i<global.rndERN;i+=1) {global.rndEAreaN=max(global.rndEAreaN,global.rndERArea[i]+1)}
for(i=0;i<global.rndEVN;i+=1)
{
  for(j=0;j<global.rndEVWayN[i];j+=1) {if global.rndEVKind[i,j]=2 {global.rndEAreaN=max(global.rndEAreaN,global.rndEVWhat[i,j]+1)}}
}
//what working out a reach keeps (rndERReachStart) and making a shuffle (rndERShuffle). The grids (made when a reach
//starts, freed by rndERFree): each node reached (state, entry) and each row instance's filing (state, row: 0 never
//tried or nothing lacked yet, n>0 its nth filing, -1 gone through); a filed row instance's "one more is all"
//requirements (rndRSing: row instance -> a string "ix,")
global.rndRGSeen=-1
global.rndRGQ=-1
global.rndRSing=ds_map_create()
global.rndRQueue=ds_queue_create()
global.rndRCross=ds_list_create()
global.rndREvNew=ds_list_create()
global.rndRLk1=ds_list_create()
global.rndRLk2=ds_list_create()
global.rndRLk3=ds_list_create()
global.rndRLk4=ds_list_create()
global.rndRLkX=ds_list_create()
for(i=0;i<global.rndEReqN;i+=1)
{
  global.rndRWait[i]=ds_list_create()
  global.rndRWaitG[i]=ds_list_create()
  global.rndRSingle[i]=0
  global.rndGHave[i]=0
}
global.rndSFront=ds_list_create()
global.rndSStack=ds_stack_create()
global.rndSLStack=ds_stack_create()
global.rndSStamp=0
global.rndSLStamp=0
global.rndSLE=0
global.rndSLF=0
global.rndSLP=0
for(i=0;i<global.rndEEN;i+=1) {global.rndSSeen[i]=0; global.rndSLVis[i]=0}
for(i=0;i<global.rndERN;i+=1) {global.rndSRoom[i]=0; global.rndRRoomIn[i]=0}
for(i=0;i<global.rndEAreaN;i+=1) {global.rndRAreaIn[i]=0}
for(i=0;i<global.rndELocN;i+=1) {global.rndSPlace[i]=0; global.rndRPlace[i]=0}
for(i=0;i<global.rndEDN;i+=1)
{
  global.rndSFrontAt[i]=0
  global.rndSCov[i]=0
  global.rndSInPool[i]=0
  global.rndSEnds[i]=0
  global.rndERPart[i]=-1
}
for(i=0;i<global.rndEParkN;i+=1) {global.rndRParked[i]=0}
global.rndELoaded=1
return 1
