//Randomizer: Nightmare Gate H's place. The gate isn't in the Randomizer: its access gate (in the destroyed Hidden
//Village, there once the other seven gates' instruments are taken) comes here instead (the roomStart hook), a room left
//blank for what takes the gate's place later. Coming here counts as beating the gate: its place in eGateProg goes to 8,
//as the gate's last room (rExtGateH_8) has it, so the Sacred Temple (this room's exit, where that room's goes) gives its
//instrument, the Thunder Drum
locationCheck(108)
global.mapTeleport=0

var instrProg;
instrProg=string_char_at(global.eGateProg,8)
if instrProg="0"
{
  var tNewString;
  tNewString=string_delete(global.eGateProg,8,1)
  tNewString=string_insert("8",tNewString,8)
  global.eGateProg=tNewString
}

var tempMplay;
tempMplay=findMusic(906)
playMusic(tempMplay,0,0)
