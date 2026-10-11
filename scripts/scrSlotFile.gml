/*
save slots change (added): a save slot's file, in the Saves folder (global.saveDir): slot 1 is DT3data.dts (the name the
game's save always had), slots 2-5 are DT3data2.dts to DT3data5.dts. A slot's New Game backup is the same name with
"backup" before ".dts".
argument0: the slot (1-5)
*/
if argument0=1 {return global.saveDir+"DT3data.dts"}
return global.saveDir+"DT3data"+string(argument0)+".dts"
