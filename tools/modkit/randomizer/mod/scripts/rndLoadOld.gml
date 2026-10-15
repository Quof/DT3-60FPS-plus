//Randomizer: a save made with an earlier build, brought up to this one's (the load hook, after its own values are read).
//The Nightmare Gates' rewards (location type 18) came after the other locations: a save without them has each hold its
//own instrument, taken already when the save had it (the Sacred Temple gave it then: eGateProg 9). The gates' bosses
//came after the other bosses: one the save's game beat its own way (eGateProg 8 or 9) is beaten
var i,j,k,L;
if string_length(global.rndPlace)<global.rndLocN*3
{
  for(i=string_length(global.rndPlace) div 3;i<global.rndLocN;i+=1)
  {
    k=i
    if global.rndLocType[i]=18
    {
      for(j=0;j<global.rndItemN;j+=1) {if global.rndItemKind[j]=26 and global.rndItemParam[j]=global.rndLocNum[i] {k=j}}
      if string_char_at(global.eGateProg,global.rndLocNum[i])="9" {global.rndGot=rndSetChar(global.rndGot,i+1,"1")}
    }
    L=string(k)
    global.rndPlace+=string_repeat("0",3-string_length(L))+L
  }
}
for(i=0;i<global.rndBossN;i+=1)
{
  if global.rndBossGate[i]>0
  {
    k=string_char_at(global.eGateProg,global.rndBossGate[i])
    if k="8" or k="9" {global.rndBossDone=rndSetChar(global.rndBossDone,i+1,"1")}
  }
}
