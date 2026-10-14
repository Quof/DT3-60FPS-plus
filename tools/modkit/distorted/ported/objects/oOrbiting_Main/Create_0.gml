/*
Variables that need to be set on creation:
rotSpd        : rotation speed in degress
radius        : radius in pixels
spokes        : number of "hands"
deadzone      : size of the deadzone in degrees
lineON        : whether to draw lines to the hands, boolean
dye           : image_index of the hands
hand          : what object to use as hands
handPower     : sets new atkPower for the hands
swingSpeed  : How fast the trap orbits
swingSpeed  : How fast the trap orbits

swingSpeed,orbitDist,dir,drawLine
*/
event_inherited()
sprite_index=sScaledCollision //hides the map symbol in actual play

//spsp ns
if !variable_local_exists("rotSpd") //in degrees
    rotSpd = -3
if !variable_local_exists("radius")
    radius = 64
if !variable_local_exists("spokes")
    spokes = floor(6.2832 * radius / (5*16))
if !variable_local_exists("deadzone") // not working atm
    deadzone = 0
if !variable_local_exists("lineON")
    lineON = true
if !variable_local_exists("dye")
    dye = 0
if !variable_local_exists("hand")
    hand = oDamageBall
if !variable_local_exists("handPower")
    handPower = 0

//Enemy base statistics
atkPower=0
bCanDealDamage=false
bCanTakeDamage=false
bShowHealthBar=false

lineWidth=1

rotation=0

omegaDist = (360 - deadzone) / spokes //offset between spokes, in degrees

for(i=0;i<spokes;i+=1)
{
  myPoints[i]=instance_create(x,y,hand)        //spsp
  myPoints[i].image_index=dye
  if handPower>0 {myPoints[i].atkPower=handPower}
}
