//Randomizer: a state with its groups kept within some rooms set from a parked number (argument0: the state, argument1:
//rndERScoped's number)
var gs,c,i,g,n;
gs=argument0
c=argument1
for(i=0;i<global.rndEScN;i+=1)
{
  g=global.rndESc[i]
  n=global.rndEGVals[g]
  gs=rndERGset(gs,g,c mod n)
  c=c div n
}
return gs
