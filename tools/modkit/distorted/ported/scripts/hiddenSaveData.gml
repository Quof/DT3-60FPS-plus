/*
Save script.
This will save the game data. (ini)
spsp
Distorted's game over trap (see sneakySaveData): after initGameVars, the save slot gets a new game, with no room saved
(130 is 0), so loading it starts the game over.
mods change: the original was a copy of saveData; this saves with DT3+'s (its Saves folder, the mods' save data), then
takes the room out
*/
saveData()
ini_open(global.paraString[0])
ini_write_real("ALPHA","130",0)
ini_write_string("ALPHA","130mod","")
ini_close()
