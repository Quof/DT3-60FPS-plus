//Randomizer: whether the game keeps saving off in a room (argument0: the room): its places that turn saving off as
//they're come into, till their own way out turns it back on. The Vault's shifting rooms (rVault_R_A turns it off; the
//way out, the pause menu's Teleport to rVault_16, back on), Hyrule's map encounters (back on on the map), the
//Abomination's rooms (back on in rAbomE) and Nightmare Gate H's
var n;
n=room_get_name(argument0)
if string_copy(n,1,9)="rVault_R_" {return 1}
if string_copy(n,1,9)="rLink2_En" {return 1}
if string_copy(n,1,5)="rAbom" {return 1}
if string_copy(n,1,10)="rExtGateH_" {return 1}
return 0
