/*
Variables that need to be set on creation:
swingSpeed  : How fast the trap orbits
orbitDist   : How far the orbit is from the center
dir         : Starting direction from the center
drawLine    : Whether to draw a line from the center to the trap: 0-No, 1-Yes

swingSpeed,orbitDist,dir,drawLine
*/
event_inherited()
sX=x
sY=y

//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false
