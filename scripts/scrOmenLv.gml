/*
dark omen change (added): a weapon level as it counts for damage and stun: 10 lower while the New Dark Omen is on
(scrOmenState). The level itself isn't changed, so a Weapon Level Upgrade picked up meanwhile counts as normal and there's
nothing to put back. Never below the starting level, 0 (initGameVars), so with it on every weapon does its level 0 damage.
argument0: the weapon level (global.stLink_Sword[0] etc.)
*/
//if global.omenActive=1 {return argument0-10}
if global.omenActive=1 {return max(0,argument0-10)} //dark omen change: no lower than the starting level
return argument0
