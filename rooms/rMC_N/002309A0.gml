sprite_index=sNPC_John_Idle
image_speed=0.25
talker="John"
stringToShow="Look around the area. I'm staying here to check something out."
boxSize=1

x+=32
if global.gameProgress<=5010 {y=-128}
else if global.gameProgress>=5040 {instance_destroy()}
if global.bBossGallery=1 {instance_destroy()}
