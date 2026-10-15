//Randomizer: the entrance randomizer's shuffle (global.rndERPart) as a string for the save file: each end's new
//partner+1 (0: the game's own) in four digits
var d,s,t;
s=""
for(d=0;d<global.rndEDN;d+=1)
{
  t=string(global.rndERPart[d]+1)
  s+=string_repeat("0",4-string_length(t))+t
}
return s
