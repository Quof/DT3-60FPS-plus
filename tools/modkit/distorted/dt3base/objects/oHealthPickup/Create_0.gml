makeActive()
setCollisionBounds(-5,-5,5,5)
image_speed=0.25
image_xscale=2
image_yscale=2
yVel=-4
yVelLimit=8
decayTime=450
if global.location=15 or global.location=103 {sprite_index=sCVChicken}
if global.location=29 or global.location=104 {sprite_index=sMMHealthPickup}
if global.location=49 or global.location=106 {sprite_index=sMetroidHealthPickup}
alarm[0]=1
