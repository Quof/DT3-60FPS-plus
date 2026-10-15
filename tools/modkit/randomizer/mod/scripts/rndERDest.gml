//Randomizer: where an exit leads (argument0: the exit, argument1: the state it's left in): its door's shuffled partner's
//way back in, or the game's own (one that goes by a carried group: that group's value's). An entry, or -1
var tX,d,p;
tX=argument0
d=global.rndEXEnd[tX]
if d>=0
{
  p=global.rndERPart[d]
  if p>=0 {return global.rndEDBack[p]}
}
if global.rndEXSg[tX]>=0 {return global.rndEXSd[tX,rndERGval(argument1,global.rndEXSg[tX])]}
return global.rndEXDest[tX]
