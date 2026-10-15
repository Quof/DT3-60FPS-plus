//Randomizer: places every item at a location (global.rndPlace, three digits a location: the item's number), in layers.
//The progression items (abilities, keys) go one at a time, each to a free location the ones placed before it reach
//(rndData's logic, from the room logic: rndGenReach), so the game can always be finished. Each one is, if there is one,
//an item that opens a location not reached yet (one more of it is all that location lacks); the locations it opens are
//the next layer (global.rndGLayer: layer 0 is what jumping alone reaches). Where it goes: the newest layer with a free
//location with a chance of 7 in 10 (the new game's option Ability Spread: 3 in 10 Near, always Far), else the one
//before it with that chance, and so on (the oldest if none of them), so the abilities spread out from Central City
//instead of all being near it. With the option Guarantee Early Weapons, a new layer's first item is a weapon (an item of
//the Link, Belmont, Mega Man or Samus set: the sets with an attack) while there are any left: every layer has one. The
//other items fill the rest at random.
//With Entrance Rando or Boss Rando (global.rndReach), what the items reach is worked out from the rooms with the doors
//and the bosses as shuffled (rndERReachStart, rndERAdd: global.rndRPlace) instead of rndData's logic, and the items
//that open something are those one more of which lets a way through (global.rndRSingle).
//Returns 1, or 0 when a progression item had nowhere to go (try another seed)
var N,i,j,k,a,e,s,tProgN,tJunkN,tFreeN,tCandN,tCur,tLay,tLast,tPick,tPlaced,tMiss,tMissIx,tShort,tIx,tLoc,tW,tR,tKind,tNewest,tForce,tWpnN;
N=global.rndLocN
s=global.rndAltStride
tNewest=0.7
if global.rndOptSpread=0 {tNewest=0.3}
else if global.rndOptSpread=2 {tNewest=1}
for(i=0;i<N;i+=1) {tFill[i]=-1; global.rndGLayer[i]=-1}
tProgN=0
tJunkN=0
for(i=0;i<global.rndItemN;i+=1)
{
  if global.rndItemProg[i]>0 {tProg[tProgN]=i; tDone[tProgN]=0; tProgN+=1}
  else {tJunk[tJunkN]=i; tJunkN+=1}
}
for(i=0;i<global.rndKeyBase+64;i+=1) {global.rndGHave[i]=0; tUseful[i]=0}
if global.rndReach=1 {rndERReachStart()}
//the layers with a weapon (a layer is made by an item placed: there are at most as many as items, and the first)
for(i=0;i<=tProgN+1;i+=1) {tLayW[i]=0}
global.rndGAll=0
rndGenMark(0)
tCur=0
for(tPlaced=0;tPlaced<tProgN;tPlaced+=1)
{
  //(the room logic's placement takes a while: the window keeps answering Windows)
  if global.rndReach=1 {io_handle()}
  //the items one more of which opens a location: for each location not reached yet, an alternative short of just that
  //(the room logic's reach: one more of which lets a way waiting for it through)
  for(i=0;i<global.rndKeyBase+64;i+=1) {tUseful[i]=0}
  if global.rndReach=1
  {
    for(i=0;i<global.rndKeyBase+64;i+=1) {tUseful[i]=global.rndRSingle[i]}
  }
  else for(i=0;i<N;i+=1)
  {
    if global.rndGLayer[i]<0
    {
      for(a=0;a<global.rndLocAltN[i];a+=1)
      {
        tMiss=0
        tMissIx=-1
        for(e=0;e<global.rndLocAltLen[i,a];e+=1)
        {
          tIx=global.rndLocAltIx[i,a*s+e]
          tShort=global.rndLocAltC[i,a*s+e]-global.rndGHave[tIx]
          if tShort>0
          {
            tMiss+=tShort
            tMissIx=tIx
            if tMiss>1 {break}
          }
        }
        if tMiss=1 {tUseful[tMissIx]+=1}
      }
    }
  }
  //the items it can be (tPool): any not placed yet. With Guarantee Early Weapons, while the newest layer has no weapon
  //and has a free location: the weapons not placed yet (6-9: rndProgOf's Link, Belmont, Mega Man and Samus sets); it
  //goes in the newest layer (tForce)
  for(k=0;k<tProgN;k+=1) {tPool[k]=1-tDone[k]}
  tForce=0
  if global.rndOptWeapons=1 and tLayW[tCur]=0
  {
    tFreeN=0
    for(i=0;i<N;i+=1) {if global.rndGLayer[i]=tCur and tFill[i]<0 {tFreeN+=1}}
    tWpnN=0
    for(k=0;k<tProgN;k+=1)
    {
      tIx=global.rndItemProg[tProg[k]]
      if tDone[k]=0 and tIx>=6 and tIx<=9 {tWpnN+=1}
    }
    if tFreeN>0 and tWpnN>0
    {
      tForce=1
      for(k=0;k<tProgN;k+=1)
      {
        tIx=global.rndItemProg[tProg[k]]
        if tIx<6 or tIx>9 {tPool[k]=0}
      }
    }
  }
  //which item: one of the pool that opens something, if there is one (else any of the pool). Of those, a kind of item
  //that opens fewer locations is likelier (each kind by 1 / how many it opens), so the ones that open the most (the
  //movement abilities) tend to come later and the layers stretch out
  tCandN=0
  for(k=0;k<tProgN;k+=1)
  {
    if tPool[k]=1 {if tUseful[global.rndItemProg[tProg[k]]]>0 {tCand[tCandN]=k; tCandN+=1}}
  }
  if tCandN>0
  {
    for(i=0;i<global.rndKeyBase+64;i+=1) {tSeen[i]=0}
    tW=0
    for(j=0;j<tCandN;j+=1)
    {
      tIx=global.rndItemProg[tProg[tCand[j]]]
      if tSeen[tIx]=0 {tSeen[tIx]=1; tW+=1/tUseful[tIx]}
    }
    tR=random(tW)
    tKind=global.rndItemProg[tProg[tCand[tCandN-1]]]
    for(i=0;i<global.rndKeyBase+64;i+=1) {tSeen[i]=0}
    for(j=0;j<tCandN;j+=1)
    {
      tIx=global.rndItemProg[tProg[tCand[j]]]
      if tSeen[tIx]=0
      {
        tSeen[tIx]=1
        tR-=1/tUseful[tIx]
        if tR<=0 {tKind=tIx; break}
      }
    }
    j=0
    for(i=0;i<tCandN;i+=1) {if global.rndItemProg[tProg[tCand[i]]]=tKind {tCand[j]=tCand[i]; j+=1}}
    tCandN=j
  }
  else
  {
    for(k=0;k<tProgN;k+=1) {if tPool[k]=1 {tCand[tCandN]=k; tCandN+=1}}
  }
  k=tCand[irandom(tCandN-1)]
  //where: a weapon the option puts in the newest layer goes there; else a layer with a free location, the newest first
  //(each in turn with a chance of tNewest)
  if tForce=1 {tPick=tCur}
  else
  {
    tPick=-1
    tLast=-1
    for(tLay=tCur;tLay>=0;tLay-=1)
    {
      tFreeN=0
      for(i=0;i<N;i+=1) {if global.rndGLayer[i]=tLay and tFill[i]<0 {tFreeN+=1}}
      if tFreeN>0
      {
        tLast=tLay
        if random(1)<tNewest {tPick=tLay; break}
      }
    }
    if tPick<0 {tPick=tLast}
    if tPick<0 {return 0}
  }
  //a free location in it, at random
  tCandN=0
  for(i=0;i<N;i+=1) {if global.rndGLayer[i]=tPick and tFill[i]<0 {tCand[tCandN]=i; tCandN+=1}}
  tLoc=tCand[irandom(tCandN-1)]
  tFill[tLoc]=tProg[k]
  tDone[k]=1
  tIx=global.rndItemProg[tProg[k]]
  if global.rndReach=1 {rndERAdd(tIx,1)}
  else {global.rndGHave[tIx]+=1}
  if tIx>=6 and tIx<=9 {tLayW[tPick]=1}
  if tPlaced=tProgN-1 {global.rndGAll=1}
  //what it opens: the next layer
  if rndGenMark(tCur+1)>0 {tCur+=1}
}
//the other items, at random in the locations left. (The cursed equipment, 10-12, which the Trial Master's trials need
//all three of on, is a progression item, placed above with the logic, which keeps it off the trials' places; the loop
//below, which puts any not placed yet at free places that aren't a trial's, rndLocTrial, finds none)
tFreeN=0
for(i=0;i<N;i+=1) {if tFill[i]<0 {tFree[tFreeN]=i; tFreeN+=1}}
for(i=tFreeN-1;i>0;i-=1) {j=irandom(i); k=tFree[i]; tFree[i]=tFree[j]; tFree[j]=k}
for(i=tJunkN-1;i>0;i-=1) {j=irandom(i); k=tJunk[i]; tJunk[i]=tJunk[j]; tJunk[j]=k}
for(i=0;i<tJunkN;i+=1)
{
  if global.rndItemKind[tJunk[i]]=3 and global.rndItemParam[tJunk[i]]>=10 and global.rndItemParam[tJunk[i]]<=12
  {
    for(j=0;j<tFreeN;j+=1)
    {
      if tFree[j]>=0
      {
        if global.rndLocTrial[tFree[j]]=0 {tFill[tFree[j]]=tJunk[i]; tFree[j]=-1; tJunk[i]=-1; break}
      }
    }
  }
}
j=0
for(i=0;i<tJunkN;i+=1)
{
  if tJunk[i]>=0
  {
    while j<tFreeN {if tFree[j]>=0 {break}; j+=1}
    if j<tFreeN {tFill[tFree[j]]=tJunk[i]; j+=1}
  }
}
global.rndPlace=""
for(i=0;i<N;i+=1)
{
  k=string(max(0,tFill[i]))
  global.rndPlace+=string_repeat("0",3-string_length(k))+k
}
return 1
