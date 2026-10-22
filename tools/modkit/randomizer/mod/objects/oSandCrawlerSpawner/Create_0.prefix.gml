//Randomizer: in a randomizer game the Sand Crawler (Wahfuu Jr.) comes up under the player on the sand till the fight in
//its room in the Deserted Tower (rDesertedTowerD) is won: with Boss Rando, the boss fought there (the logic's event for
//it is that room: roomlogic\events.txt's sandcrawler), as in the game till its story fight. The game's own has it
//gone by the Deserted Tower's progress (gameOptDT 3), which the endgame world has
if global.rndActive=1
{
  y+=4
  var b;
  b=rndBossAt(rDesertedTowerD)
  if b>=0 {if string_char_at(global.rndBossDone,b+1)="1" {instance_destroy()}}
  exit
}
