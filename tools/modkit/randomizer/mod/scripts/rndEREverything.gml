//Randomizer: whether the entrance randomizer's shuffle (global.rndERPart) is good: with everything (every progression
//item and key), it reaches every place the game's own doors do, and the goal (the Nightmare Gates' bosses, the
//Abomination, the Warmaster). 1 or 0
var i;
for(i=0;i<global.rndEEvBase;i+=1) {global.rndGHave[i]=0}
for(i=0;i<global.rndEHvN;i+=1) {global.rndGHave[global.rndEHvIx[i]]=global.rndEHvC[i]}
rndERReachStart()
for(i=0;i<global.rndELocN;i+=1)
{
  if global.rndEBase[i]=1 {if global.rndRPlace[i]=0 {return 0}}
}
for(i=0;i<global.rndEGoalEvN;i+=1) {if global.rndGHave[global.rndEEvBase+global.rndEGoalEv[i]]<1 {return 0}}
for(i=0;i<global.rndEGoalRmN;i+=1) {if global.rndRRoomIn[global.rndEGoalRm[i]]=0 {return 0}}
return 1
