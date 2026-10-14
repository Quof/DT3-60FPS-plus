/*
mods change (added): runs room creation code from a patch (scrModRoomPatch: roomcode, roomcodeset) in an instance made
for it and taken out after, so what the code sets without global. or var (a room's code often keeps things in plain
variables) stays out of the instance running the patch, oGame.
argument0: the code's number (scrModTextAdd)
argument1: its scrModRunText mode
*/
var tD,tC,tM;
tC=argument0; tM=argument1
if tC<0 {exit}
tD=instance_create(0,0,global.modMarkObj)
with (tD) {scrModRunText(tC,tM)}
with (tD) {instance_destroy()}
