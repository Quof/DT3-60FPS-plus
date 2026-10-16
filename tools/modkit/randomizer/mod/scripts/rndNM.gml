//Randomizer: whether the player has Nightmare ability argument0 (0 Link's Sword Wave, 1 Mega Man's charge shots stored,
//2 Belmont's Dagger Spam, 3 Samus's Power Bomb), an item in a Randomizer game (kind 28: rndOwn 13-16). The game's code
//for these asks global.bNightmareMode, Nightmare Mode being the only way to have them: the mod's versions of
//playerTechStart and playerTechUse, and its oHUD's meters, ask this too (rndgen.py's SCRIPT_PATCHES, GAME_PATCHES)
if global.rndActive=0 {return false}
return global.rndOwn[13+argument0]>0
