talker="Issac"
if global.gameProgress<=2560
  stringToShow="It's so good to be able to finally come out of hiding. Looks like you saved our asses again, Jerry."
else if global.gameProgress>=2570 and global.gameProgress<=3900
  stringToShow="Looks like we didn't get the bridge in perfect condition yet, but at least you can cross it now."
else if global.gameProgress>=3910 and global.gameProgress<=4500
  stringToShow="I could see the battle you had with CHAOS from the bridge. Just wow, they stood no chance."
else if global.gameProgress>=4510
  stringToShow="Seriously man, who even builds a ship that big? What would you ever need a ship that size for?"
boxSize=2

if global.gameProgress<=980 {instance_destroy()}
else if global.gameProgress>=2570 {y-=16}
