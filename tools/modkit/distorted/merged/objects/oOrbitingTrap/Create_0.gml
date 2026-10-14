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
/* Goes on a new object instead.
//spsp ns
if !variable_local_exists("radius")
    radius = 64
if !variable_local_exists("spokes")
    spokes = 6.28 * radius / (2*16)
if !variable_local_exists("deadzone")
    deadzone = 0
*/
//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false
image_index=0 //can be used for colours
