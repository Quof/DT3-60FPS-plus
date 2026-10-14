/*
Save script.
This will save the game data. (ini)
spsp
Distorted's game over trap (oGameOver, in rLC_LowerPassage): the game is saved to a file of its own, you_dumbnut.dts
(an_idiot_is_you.dts when the save already is that one); hiddenSaveData then puts a new game in the save slot and the game
closes. Renaming the file to the slot's (DT3data.dts, DT3data2.dts...) gets the progress back.
mods change: the original was a copy of saveData that wrote the file in the game's folder; DT3+'s saves (and the mods'
save data, scrModHook "save") are in the Saves folder (global.saveDir), so this saves with DT3+'s saveData, to that file
*/
var tSlot,tName;
tSlot=global.paraString[0]
tName="you_dumbnut.dts"
if filename_name(tSlot)="you_dumbnut.dts" {tName="an_idiot_is_you.dts"}
global.paraString[0]=global.saveDir+tName
saveData()
ini_open(global.paraString[0])
ini_write_string("ABOUT","NOTICE 2","I don't have a reaction image to express how stupid that was. Reflect on your mistake by not changing the name of this save.")
ini_close()
global.paraString[0]=tSlot
