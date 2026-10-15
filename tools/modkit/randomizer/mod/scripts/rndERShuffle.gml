//Randomizer: the entrance randomizer's shuffle (argument0: the mode's bit: 1 Gate Swap, 2 Overworld, 4 Chaos): the doors'
//ends in the mode's pool paired anew (global.rndERPart: an end's new partner; -1 the game's own). As roomlogic\erflat.py's
//shuffle: the pool's ends in a random order; each step, the first one in it whose way back in isn't reached and leads
//somewhere new (a room not reached, or entries, free ends or places that aren't) is joined to an end of the frontier (a
//free end whose exit is reached) of its class (rndEDCls: what the Metroid door in front of its exit needs) chosen at
//random, so everything joined is reached from the start with everything; with only one end left in the frontier, one
//that leads on to other free ends, so the joining doesn't stop at a dead end. The ends left (their ways in reach
//nothing new) are paired at random, each with one of its class. Returns 1, or 0 when it got stuck (try another)
var tBit,n,i,j,k,d,u,st,c,tEndsN,tP,tFN,tNC,tNeedyN,tNeedy1,tSkip,pu,kx,fsel;
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
for(c=0;c<3;c+=1) {global.rndSFrontC[c]=0}
ds_stack_clear(global.rndSStack)
rndERGrowTo(global.rndEStart)
rndERGrow()
//(tP: the ends before it in the order can't be joined at a step any more: joined, covered or their way in reached)
tP=0
while true
{
  ds_list_sort(global.rndSFront,true)
  tFN=ds_list_size(global.rndSFront)
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
      //(the frontier's ends of its class it can be joined to: not itself)
      tNC=global.rndSFrontC[global.rndEDCls[d]]
      if global.rndSFrontAt[d]=st {tNC-=1}
      if tNC>0 and (tFN>1 or global.rndSLF=1) {u=d; break}
    }
  }
  if u<0
  {
    if tNeedyN=0 {break}
    tNC=0
    if tNeedyN=1
    {
      tNC=global.rndSFrontC[global.rndEDCls[tNeedy1]]
      if global.rndSFrontAt[tNeedy1]=st {tNC-=1}
    }
    if tNC>0 {u=tNeedy1}
    else {return 0}
  }
  //an end of the frontier of u's class (not u), at random: the k-th of them in the frontier's order
  c=global.rndEDCls[u]
  tNC=global.rndSFrontC[c]
  pu=-1
  if global.rndSFrontAt[u]=st {pu=ds_list_find_index(global.rndSFront,u); tNC-=1}
  k=irandom(tNC-1)
  kx=-1
  for(i=0;i<tFN;i+=1)
  {
    d=ds_list_find_value(global.rndSFront,i)
    if d!=u and global.rndEDCls[d]=c
    {
      if k=0 {kx=i; break}
      k-=1
    }
  }
  fsel=ds_list_find_value(global.rndSFront,kx)
  global.rndERPart[fsel]=u
  global.rndERPart[u]=fsel
  global.rndSFrontAt[fsel]=0
  global.rndSFrontC[c]-=1
  if pu>=0
  {
    global.rndSFrontAt[u]=0
    global.rndSFrontC[c]-=1
    if pu>kx {ds_list_delete(global.rndSFront,pu); ds_list_delete(global.rndSFront,kx)}
    else {ds_list_delete(global.rndSFront,kx); ds_list_delete(global.rndSFront,pu)}
  }
  else {ds_list_delete(global.rndSFront,kx)}
  //on from both ways back in
  ds_stack_clear(global.rndSStack)
  rndERGrowTo(global.rndEDBack[u])
  rndERGrowTo(global.rndEDBack[fsel])
  rndERGrow()
}
//the rest, paired at random, each with one of its class
k=0
for(i=0;i<tEndsN;i+=1)
{
  d=global.rndSEnds[i]
  if global.rndERPart[d]=-1 {global.rndSRest[k]=d; k+=1}
}
for(i=k-1;i>0;i-=1) {j=irandom(i); d=global.rndSRest[i]; global.rndSRest[i]=global.rndSRest[j]; global.rndSRest[j]=d}
for(c=0;c<3;c+=1)
{
  u=-1
  for(i=0;i<k;i+=1)
  {
    d=global.rndSRest[i]
    if global.rndEDCls[d]=c
    {
      if u<0 {u=d}
      else
      {
        global.rndERPart[u]=d
        global.rndERPart[d]=u
        u=-1
      }
    }
  }
}
return 1
