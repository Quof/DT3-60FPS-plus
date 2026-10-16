//Randomizer: making a shuffle (rndERShuffle): what an end's way back in gets to with everything, without going through
//the end itself or a free end (argument0: the end): whether that has entries the shuffle hasn't reached (global.rndSLE),
//free ends that aren't in the frontier (rndSLF; rndSLFK: of the end's own key, rndSKey), places that aren't seen (rndSLP)
var u,b,e,j,k,tX,d,st;
u=argument0
st=global.rndSStamp
global.rndSLStamp+=1
global.rndSLE=0
global.rndSLF=0
global.rndSLFK=0
global.rndSLP=0
b=global.rndEDBack[u]
global.rndSLVis[b]=global.rndSLStamp
ds_stack_clear(global.rndSLStack)
ds_stack_push(global.rndSLStack,b)
while !ds_stack_empty(global.rndSLStack)
{
  e=ds_stack_pop(global.rndSLStack)
  for(j=0;j<global.rndELocsN[e];j+=1) {if global.rndSPlace[global.rndELocs[e,j]]!=st {global.rndSLP=1}}
  for(j=0;j<global.rndEOutN[e];j+=1)
  {
    tX=global.rndEOut[e,j]
    d=global.rndEXEnd[tX]
    if d>=0 {if global.rndSInPool[d]=0 {d=-1}}
    if d>=0
    {
      if d!=u
      {
        if global.rndERPart[d]>=0 {rndERLocalTo(global.rndEDBack[global.rndERPart[d]])}
        else if global.rndSFrontAt[d]!=st
        {
          global.rndSLF=1
          if global.rndSKey[d]=global.rndSKey[u] {global.rndSLFK=1}
        }
      }
    }
    else if global.rndEXSg[tX]<0 {rndERLocalTo(global.rndEXDest[tX])}
    else
    {
      for(k=0;k<global.rndEXSdN[tX];k+=1) {rndERLocalTo(global.rndEXSd[tX,k])}
    }
  }
}
