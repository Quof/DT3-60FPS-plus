event_inherited()
image_speed=0
xOffset=0
yOffset=0
bCanDealDamage=0

//Enemy base statistics
eName="CHAOS Strikeforce"
eLevel=33
maxLife=390
life=maxLife
pointWorth=62
atkPower=9
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

jeremyText="These guys are super dangerous. A moderate amount of armor for a small flyer too. The first attack is a point explosion missile. It targets the position you are currently at, upon being fired, and will explode in that spot. The other is an undashable laser. The telegraph is easy to see, but you have 1/2 of a second to get away after it stops targeting you."
chaoText="This is from the Mega Man Zero series. I noticed in the behavior that these guys prefer to attack in groups of two and tend to always pin their target."
devText="Spinach here. These were a failure so if you can read this text it means I forgot to remove one instance."
extraInfo="That's an interesting name..."

if global.CHAOS_Upgrade=1
{
  sprite_index=sCHAOS_AdvStrikeforce
  eName="CHAOS Advanced Strikeforce"
  eLevel=38
  maxLife=550
  life=maxLife
  atkPower=10
  pointWorth=95
  jeremyText+=" The advanced version of these give it improved durability and power."
}

myGrapplePoint=instance_create(x,y,oStrikeChainPoint)
myGrapplePoint.visible=0

if room=rWarshipB and global.gameProgress>=5090 {instance_destroy()}
