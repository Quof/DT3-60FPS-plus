//Randomizer: whether Gate 6's (Prototype Game) two game ability sets work where the player is: in Gate 6 (as the game's
//own abilSetRemove has it), and in The Executive's fight (boss type 64), which the game's own fight gives them for
if string_copy(room_get_name(room),1,6)="rGame6" {return true}
if global.rndFight>=0 {if global.rndBossType[global.rndFight]=64 {return true}}
return false
