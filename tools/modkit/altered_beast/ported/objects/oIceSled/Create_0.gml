viscidTop=1
makeActive()

setCollisionBounds(-19,-6,19,6)
event_inherited()


damage=instance_create(x,y,oIceSledDamage)
image_xscale = 1 
curSpd=0
maxSpd = 15
accel = 0.5 * oPlayer1.image_xscale
active = 0
xDir=0
yDir=0
yVel=0
xVel=0
xAcc=0
yAcc=0
maxSlope=6
maxDownSlope=5
gravEffect=false
