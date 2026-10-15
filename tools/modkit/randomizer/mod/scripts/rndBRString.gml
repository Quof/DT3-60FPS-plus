//Randomizer: Boss Rando's shuffle as a string for the save file, two digits a boss (argument0 0: the boss fought at each
//boss's place, rndBRFight; 1: the bosses' types, so a build with other bosses can tell)
var i,s,t;
s=""
for(i=0;i<global.rndBossN;i+=1)
{
  if argument0=0 {t=string(global.rndBRFight[i])}
  else {t=string(global.rndBossType[i])}
  s+=string_repeat("0",2-string_length(t))+t
}
return s
