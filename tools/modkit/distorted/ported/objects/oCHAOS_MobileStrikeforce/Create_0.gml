event_inherited()
image_speed=0
xOffset=0
yOffset=0
bCanDealDamage=0

//Enemy base statistics
eName="CHAOS Mobile Strikeforce"
eLevel=33
maxLife=390
life=maxLife
if variable_local_exists("newHP") {life=newHP}
pointWorth=62
atkPower=9
resType[5]=2
if room=rSF_D {resType[4]=1}
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

jeremyText="For whatever reason, these upgraded(?) Rocketeers can be grappled. They won't stop attacking while grappled, so be careful. Their attacking behaviour is the same as the base version."
chaoText="This is from the Mega Man Zero series. I noticed in the behavior that these guys prefer to attack in groups of two and tend to always pin their target."
devText="These guys were a failure in the original distorted. Grappling them just doesn't mesh with their movement pattern. Let's see how they do as hostile strike points."

if global.CHAOS_Upgrade=1
{
  sprite_index=sCHAOS_AdvMobStrikeforce
  eName="CHAOS Advanced Mobile Strikeforce"
  eLevel=38
  maxLife=550
  life=maxLife
  if variable_local_exists("newHP") {life=newHP}
  atkPower=10
  pointWorth=95
  jeremyText+=" The advanced version of these give it improved durability and power."
}

myGrapplePoint=instance_create(x,y,oStrikeChainPoint)
myGrapplePoint.visible=0
