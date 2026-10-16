//Randomizer: the entrance randomizer's shuffle (global.rndERPart) as a string, for the save file (argument0: the game's
//doors' ends, rndERGameEnds) and the trackers (all of this build's): each of the first argument0 ends' new partner+1
//(0: the game's own) in four digits
var d,s,t;
s=""
for(d=0;d<argument0;d+=1)
{
  t=string(global.rndERPart[d]+1)
  s+=string_repeat("0",4-string_length(t))+t
}
return s
