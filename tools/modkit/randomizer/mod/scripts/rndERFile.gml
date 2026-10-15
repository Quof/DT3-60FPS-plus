//Randomizer: a row instance filed under what it lacks (argument0: the row, argument1: the state; what rndERTry's
//rndERLack calls put in global.rndRLk1-3, and its Program Chip in rndRLk4), filed afresh each time (its filing number in rndRGQ; the waiting lists'
//entries of an older one are skipped). argument2: only one part of what the row needs lacks something: only then do its
//"one more is all" entries count in rndRSingle (rndRSing keeps them, to take back off when it's filed again or goes
//through)
var q,gs,inst,tAlone,gen,lst,j,v,ix,str,L;
q=argument0
gs=argument1
tAlone=argument2
inst=q*global.rndEGsN+gs
gen=ds_grid_get(global.rndRGQ,gs,q)+1
rndERUnfile(q,gs)
str=""
for(L=0;L<4;L+=1)
{
  if L=0 {lst=global.rndRLk1}
  else if L=1 {lst=global.rndRLk2}
  else if L=2 {lst=global.rndRLk3}
  else {lst=global.rndRLk4}
  for(j=0;j<ds_list_size(lst);j+=1)
  {
    v=ds_list_find_value(lst,j)
    ix=v div 2
    ds_list_add(global.rndRWait[ix],inst)
    ds_list_add(global.rndRWaitG[ix],gen)
    if (v mod 2)=1 and tAlone=1 {global.rndRSingle[ix]+=1; str+=string(ix)+","}
  }
}
ds_grid_set(global.rndRGQ,gs,q,gen)
if str!="" {ds_map_add(global.rndRSing,inst,str)}
