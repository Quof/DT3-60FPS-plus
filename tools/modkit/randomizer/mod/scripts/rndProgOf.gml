//Randomizer: the progression item an item is (argument0: its kind, argument1: its parameter), as the logic counts them:
//0 jump, 1 ground dash, 2 air dash, 3 double jump, 4 high jump boots, 5-11 ability sets 0-6, rndKeyBase+its door's
//objectNum a key; -1 for the rest
var k;
k=argument0
if k=19 {return 0}
if k=20 {return 1}
if k=21 {return 2}
if k=22 {return 3}
if k=23 {return 4}
if k=24 {return 5+argument1}
if k=14 {return global.rndKeyBase+argument1}
return -1
