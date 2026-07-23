sprite_index=sNPC_Jamaal_Idle
talker="Jamaal"
if global.gameProgress<=2560
  stringToShow="The path to the west side of the city is open again, go look. Though with the bridge down, we can't get to the south side."
else if global.gameProgress>=2570
  stringToShow="The bridge to Central City - South is open again. It's about time too, I had some shopping to do down there."
boxSize=2

if global.gameProgress<=980 or global.gameProgress>=3080 {instance_destroy()}
