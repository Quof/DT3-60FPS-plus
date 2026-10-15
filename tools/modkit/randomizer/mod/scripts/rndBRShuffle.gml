//Randomizer: Boss Rando's shuffle: each shuffled boss's place (its room, or the exit the story went into its fight by)
//gets one of the shuffled bosses' fights, at random (global.rndBRFight: the boss fought at a boss's place; the final
//boss isn't shuffled: rndERLoad's rndEBShuf). As roomlogic\erflat.py's br_shuffle
var i,j,k,n;
n=0
for(i=0;i<global.rndBossN;i+=1)
{
  global.rndBRFight[i]=i
  if global.rndEBShuf[i]=1 {global.rndBRList[n]=i; n+=1}
}
for(i=n-1;i>0;i-=1) {j=irandom(i); k=global.rndBRList[i]; global.rndBRList[i]=global.rndBRList[j]; global.rndBRList[j]=k}
k=0
for(i=0;i<global.rndBossN;i+=1)
{
  if global.rndEBShuf[i]=1 {global.rndBRFight[i]=global.rndBRList[k]; k+=1}
}
