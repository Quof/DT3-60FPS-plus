//Randomizer: Gate 4's stage map's text for a stage (oEvCh8Map: argument0 its cursorPos, argument1 the text the game
//made) with "Items Obtained" counting the stage's locations taken of how many it has (rndMMStageN, rndMMStageLoc:
//rndgen.py), whatever the shuffle put there. A text without a count (-Unknown-, the shop's n/a) stays
var s,t,p,k,n;
s=argument0
t=argument1
if s<1 or s>7 {return t}
p=string_pos("Items Obtained: ",t)
if p=0 {return t}
if string_pos("/",string_copy(t,p,string_length(t)-p+1))=0 {return t}
n=0
for(k=0;k<global.rndMMStageN[s];k+=1) {if rndIsGot(global.rndMMStageLoc[s,k]) {n+=1}}
return string_copy(t,1,p+15)+string(n)+"/"+string(global.rndMMStageN[s])
