//Randomizer: the location a pickup is (argument0: its location type, argument1: its objectNum), or -1
if argument1<0 or argument1>130 {return -1}
return global.rndLocOf[argument0,argument1]
