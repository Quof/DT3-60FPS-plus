GID_SET(260306, self.id)
sprite_index=sNPC_ImportantGuy_Idle
talker="Important Guy"
if global.gameProgress<=2609
  stringToShow="Remember, 'At the great Twin Rocks, the Konami Code is the path to victory.' My guess is it's some sort of code maybe?"
else if global.gameProgress>=2610 and global.gameProgress<=3929
  stringToShow="Seems that Twin Rocks puzzle was no match for your wit."
else if global.gameProgress>=3930
  stringToShow="Your towers were quite the match for CHAOS."
boxSize=2
storyCheck=2571
image_xscale=-1
