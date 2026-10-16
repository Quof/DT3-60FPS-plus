//Randomizer: the entrance randomizer's shuffle read back from a string (argument0: rndERString's, argument1: how many
//ends it has: this build's, or an earlier build's, rndERAccept) into global.rndERPart; the ends after those aren't
//joined. Returns 1, or 0 when it doesn't fit (a save from a build with other doors): then none is
var s,n,d,p;
s=argument0
n=argument1
if n>global.rndEDN or string_length(s)!=n*4
{
  for(d=0;d<global.rndEDN;d+=1) {global.rndERPart[d]=-1}
  return 0
}
for(d=0;d<global.rndEDN;d+=1)
{
  p=-1
  if d<n {p=real(string_copy(s,d*4+1,4))-1}
  if p<-1 or p>=n {p=-1}
  global.rndERPart[d]=p
}
//(each pair both ways)
for(d=0;d<global.rndEDN;d+=1)
{
  p=global.rndERPart[d]
  if p>=0
  {
    if global.rndERPart[p]!=d
    {
      for(d=0;d<global.rndEDN;d+=1) {global.rndERPart[d]=-1}
      return 0
    }
  }
}
return 1
