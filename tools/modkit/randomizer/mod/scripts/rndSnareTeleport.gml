//Randomizer: a Teleport Trap takes the player to one of the ways into a room they've come in by this run
//(rndSnareHist), at random: one into another room than this one. The room they come to says what happened
//(rndSnareArrive: rndSnareRoom). With none yet (only this room's), nothing happens. The caller has seen to it that it
//can happen now (rndSnareCanGo)
var n,i,k,tC;
global.rndSnarePend=0
n=0
for(i=0;i<global.rndSnareHistN;i+=1)
{
  if global.rndSnareHistR[i]!=room and room_exists(global.rndSnareHistR[i]) {tC[n]=i; n+=1}
}
if n=0 {rndMsg("The Teleport Trap fizzles:#there's nowhere else you've been yet.",2); exit}
k=tC[irandom(n-1)]
global.rndSnareArrive=1
global.newMapX=global.rndSnareHistX[k]
global.newMapY=global.rndSnareHistY[k]
with (oPlayer1) {writeToPlayerGlobals()}
transition_kind=0
rndHLEnter(global.rndSnareHistR[k]) //(a Highlands room is made as before the CHAOS Warship's attack)
room_goto(global.rndSnareHistR[k])
