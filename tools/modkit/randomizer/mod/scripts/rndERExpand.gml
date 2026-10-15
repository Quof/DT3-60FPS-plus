//Randomizer: a node reached (argument0: entry*rndEGsN+state): the room's resets set, then each row of its way for the
//room's own state tried (rndERTry; a row instance is row*rndEGsN+state, the state with the resets)
var node,e,gs,ri,i,g,stc,m,w,q;
node=argument0
e=node div global.rndEGsN
gs=node mod global.rndEGsN
ri=global.rndEERoom[e]
for(i=0;i<global.rndERResN[ri];i+=1) {gs=rndERGset(gs,global.rndERResG[ri,i],global.rndERResV[ri,i])}
stc=0
m=1
for(i=0;i<global.rndERCarN[ri];i+=1)
{
  g=global.rndERCar[ri,i]
  stc+=rndERGval(gs,g)*m
  m*=global.rndEGVals[g]
}
for(w=global.rndEEWayF[e];w<global.rndEEWayF[e]+global.rndEEWayC[e];w+=1)
{
  if global.rndEWSt[w]=stc
  {
    for(q=global.rndEWRowF[w];q<global.rndEWRowF[w]+global.rndEWRowC[w];q+=1) {rndERTry(q*global.rndEGsN+gs)}
  }
}
