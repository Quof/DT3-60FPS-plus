//Randomizer: the RPG level's buff (Gate 6's level, global.stJGame_C[1], 1-64) to the four base sets' damage (Link,
//Mega Man, Belmont, Samus: weapon tags 0-19 and 30-49) against Gate 6's enemies and bosses (affiliation 6, the
//Prototype Game's: Gate G's and The Executive too): 1x at level 1 up to 2x at level 64. Gate 6's own two sets (tags
//20-29 and 50-59), whose attacks grow with the level already, and anything else hit, 1x. The mod's takeDamage (the
//game's own, changed: rndgen.py SCRIPT_PATCHES) runs it as the enemy hit, with what hit it
//argument0: the attack that hit
var tTag,tLv;
if global.rndActive=0 {return 1}
if !variable_local_exists("affiliation") {return 1}
if affiliation!=6 {return 1}
tTag=argument0.weaponTag
if tTag<0 or tTag>=50 {return 1}
if tTag>=20 and tTag<30 {return 1}
tLv=global.stJGame_C[1]
if tLv<1 {tLv=1}
if tLv>64 {tLv=64}
return 1+(tLv-1)/63
