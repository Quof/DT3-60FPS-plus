//Randomizer: a state with its groups kept within some rooms parked (their last value: outside those rooms, rndERTry)
var gs,i,g;
gs=argument0
for(i=0;i<global.rndEScN;i+=1)
{
  g=global.rndESc[i]
  gs=rndERGset(gs,g,global.rndEGVals[g]-1)
}
return gs
