//Randomizer: the Access Gate a room is in (argument0: the room): 1-6 by its name's prefix (rndGatePrefix, the room
//logic's own: going into a gate's rooms from outside it takes its Program Chip), 0 none
var n,g;
n=room_get_name(argument0)
for(g=1;g<=global.rndChipN;g+=1)
{
  if string_copy(n,1,string_length(global.rndGatePrefix[g]))=global.rndGatePrefix[g] {return g}
}
return 0
