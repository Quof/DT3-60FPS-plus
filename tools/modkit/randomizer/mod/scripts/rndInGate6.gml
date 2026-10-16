//Randomizer: whether Gate 6's (Prototype Game) two game ability sets work where the player is: in Gate 6 (as the game's
//own abilSetRemove has it), in Nightmare Gate G (whose own sets they are: its first room's code puts them on, and a
//Randomizer game keeps every other set found working there too, the roomStart hook), and in The Executive's fight
//(rndExecFight), which the game's own fight gives them for
var tName;
tName=room_get_name(room)
if string_copy(tName,1,6)="rGame6" {return true}
if string_copy(tName,1,10)="rExtGateG_" {return true}
if rndExecFight() {return true}
return false
