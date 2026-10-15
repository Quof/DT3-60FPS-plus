//Randomizer: whether a list of alternatives is met (argument0: its first, -1 for nothing needed; argument1: how many):
//1, or 0 with what each alternative lacks added to a list (argument2: requirement*2, +1 when one more of it is all that
//alternative lacks; an event lacking never counts so)
var first,cnt,lst,a,k,k0,s,tShort,tStart,ix;
first=argument0
cnt=argument1
lst=argument2
if first<0 {return 1}
tStart=ds_list_size(lst)
for(a=first;a<first+cnt;a+=1)
{
  tShort=0
  k0=ds_list_size(lst)
  for(k=global.rndEAReqF[a];k<global.rndEAReqF[a]+global.rndEAReqC[a];k+=1)
  {
    ix=global.rndEKIx[k]
    s=global.rndEKC[k]-global.rndGHave[ix]
    if s>0
    {
      ds_list_add(lst,ix*2)
      if ix>=global.rndEEvBase {tShort+=2} else {tShort+=s}
    }
  }
  if ds_list_size(lst)=k0
  {
    //(this one is met: what the others lacked doesn't count)
    while ds_list_size(lst)>tStart {ds_list_delete(lst,ds_list_size(lst)-1)}
    return 1
  }
  if tShort=1 {ds_list_replace(lst,k0,ds_list_find_value(lst,k0)+1)}
}
return 0
