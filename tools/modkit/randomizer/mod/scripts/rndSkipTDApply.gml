//Randomizer: the new game's option Skip Tower Defense, on (argument0 1) or off (0). On, tower defense's rewards (in
//Central City - North: rndData's rndTdLoc) are there from the start (rndNewGame sets its progress won, gameOptTowerDef
//6), so each needs what the room logic has getting to it need (rndTdAlt*, as rndLocAlt* has a location's) and can hold
//an ability or a key; off, each needs everything (a level not won yet never holds the game back)
var k,i,a,j,s;
global.rndSkipTD=argument0
s=global.rndAltStride
for(k=0;k<global.rndTdN;k+=1)
{
  i=global.rndTdLoc[k]
  if argument0=1
  {
    global.rndLocAltN[i]=global.rndTdAltN[k]
    for(a=0;a<global.rndTdAltN[k];a+=1)
    {
      global.rndLocAltLen[i,a]=global.rndTdAltLen[k,a]
      for(j=0;j<global.rndTdAltLen[k,a];j+=1)
      {
        global.rndLocAltIx[i,a*s+j]=global.rndTdAltIx[k,a*s+j]
        global.rndLocAltC[i,a*s+j]=global.rndTdAltC[k,a*s+j]
      }
    }
  }
  else {global.rndLocAltN[i]=-1}
}
