event_inherited()
image_speed=0
xOffset=0
yOffset=0
bCanDealDamage=0

ballTime=0
ballDelay=90
ballScale=1

//Enemy base statistics
eName="REX (who is definitely not Shroudler)"
eLevel=64
maxLife=2000
life=maxLife
pointWorth=66
atkPower=13
stunResist=50
affiliation=7
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
deathAnim=0

handA=0
handB=0
handC=0
handD=0

bHandSpawn=0
bShroudlerBall=0

var shotDir;
shotSpdAdj=0

currHspd=0; currVspd=0
xPoint=0
yPoint=0
maxSpeed=5
if x>=oPlayer1.x {atkSide=1; shotTime=0}
else {atkSide=-1; shotTime=10}
shotDelay=10
shotType=15
bLaser=0
laserDir=0
laserCrawl=0
circleRad=2
circleCol=c_white
myLaser=0
sLordMoveTime=0
sLordMove=0
