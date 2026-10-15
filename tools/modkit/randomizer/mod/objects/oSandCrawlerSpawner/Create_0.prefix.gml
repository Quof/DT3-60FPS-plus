//Randomizer: in a randomizer game the Sand Crawler (Wahfuu Jr., boss type 39) comes up under the player on the sand
//till it's beaten, wherever its fight was (rndBossBeaten), as in the game till its story fight. The game's own has it
//gone by the Deserted Tower's progress (gameOptDT 3), which the endgame world has
if global.rndActive=1
{
  y+=4
  if rndBossBeaten(39) {instance_destroy()}
  exit
}
