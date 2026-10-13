event_inherited()

image_speed=0.4

maxSpeed=16

bTargetActive=1
chaoTargetFrm=0
chaoTargetX=x
chaoTargetY=y

//boss variables
//Enemy base statistics
eName="Chao"
eLevel=99
maxLife=10000
life=maxLife
atkPower=8
damageType="ELEMENTAL"
bCanDealDamage=false
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

//-- Attack Data --
roundNum=0 //number of attack cycles
waitTime=0
waitDelay = 60
actTime=0 //progress in an action
actPhase = 0 //action phase progress
actIterations = 0 //certain actions will happen more than once
actIterationDelay = 0 //certain iterations should be delayed by a bit
actCheck=0 //choosing an action
actPrevious=0

circleTransformIntent = 0
circleColorIntent = 0

explodeCircleDelay = 3

moveType=-1
xVel=0; yVel=0
imageEffect=0

specialAttack=0
specProg=0
specTime=0
//--------------------

//Misc Data
roomFloor = 304
roomHeight = 256
xCenter=368
roomSpan=416

minX = 176
maxX = 560
minY = 64
maxY = 288

flyDuration = 0
flySpeed = 15
flyTime = 0
flyDelay = 20

currentCircle = 0


oIdentifier.bChaoActive=0
