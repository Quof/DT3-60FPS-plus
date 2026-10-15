//Randomizer: making a shuffle (rndERShuffle): with everything, on from the entries on global.rndSStack (each one
//seen: rndERGrowTo). The places they get to are seen (rndSPlace); an exit of an end in the mode's pool that isn't joined
//yet puts the end in the frontier (rndSFront: an end to join a new one to; rndSFrontC counts them by class); a joined
//end goes on to its partner's way back in; any other exit, where the game has it lead
var e,j,k,tX,d,st;
st=global.rndSStamp
while !ds_stack_empty(global.rndSStack)
{
  e=ds_stack_pop(global.rndSStack)
  for(j=0;j<global.rndELocsN[e];j+=1) {global.rndSPlace[global.rndELocs[e,j]]=st}
  for(j=0;j<global.rndEOutN[e];j+=1)
  {
    tX=global.rndEOut[e,j]
    d=global.rndEXEnd[tX]
    if d>=0 {if global.rndSInPool[d]=0 {d=-1}}
    if d>=0
    {
      if global.rndERPart[d]>=0 {rndERGrowTo(global.rndEDBack[global.rndERPart[d]])}
      else if global.rndSFrontAt[d]!=st
      {
        global.rndSFrontAt[d]=st
        ds_list_add(global.rndSFront,d)
        global.rndSFrontC[global.rndEDCls[d]]+=1
      }
    }
    else if global.rndEXSg[tX]<0 {rndERGrowTo(global.rndEXDest[tX])}
    else
    {
      for(k=0;k<global.rndEXSdN[tX];k+=1) {rndERGrowTo(global.rndEXSd[tX,k])}
    }
  }
}
