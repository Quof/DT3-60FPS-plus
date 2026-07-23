GID_SET(161270, self.id)
sprite_index=sNPC_Matt_Idle
talker="Matt"
if global.gameProgress<=1070
  stringToShow="The guy hiding himself in this house has the access code for the east."
else if global.gameProgress>=1080 and global.gameProgress<=1530
  stringToShow="I completely forgot that it was X that was in here. Sorry about that."
else if global.gameProgress>=1540 and global.gameProgress<=1760
  stringToShow="X headed out to the west for something. It must have been really important."
else if global.gameProgress>=1770 and global.gameProgress<=3900
  stringToShow="Damn, that sucks about X. He was a good friend to us. I hate this Virus and what it's doing."
else if global.gameProgress>=3910 and global.gameProgress<=4500
  stringToShow="I know X would have helped us during the CHAOS offensive on the city."
else if global.gameProgress>=4510
  stringToShow="That ship earlier had the CHAOS insignia on it. We're in some deep fried doo-doo if someone can't take that thing out."
boxSize=2
storyCheck=1010
if global.gameProgress<=1020 {x+=48}
