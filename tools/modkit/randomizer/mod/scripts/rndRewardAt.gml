//Randomizer: a Nightmare Gate's reward (argument0: the gate, 1-8: its location, type 18) made at a place (argument1,
//argument2: it falls to the ground from there: oRndReward), unless it's been taken
var L,t;
L=rndLocFind(18,argument0)
if L<0 {exit}
if rndIsGot(L) {exit}
t=instance_create(argument1,argument2,oRndReward)
t.objectNum=argument0
