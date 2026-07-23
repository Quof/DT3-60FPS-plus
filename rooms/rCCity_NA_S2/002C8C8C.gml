boxSize=2
if global.gameProgress<=900
  stringToShow="Good luck out there, again, it's great to see all of you are okay."
else if global.gameProgress>=910 and global.gameProgress<=980
  stringToShow="The controls for the city's defenses are at the bridge."
else if global.gameProgress>=990 and global.gameProgress<=1510
  stringToShow="Go and familiarize yourself with this side of the city."
else if global.gameProgress>=1520 and global.gameProgress<=1980
  stringToShow="The west gate is open now. To get there, head west once you leave this house."
else if global.gameProgress>=1990 and global.gameProgress<=2540
  stringToShow="Head toward Magical Hills - East, from there, you'll find the way to the Vault."
else if global.gameProgress>=2550 and global.gameProgress<=3860
  stringToShow="The bridge is located to the east. Check around the south side of the city for anything that might help you locate another Gate."
else if global.gameProgress>=3870
  stringToShow="This is gonna be good. Those guys won't have any idea what hit them."

if global.gameProgress>=3920 {instance_destroy()}
