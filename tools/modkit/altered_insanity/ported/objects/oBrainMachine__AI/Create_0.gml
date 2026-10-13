event_inherited()
bCanDealDamage=false

//Enemy base statistics
eName="Brain Machine"
eLevel=33
maxLife=8300
    if global.inBossChallenge
    {
        maxLife=6500
    }
    if room=rC5_NoWalkBoss
    {
        maxLife = 9100
        eName="Cosmic Brain Machine"
    }
life=maxLife
atkPower=9
resType[0]=2
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bossPhase=1
armsRotation=0
rotateSpd=2
xSpd=0
moveDir=1

shotTime=60
if room=rC5_NoWalkBoss
{
    shotDelay=180
}
else
{
shotDelay=120
}
bulletNum=8

bArmLaser=0
armLaserTime=110
armLaserDelay=150
laserType=0
armMax=1
armNum=0

midLaserTime=150
midLaserDelay=350
midLaserDur=90

floorTrapTime=170
floorTrapDelay=330
floorTrapDuration=300

circleRad=0
barrierTime=0
barrierSet=0
//--------------------

//Misc Data
xCenter=288
yGround=288
if room=rC5_NoWalkBoss
{
    yGround = 400
}
roomSpan=224
yCenter=160

deathAnim=0


for(i=0;i<4;i+=1)
{
  if room!=rC5_NoWalkBoss
  {
  myGrapplePoints[i]=instance_create(x,y,oStrikeChainPoint)
  }
  armBlend[i]=c_white
}
