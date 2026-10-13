//Randomizer: whether a heart container's place is open (argument0: its objectNum): the boss after whose fight the game
//gives it has been beaten (rndData's rndHCBoss; -1: no boss)
var b;
if argument0<0 or argument0>7 {return 1}
b=global.rndHCBoss[argument0]
if b<0 {return 1}
return string_char_at(global.rndBossDone,b+1)="1"
