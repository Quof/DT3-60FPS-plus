sprite_index=sBubblun_Idle
image_speed=0.05
talker="Bubblun"
y+=64

stringToShow="We're counting on you guys. Stay clear of the Warmaster and focus on taking out the facility first."
boxSize=2

if global.gameProgress<=4180 or global.gameProgress>=4500 {instance_destroy()}
