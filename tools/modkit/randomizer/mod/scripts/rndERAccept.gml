//Randomizer: a shuffle of the doors made before (a save's, an Archipelago world's) put back in, if it was made with this
//build's doors or with an earlier build's whose ends are this one's first (argument0: its doors' hash, argument1: the
//shuffle, rndERString's): those doors set (rndERLayout) and the shuffle read (rndERFromString; with an earlier build's,
//the ends after its own aren't joined and the exits that follow an end lead where the game has them, as it was made).
//Returns 1, or 0 when it fits neither (then no end is joined)
var h,s,k;
h=argument0
s=argument1
if h=global.rndEHash
{
  rndERLayout(-1)
  if rndERFromString(s,global.rndEDN)=1 {return 1}
}
else
{
  for(k=0;k<global.rndELegN;k+=1)
  {
    if h=global.rndELegHash[k]
    {
      rndERLayout(k)
      if rndERFromString(s,global.rndELegEnds[k])=1 {return 1}
      break
    }
  }
}
rndERLayout(-1)
for(k=0;k<global.rndEDN;k+=1) {global.rndERPart[k]=-1}
return 0
