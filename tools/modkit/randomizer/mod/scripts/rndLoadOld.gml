//Randomizer: a save made with an earlier build, brought up to this one's (the load hook, after its own values are read;
//argument0: the save's boss list, its types, argument1: how many of them its beaten bosses' string has). The Nightmare
//Gates' rewards (location type 18) came after the other locations: a save without them has each hold its own
//instrument, taken already when the save had it (the Sacred Temple gave it then: eGateProg 9). The gates' bosses came
//after the other bosses: a save whose string stops before a gate's boss beat that boss its own way (eGateProg 8; or 9,
//its instrument, which the boss gave it without Instrument Randomization). A save that has the boss keeps its own
//(with Instrument Randomization the instrument is found anywhere: 9 says nothing about the boss)
var i,j,k,L,p;
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
    //(its place in the save's list, as rndBossFromTypes finds it: 0 not there)
    p=string_pos(","+string(global.rndBossType[i])+",",argument0)
    if p>0 {p=string_count(",",string_copy(argument0,1,p))}
    if p=0 or p>argument1
    {
      k=string_char_at(global.eGateProg,global.rndBossGate[i])
      if k="8" or (k="9" and global.rndIRMode=0) {global.rndBossDone=rndSetChar(global.rndBossDone,i+1,"1")}
    }
  }
}
