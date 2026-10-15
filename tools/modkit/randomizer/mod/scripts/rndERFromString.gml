//Randomizer: the entrance randomizer's shuffle read back from the save file's string (argument0: rndERString's) into
//global.rndERPart. Returns 1, or 0 when it doesn't fit the doors (a save from a build with other doors): then none
var s,d,p;
s=argument0
if string_length(s)!=global.rndEDN*4 {return 0}
for(d=0;d<global.rndEDN;d+=1)
{
  p=real(string_copy(s,d*4+1,4))-1
  if p<-1 or p>=global.rndEDN {p=-1}
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
