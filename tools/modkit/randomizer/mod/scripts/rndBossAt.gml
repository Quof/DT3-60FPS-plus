//Randomizer: the boss whose fight is in a room (argument0: the room), or -1
var b;
for(b=0;b<global.rndBossN;b+=1) {if global.rndBossRoom[b]=argument0 {return b}}
return -1
