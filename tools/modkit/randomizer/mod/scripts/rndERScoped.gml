//Randomizer: the values of a state's groups kept within some rooms (the Forest Palace's crystals), as one number
//(argument0: the state), for global.rndRParked
var c,m,i,g;
c=0
m=1
for(i=0;i<global.rndEScN;i+=1)
{
  g=global.rndESc[i]
  c+=rndERGval(argument0,g)*m
  m*=global.rndEGVals[g]
}
return c
