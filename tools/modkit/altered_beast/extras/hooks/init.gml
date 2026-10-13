//Altered Beast's game variables (Altered Insanity added them to initGameVars). Runs when the mods are loaded and again
//each time the game's variables are set up (a new game, loading a save).

//the equipment altered (1) or not (0): the alterme title screen code, or the Altered Beast
global.alterEquip=0
//options for some of the altered equipment
global.snakeLength=15
global.snakeDelay=2
global.snakeRed=1
global.crouchOnly=1
global.dashOnly=1
global.amuletItem=0
//green health: life lent to special attacks, paid back by dealing damage
global.pGreenLife=0; global.pGreenLifeDamageProgress=0; global.pGreenLifeDamageNeeded=75
//whether the Altered Beast has been met
global.alterIntro=0
//the attacks that can be used (the pause menu's options), and the ones that deal true damage
global.abilitiesEnabled="111111111111"
global.TrueEnabled=0
global.LinkSwordTrue=0
global.LinkArrowTrue=0
global.LinkBombTrue=0
global.XBusterTrue=0
global.XIceTrue=0
global.XGravTrue=0
global.BelmontWhipTrue=0
global.BelmontKnifeTrue=0
global.BelmontWaterTrue=0
global.SamusCannonTrue=0
global.SamusMissileTrue=0
global.SamusBombTrue=0
