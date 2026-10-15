//Randomizer: Boss Rando's shuffle read back from the save file's string (argument0: rndBRString(0)'s) into
//global.rndBRFight. Returns 1, or 0 when it isn't one (each boss fought at one place, the final boss at its own): then
//each boss is fought at its own place
var s,i,b,tOk;
s=argument0
tOk=0
if string_length(s)=global.rndBossN*2 {tOk=1}
for(i=0;i<global.rndBossN;i+=1) {tBRUsed[i]=0}
if tOk=1
{
  for(i=0;i<global.rndBossN;i+=1)
  {
    b=real(string_copy(s,i*2+1,2))
    if b<0 or b>=global.rndBossN {tOk=0; break}
    if tBRUsed[b]=1 {tOk=0; break}
    tBRUsed[b]=1
    global.rndBRFight[i]=b
  }
}
if tOk=1 {if global.rndBRFight[global.rndBossFinal]!=global.rndBossFinal {tOk=0}}
if tOk=0
{
  for(i=0;i<global.rndBossN;i+=1) {global.rndBRFight[i]=i}
  return 0
}
return 1
