//Randomizer: the new game's options window (the roomStart hook makes it in the intro room in place of the intro). The
//options (global.rndOpt*, as last chosen: rndInit) are for placing the items (rndGenerate) and the rest of the new
//game (rndNewGame). Up/Down: option, Left/Right or Confirm: change it, Confirm on Start Game: the game starts with them.
//Runs on 30fps ticks (oKeyCodes), as the Mods window
roCursor=0
roRows=10 //Seed, Guarantee Early Weapons, Ability Spread, Shop Equipment, Entrance Rando, Boss Rando, Instrument Randomization, Chip Randomizer, Spoiler Log, Start Game
roGo=0 //Start Game chosen: the frames since (the items are placed once the notice has been drawn)
//whatever is held now counts as already held: the Confirm press that started the new game could still be new to
//oKeyCodes on its next tick and change the first option
var i;
for(i=1;i<=18;i+=1)
{
  oKeyCodes.kCode[i]=scrController(i)
  oKeyCodes.kCodePressed[i]=0
}
