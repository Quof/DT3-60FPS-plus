//Randomizer: the mod's version of the game's abilSetRemove, which runs in its place (one of the scripts a mod can
//replace: Mods\README.txt). It notes the room whose code takes the player's abilities away (argument0 1: the CHAOS
//Warship's and Warship Z's rooms, each Nightmare Gate's and Gate 6's gate room...), so the roomStart hook keeps them
//away only while the player stays in that room's area (rndAbilHeldRoom). Then the game's own script does the rest: this
//version stands aside for the call (global.modOvr), so it doesn't call itself. "abilSetRemove (" with the space is the
//game's script: the mod loader makes "name(" a call of the mod's own (scrModFixCode)
var tOvr;
if argument0=1 {global.rndAbilHeldRoom=room}
tOvr=global.modOvr[abilSetRemove]
global.modOvr[abilSetRemove]=-1
abilSetRemove (argument0)
global.modOvr[abilSetRemove]=tOvr
