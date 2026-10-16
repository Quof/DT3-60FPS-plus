//Randomizer: the trackers' state, the mod's tracker\state.js (tracker\checks.html and tracker\items.html read it every
//second): this build, the seed with its options and shuffles, the locations taken, what the player has (the abilities,
//keys, instruments, equipment, the game's own counts of each upgrade, the Program Chips), the locked doors opened, the
//bosses beaten (the Abomination: gateHProg) and the room they're in.
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
if global.rndERMode>0 {s+=",`erpart`:`"+rndERString(global.rndEDN)+"`,`erfollow`:"+string(global.rndERFollow)}
if global.rndBRMode>0 {s+=",`brfight`:`"+rndBRString(0)+"`"}
s+=",`got`:`"+global.rndGot+"`,`own`:`"+rndOwnString()+"`,`keys`:`"+global.rndKeyOwn+"`,`doors`:`"+global.lockedDoor+"`"
s+=",`boss`:`"+global.rndBossDone+"`"
s+=",`gate`:`"+global.eGateProg+"`,`gateh`:"+string(global.gateHProg)+",`equip`:`"+global.equipItems+"`"
s+=",`hp`:`"+global.heartPiece+"`,`hc`:`"+global.fullHeartContainer+"`,`he`:`"+global.heartEnergy+"`,`aq`:`"+global.arrowQuiver+"`"
s+=",`mp`:`"+global.missilePack+"`,`gp`:`"+global.kiEnergy+"`,`au`:`"+global.airUpgrade+"`,`wb`:`"+global.walletBoost+"`"
s+=",`sp`:`"+global.apBoost+"`,`wl`:`"+global.weaponLevels+"`,`bu`:`"+global.weaponBoosts+"`"
s+=",`spring`:"+string(global.metSpringBall)+",`xcharge`:"+string(global.hasBoostedXCharge)+",`finder`:"+string(global.itemFinder)
s+=",`chipmode`:"+string(global.rndChipMode)+",`chips`:`"+global.rndChipOwn+"`"
s+="};if(window.DT3_onState)window.DT3_onState();"
s=string_replace_all(s,"`",chr(34))
f=file_text_open_write(global.rndTrackDir+"state.js")
file_text_write_string(f,s)
file_text_writeln(f)
file_text_close(f)
