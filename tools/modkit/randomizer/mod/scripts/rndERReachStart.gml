//Randomizer: the entrance randomizer's reach, started: what the items in global.rndGHave (their counts by rndProgOf's
//numbers, keys KEY_BASE+objectNum) reach from the start with the doors as global.rndERPart has them (an end's new
//partner; -1: the game's own). As in roomlogic\erflat.py's Reach: a node is an entry and a state of the carried groups;
//a row of a way through a room that can't be gone through yet waits under each requirement it lacks (global.rndRWait)
//and is tried again once one comes (rndERAdd, rndERRun's events). Afterwards: global.rndRPlace (the locations reached),
//rndRRoomIn (the rooms), rndGHave's events, rndRSingle (how many waiting rows one more of a requirement lets through:
//rndGenerate's choice of item)
var i;
if global.rndRGQ<0
{
  global.rndRGSeen=ds_grid_create(global.rndEGsN,global.rndEEN)
  global.rndRGQ=ds_grid_create(global.rndEGsN,global.rndEQN)
}
ds_grid_clear(global.rndRGSeen,0)
ds_grid_clear(global.rndRGQ,0)
ds_map_clear(global.rndRSing)
ds_queue_clear(global.rndRQueue)
ds_list_clear(global.rndRCross)
ds_list_clear(global.rndREvNew)
for(i=0;i<global.rndEReqN;i+=1)
{
  ds_list_clear(global.rndRWait[i])
  ds_list_clear(global.rndRWaitG[i])
  global.rndRSingle[i]=0
}
for(i=global.rndEEvBase;i<global.rndEReqN;i+=1) {global.rndGHave[i]=0}
for(i=0;i<global.rndERN;i+=1) {global.rndRRoomIn[i]=0}
for(i=0;i<global.rndEAreaN;i+=1) {global.rndRAreaIn[i]=0}
for(i=0;i<global.rndELocN;i+=1) {global.rndRPlace[i]=0}
global.rndRPlaceN=0
for(i=0;i<global.rndEParkN;i+=1) {global.rndRParked[i]=0}
//(the start is outside the Forest Palace: its crystals parked; their values as a new game starts are a parked set)
global.rndRParked[rndERScoped(global.rndEStartGs)]=1
rndERGo(global.rndEStart,rndERPark(global.rndEStartGs))
rndERRun()
