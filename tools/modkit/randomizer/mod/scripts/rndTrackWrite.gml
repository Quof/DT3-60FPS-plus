//Randomizer: the trackers' state, the mod's tracker\state.js (tracker\checks.html and tracker\items.html read it every
//second): this build, the seed with its options and shuffles, the locations taken, what the player has (the abilities,
//keys, instruments, equipment, the game's own counts of each upgrade, the Program Chips), the locked doors opened, the
//bosses beaten (the Abomination: gateHProg), the room they're in, the ways into rooms they've come in by and the
//vending machines' hints.
//Written when any of it has changed (global.rndTrackDirty: oRndWatcher); nothing when the mod has no tracker folder
var i,f,s;
if !variable_global_exists("rndTrackDir")
{
  global.rndTrackDir=""
  for(i=0;i<global.modCount;i+=1)
  {
    if file_exists(global.modDir+global.modFolder[i]+"\tracker\data.js") {global.rndTrackDir=global.modDir+global.modFolder[i]+"\tracker\"; break}
  }
}
if global.rndTrackDir="" {exit}
//(written with ` for the quotes, then made chr(34): its values are digits, letters and room names)
s="window.DT3_STATE={`v`:1,`build`:`"+global.rndBuildId+"`,`seed`:"+string(global.rndSeed)
s+=",`ap`:"+string(global.rndAP)+",`er`:"+string(global.rndERMode)+",`br`:"+string(global.rndBRMode)+",`ir`:"+string(global.rndIRMode)
s+=",`won`:"+string(global.rndWon)+",`room`:`"+room_get_name(room)+"`"
if global.rndERMode>0
{
  s+=",`erpart`:`"+rndERString(global.rndEDN)+"`,`erfollow`:"+string(global.rndERFollow)
  //(the Check Tracker's Entrance Tracker: the doors' ends found and the exits that aren't doors' ends gone through,
  //rndERSeenArrive)
  s+=",`erseen`:`"+global.rndERSeen+"`,`erexit`:`"+global.rndERExit+"`"
}
//(the ways into rooms the player has come in by, in every game: the Check Tracker counts what they get to as in logic,
//rndVisitArrive; and the Teleporting Stones activated, the main world's and each gate's: its ways there warp between
//them)
s+=",`ervisit`:`"+global.rndERVisit+"`"
//(and the way in they're in this room by, and the states they came in with: rndVisitArrive)
s+=",`erin`:"+string(global.rndVisitIn)
if global.rndVisitCarry!="" {s+=",`carry`:{"+global.rndVisitCarry+"}"}
s+=",`warps`:[`"+global.warpMain+"`,`"+global.warpGate1+"`,`"+global.warpGate2+"`,`"+global.warpGate3+"`,`"+global.warpGate4+"`,`"+global.warpGate5+"`,`"+global.warpGate6+"`]"
//(the vending machines' hints: each location hinted and what its hint named, rndHintName, without the quotes and
//backslashes the file's strings can't have)
var tHints,tN;
tHints=""
for(i=0;i<global.rndLocN;i+=1)
{
  if string_char_at(global.rndHinted,i+1)="1"
  {
    tN=string_replace_all(string_replace_all(string_replace_all(rndHintName(i),chr(34),"'"),"`","'"),"\","/")
    if tHints!="" {tHints+=","}
    tHints+="["+string(i)+",`"+tN+"`]"
  }
}
s+=",`hints`:["+tHints+"]"
if global.rndBRMode>0 {s+=",`brfight`:`"+rndBRString(0)+"`"}
s+=",`got`:`"+global.rndGot+"`,`own`:`"+rndOwnString()+"`,`keys`:`"+global.rndKeyOwn+"`,`doors`:`"+global.lockedDoor+"`"
s+=",`boss`:`"+global.rndBossDone+"`"
s+=",`gate`:`"+global.eGateProg+"`,`gateh`:"+string(global.gateHProg)+",`equip`:`"+global.equipItems+"`"
s+=",`hp`:`"+global.heartPiece+"`,`hc`:`"+global.fullHeartContainer+"`,`he`:`"+global.heartEnergy+"`,`aq`:`"+global.arrowQuiver+"`"
s+=",`mp`:`"+global.missilePack+"`,`gp`:`"+global.kiEnergy+"`,`au`:`"+global.airUpgrade+"`,`wb`:`"+global.walletBoost+"`"
s+=",`sp`:`"+global.apBoost+"`,`wl`:`"+global.weaponLevels+"`,`bu`:`"+global.weaponBoosts+"`"
s+=",`spring`:"+string(global.metSpringBall)+",`xcharge`:"+string(global.hasBoostedXCharge)+",`finder`:"+string(global.itemFinder)
s+=",`chipmode`:"+string(global.rndChipMode)+",`chips`:`"+global.rndChipOwn+"`,`chipportals`:"+string(global.rndChipPortals)
s+=",`skiptd`:"+string(global.rndSkipTD)
s+="};if(window.DT3_onState)window.DT3_onState();"
s=string_replace_all(s,"`",chr(34))
f=file_text_open_write(global.rndTrackDir+"state.js")
file_text_write_string(f,s)
file_text_writeln(f)
file_text_close(f)
