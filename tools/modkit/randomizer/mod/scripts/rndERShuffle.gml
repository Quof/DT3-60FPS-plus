//Randomizer: the entrance randomizer's shuffle (argument0: the mode's bit: 1 Gate Swap, 2 Overworld, 4 Chaos): the doors'
//ends in the mode's pool paired anew (global.rndERPart: an end's new partner; -1 the game's own). As roomlogic\erflat.py's
//shuffle: the pool's ends in a random order; each step, the first one in it whose way back in isn't reached and leads
//somewhere new (a room not reached, or entries, free ends or places that aren't) is joined to an end of the frontier (a
//free end whose exit is reached) chosen at random, so everything joined is reached from the start with everything; with
//only one end left in the frontier, one that leads on to other free ends, so the joining doesn't stop at a dead end. The
//ends left (their ways in reach nothing new) are paired at random. Returns 1, or 0 when it got stuck (try another)
var tBit,n,i,j,k,d,u,st,tEndsN,tP,tFN,tF0,tNeedyN,tNeedy1,tSkip,b,pu,tN2,fsel;
tBit=argument0
n=global.rndEDN
global.rndSStamp+=1
st=global.rndSStamp
tEndsN=0
for(d=0;d<n;d+=1)
{
  global.rndERPart[d]=-1
  if ((global.rndEDMode[d] div tBit) mod 2)=1 {global.rndSInPool[d]=1; global.rndSEnds[tEndsN]=d; tEndsN+=1}
  else {global.rndSInPool[d]=0}
}
for(i=tEndsN-1;i>0;i-=1) {j=irandom(i); k=global.rndSEnds[i]; global.rndSEnds[i]=global.rndSEnds[j]; global.rndSEnds[j]=k}
//from the start
ds_list_clear(global.rndSFront)
ds_stack_clear(global.rndSStack)
rndERGrowTo(global.rndEStart)
rndERGrow()
//(tP: the ends before it in the order can't be joined at a step any more: joined, covered or their way in reached)
tP=0
while true
{
  ds_list_sort(global.rndSFront,true)
  tFN=ds_list_size(global.rndSFront)
  tF0=-1
  if tFN>0 {tF0=ds_list_find_value(global.rndSFront,0)}
  u=-1
  tNeedyN=0
  tNeedy1=-1
  for(i=tP;i<tEndsN;i+=1)
  {
    d=global.rndSEnds[i]
    tSkip=0
    if global.rndERPart[d]!=-1 {tSkip=1}
    else if global.rndSCov[d]=st {tSkip=1}
    else if global.rndSSeen[global.rndEDBack[d]]=st {tSkip=1}
    else
    {
      //(one whose way in is in a room reached and leads nowhere new is covered: what's reached only grows)
      rndERLocal(d)
      if global.rndSRoom[global.rndEERoom[global.rndEDBack[d]]]=st and global.rndSLE=0 and global.rndSLF=0 and global.rndSLP=0
      {global.rndSCov[d]=st; tSkip=1}
    }
    if tSkip=1
    {
      if i=tP {tP+=1}
    }
    else
    {
      tNeedyN+=1
      if tNeedyN=1 {tNeedy1=d}
      if tFN>0 and !(tFN=1 and tF0=d) and (tFN>1 or global.rndSLF=1) {u=d; break}
    }
  }
  if u<0
  {
    if tNeedyN=0 {break}
    if tNeedyN=1 and tFN>0 and !(tFN=1 and tF0=tNeedy1) {u=tNeedy1}
    else {return 0}
  }
  //an end of the frontier (not u), at random
  pu=-1
  if global.rndSFrontAt[u]=st {pu=ds_list_find_index(global.rndSFront,u)}
  tN2=tFN
  if pu>=0 {tN2-=1}
  k=irandom(tN2-1)
  if pu>=0 and k>=pu {k+=1}
  fsel=ds_list_find_value(global.rndSFront,k)
  global.rndERPart[fsel]=u
  global.rndERPart[u]=fsel
  global.rndSFrontAt[fsel]=0
  if pu>=0
  {
    global.rndSFrontAt[u]=0
    if pu>k {ds_list_delete(global.rndSFront,pu); ds_list_delete(global.rndSFront,k)}
    else {ds_list_delete(global.rndSFront,k); ds_list_delete(global.rndSFront,pu)}
  }
  else {ds_list_delete(global.rndSFront,k)}
  //on from both ways back in
  ds_stack_clear(global.rndSStack)
  rndERGrowTo(global.rndEDBack[u])
  rndERGrowTo(global.rndEDBack[fsel])
  rndERGrow()
}
//the rest, paired at random
k=0
for(i=0;i<tEndsN;i+=1)
{
  d=global.rndSEnds[i]
  if global.rndERPart[d]=-1 {global.rndSRest[k]=d; k+=1}
}
for(i=k-1;i>0;i-=1) {j=irandom(i); d=global.rndSRest[i]; global.rndSRest[i]=global.rndSRest[j]; global.rndSRest[j]=d}
for(i=0;i+1<k;i+=2)
{
  global.rndERPart[global.rndSRest[i]]=global.rndSRest[i+1]
  global.rndERPart[global.rndSRest[i+1]]=global.rndSRest[i]
}
return 1
