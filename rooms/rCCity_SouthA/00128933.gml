sprite_index=sNPC_Jamaal_Idle
talker="Jamaal"
if global.gameProgress<=3900
  stringToShow="Got my shopping done, and man is it noisy here."
else if global.gameProgress>=3910
  stringToShow="That CHAOS group actually thought they could get into the city. Not with all our badassness around!"
boxSize=2

if global.gameProgress<=3070 {instance_destroy()}
