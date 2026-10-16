//Randomizer: a row instance tried (argument0: row*rndEGsN+state): gone through if what it takes is had (an exit's way
//on, a place reached, a spot's event), else filed under what it lacks (rndERFile). An exit's way also takes the fight of
//the room it goes into (another room's boss) and what going through it takes on top (a via, overrides' need: an Access
//Gate's portal's Program Chip among them); a boss's room or via exit, the fight of the boss fought there (Boss Rando:
//rndBRFight)
var inst,gs,q,ri,tKind,t,af,ac,g2,tLeave,i,g,n,tTo,tr,bf,bc,xf,xc,s,ok1,ok2,ok3,nf,c,j,cv;
inst=argument0
q=inst div global.rndEGsN
gs=inst mod global.rndEGsN
if ds_grid_get(global.rndRGQ,gs,q)<0 {exit}
ri=global.rndEERoom[global.rndEQEntry[q]]
tKind=global.rndEQKind[q]
t=global.rndEQTgt[q]
af=global.rndEQAltF[q]
ac=global.rndEQAltC[q]
ds_list_clear(global.rndRLk1)
ds_list_clear(global.rndRLk2)
ds_list_clear(global.rndRLk3)
if tKind=1
{
  //(the state the player leaves in: the room's own groups as the row has them)
  g2=gs
  tLeave=global.rndEQLeave[q]
  for(i=0;i<global.rndERCarN[ri];i+=1)
  {
    g=global.rndERCar[ri,i]
    n=global.rndEGVals[g]
    g2=rndERGset(g2,g,tLeave mod n)
    tLeave=tLeave div n
  }
  tTo=rndERDest(t,g2)
  if tTo<0 {exit}
  tr=global.rndEERoom[tTo]
  bf=-1
  bc=0
  if tr!=ri
  {
    s=global.rndERSlot[tr]
    if s>=0 {s=global.rndBRFight[s]; bf=global.rndEBReqF[s]; bc=global.rndEBReqC[s]}
    else {bf=global.rndERBossF[tr]; bc=global.rndERBossC[tr]}
  }
  s=global.rndEXSlot[t]
  if s>=0 {s=global.rndBRFight[s]; xf=global.rndEBReqF[s]; xc=global.rndEBReqC[s]}
  else {xf=global.rndEXExF[t]; xc=global.rndEXExC[t]}
  ok1=rndERLack(af,ac,global.rndRLk1)
  ok2=rndERLack(bf,bc,global.rndRLk2)
  ok3=rndERLack(xf,xc,global.rndRLk3)
  nf=(ok1=0)+(ok2=0)+(ok3=0)
  if nf>0 {rndERFile(q,gs,nf=1); exit}
  rndERPassed(q,gs)
  //the Forest Palace's crystals: left with, parked; gone back into, each value they were left with
  if global.rndERScope[ri]=1 and global.rndERScope[tr]=0
  {
    c=rndERScoped(g2)
    if global.rndRParked[c]=0
    {
      global.rndRParked[c]=1
      for(j=0;j<ds_list_size(global.rndRCross);j+=1)
      {
        cv=ds_list_find_value(global.rndRCross,j)
        rndERGo(cv div global.rndEGsN,rndERUnpark(cv mod global.rndEGsN,c))
      }
    }
    rndERGo(tTo,rndERPark(g2))
  }
  else if global.rndERScope[tr]=1 and global.rndERScope[ri]=0
  {
    ds_list_add(global.rndRCross,tTo*global.rndEGsN+g2)
    for(c=0;c<global.rndEParkN;c+=1) {if global.rndRParked[c]=1 {rndERGo(tTo,rndERUnpark(g2,c))}}
  }
  else {rndERGo(tTo,g2)}
  exit
}
if rndERLack(af,ac,global.rndRLk1)=0 {rndERFile(q,gs,1); exit}
rndERPassed(q,gs)
if tKind=2
{
  if t>=0 {global.rndRPlace[t]=1}
}
else
{
  //(a spot: its event happens; rndERRun lets the rows waiting for it try again)
  i=global.rndEEvBase+t
  if global.rndGHave[i]<1 {global.rndGHave[i]=1; ds_list_add(global.rndREvNew,i)}
}
