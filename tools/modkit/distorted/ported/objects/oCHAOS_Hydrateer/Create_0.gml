event_inherited()
image_speed=0
xOffset=0
yOffset=0
bCanDealDamage=0

//Enemy base statistics
eName="CHAOS Rocketeer"
eLevel=33
maxLife=390
life=maxLife
pointWorth=62
atkPower=9
if true and (room=rNGC_LC_C or room=rNGC_LC_D) {atkPower=80}     // spinach special
resType[5]=2
stunResist=9
baseItemChance=70
moneyWorth=5
affiliation=7
dieSound=0
dieEffect=0

currHspd=0; currVspd=0
xPoint=0
yPoint=0
maxSpeed=8
if x>=oPlayer1.x {atkSide=1; shotTime=0}
else {atkSide=-1; shotTime=10}
shotDelay=40
shotType=0
bLaser=0
laserDir=0
laserCrawl=0
circleRad=2
circleCol=c_white
myLaser=0
bNormalResist=0
_hspeed=0
_vspeed=0

deathAnim=0

jeremyText="Read the name."
chaoText="Oh no."
devText="What's the worst that could happen?"


  sprite_index=sCHAOS_AdvRocketeer
eName="CHAOS Hydra Rocketeer"
  eLevel=38
  maxLife=550
  life=maxLife
lifeTrack=life
  atkPower=10
  pointWorth=95
