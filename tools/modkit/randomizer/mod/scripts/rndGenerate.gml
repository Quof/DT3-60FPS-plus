//Randomizer: places every item at a location (global.rndPlace, three digits a location: the item's number). The
//progression items (abilities, keys) go first, one at a time in a random order, each at a free location that can be
//reached with every progression item not placed yet plus those already placed where that reaches (assumed fill), so the
//game can always be finished with the logic's requirements (rndData, from rndgen.py and logic.txt). The other items
//fill the rest at random. Returns 1, or 0 when a progression item had nowhere to go (try another seed)
var N,i,j,k,n,p,tProgN,tJunkN,tFreeN,tCandN,tChanged,tOk,tLoc;
N=global.rndLocN
for(i=0;i<N;i+=1) {tFill[i]=-1}
tProgN=0
tJunkN=0
for(i=0;i<global.rndItemN;i+=1)
{
  if global.rndItemProg[i]>=0 {tProg[tProgN]=i; tProgN+=1}
  else {tJunk[tJunkN]=i; tJunkN+=1}
}
for(i=tProgN-1;i>0;i-=1) {j=irandom(i); k=tProg[i]; tProg[i]=tProg[j]; tProg[j]=k}
for(n=0;n<tProgN;n+=1)
{
  //what the player can have: the progression items not placed yet, but this one...
  for(p=0;p<13;p+=1) {tHave[p]=0}
  for(k=n+1;k<tProgN;k+=1) {p=global.rndItemProg[tProg[k]]; tHave[p]+=1}
  //...and those already placed where that reaches (until it reaches no more)
  for(k=0;k<n;k+=1) {tTaken[k]=0}
  tChanged=1
  while tChanged
  {
    tChanged=0
    for(k=0;k<n;k+=1)
    {
      if tTaken[k]=0
      {
        tLoc=tAt[k]
        tOk=1
        for(p=0;p<13;p+=1) {if global.rndReqV[tLoc,p]>tHave[p] {tOk=0; break}}
        if tOk
        {
          tTaken[k]=1
          p=global.rndItemProg[tProg[k]]
          tHave[p]+=1
          tChanged=1
        }
      }
    }
  }
  //this item goes to a free location that reaches
  tCandN=0
  for(i=0;i<N;i+=1)
  {
    if tFill[i]<0
    {
      tOk=1
      for(p=0;p<13;p+=1) {if global.rndReqV[i,p]>tHave[p] {tOk=0; break}}
      if tOk {tCand[tCandN]=i; tCandN+=1}
    }
  }
  if tCandN=0 {return 0}
  tLoc=tCand[irandom(tCandN-1)]
  tFill[tLoc]=tProg[n]
  tAt[n]=tLoc
}
//the other items, at random in the locations left
tFreeN=0
for(i=0;i<N;i+=1) {if tFill[i]<0 {tFree[tFreeN]=i; tFreeN+=1}}
for(i=tJunkN-1;i>0;i-=1) {j=irandom(i); k=tJunk[i]; tJunk[i]=tJunk[j]; tJunk[j]=k}
for(i=0;i<tFreeN and i<tJunkN;i+=1) {tFill[tFree[i]]=tJunk[i]}
global.rndPlace=""
for(i=0;i<N;i+=1)
{
  k=string(max(0,tFill[i]))
  global.rndPlace+=string_repeat("0",3-string_length(k))+k
}
return 1
