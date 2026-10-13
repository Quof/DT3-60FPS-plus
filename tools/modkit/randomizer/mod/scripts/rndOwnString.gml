//Randomizer: the abilities found (global.rndOwn) as a string for the save file, a digit each
var i,s;
s=""
for(i=0;i<12;i+=1) {s+=string(min(9,global.rndOwn[i]))}
return s
