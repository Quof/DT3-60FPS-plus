bCanDealDamage=true
damageType="NORMAL"

maxAtkId=0
atkId=0
atkIdTime=0
stunTime=1
bCanHitSwitch=1
bCanPierce=0
weaponRehitTime=20
initFireDir=oPlayer1.image_xscale
//60fps change (added): _speed/_direction/_hspeed/_vspeed stand in for GameMaker's built-in speed/direction/hspeed/
//vspeed, which every instance has from the start (0 until it's set). An attack that reads one before setting it (Arthur's
//first lightning bolt in the War Room, the Dragoon ship's homing needle) crashed with "Unknown variable"; they start at 0,
//as the built-ins did (oDamagableBase's Create does the same; the creator's values, set after this, still apply)
if !variable_local_exists("_speed") {_speed=0}
if !variable_local_exists("_direction") {_direction=0}
if !variable_local_exists("_hspeed") {_hspeed=0}
if !variable_local_exists("_vspeed") {_vspeed=0}
//spsp ns glove
gloveBoost=0 //mods change: moved here from after bCanPierce=0 (the lines in between don't use it), so this is DT3+'s event with the mod's line added at the end, which the mod adds after it instead of replacing it (quicker to load)
