//Randomizer: whether location argument0 is reached with the progression items in global.rndGHave (rndGenerate's: how
//many of each it has placed; a key at rndKeyBase+its door's objectNum): one of its alternatives (rndData's logic) has
//all it takes. One that needs everything: once every progression item is placed (global.rndGAll)
var i,a,e,s,tOk;
i=argument0
if global.rndLocAltN[i]<0 {return global.rndGAll}
//(the entrance randomizer: what its reach has got to, rndERReachStart)
if global.rndERMode>0 {return global.rndRPlace[i]}
s=global.rndAltStride
for(a=0;a<global.rndLocAltN[i];a+=1)
{
  tOk=1
  for(e=0;e<global.rndLocAltLen[i,a];e+=1)
  {
    if global.rndGHave[global.rndLocAltIx[i,a*s+e]]<global.rndLocAltC[i,a*s+e] {tOk=0; break}
  }
  if tOk=1 {return 1}
}
return 0
