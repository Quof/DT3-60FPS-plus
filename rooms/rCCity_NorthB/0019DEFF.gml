sprite_index=sNPC_D_Idle
talker="Old Man Sam"
if global.gameProgress<=4180
  stringToShow="The one who wrote the Virus knew what he was doing. He knew what parts of the program to target and how to conceal entities from the program's identification system."
else if global.gameProgress>=4190
  stringToShow="Even though the Virus was removed, I'm still intrigued by it. I stand by my statement before. The guy that wrote it really knew his stuff, but scary that he hates this program that much."
boxSize=3
if global.gameProgress<=1520 {instance_destroy()}
