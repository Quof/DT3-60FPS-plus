//Requires: rotSpd,rotMax
event_inherited()
sprite_index=sScaledCollision
maxSize=184 //8*23
image_xscale=maxSize
image_yscale=4

//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false
rotatePhase=0
rotTime=0

colPhase=0
colTime=255
bWaggle=0
myDir=0

rotMax=180
image_angle=90*((y/16) mod 4)
rotSpd=2*(2*((x/16) mod 2)-1)
