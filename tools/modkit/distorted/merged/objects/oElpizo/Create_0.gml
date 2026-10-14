// water and water and water water (2 min version) for some water sections
//make John's damage scale with cheese?

event_inherited()
makeActive()
setCollisionBounds(-21,-40,21,-1)
image_speed=0
image_xscale=-1
bCanTakeDamage=false

//Enemy base statistics
eName="Elpizo"
eLevel=20
//maxLife=5600
maxLife=4480 //with resistance changes, this keeps the effective max health constant.
life=maxLife
atkPower=7
resType[0]=3
resType[1]=3
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

//-- Movement Data --
moveSpd=9
chargeArc=3
_speed=0
_direction=0

//-- Neutral Data --
currentAction=0
lastAction=0
attackDelay=0
waitTime=35 //45; gets -38 total from bossProgress (changed to 28)

//-- Dark Needle Data --
needleEnd=30
needleSpc=12
needleMod=5

//-- Bubble Data --
bubbleDecay=60

//-- Portal Data --
portalAction=0
portalDecay=180
portalArc=3

//-- Defense Data --
actNoTele=1
teleInc=0.75

//-- Special Data --
specProg=0
specTime=0
specMax=1800
specBackAlpha=0
specHP=15
specDir=0
maxSpeed=2
currHspd=0; currVspd=0
timeMod=0 //At 33% HP, if the Desperation attack has not been used at least once, the bar fills faster until the attack occurs

//-- Misc Data --
xCenter=448
yGround=416
roomSpan=320

// spsp ns data
playerClose=96 // 5 tiles
yMercy=64 //32, looped too easily
halfAngle=45
bottomActCount=1
distanceToPlayer=0
bubbleHeight=80
jumpFlag=0
topThresh=178
midThresh=274
quadJump=0
doubleRush=0
turretMode=0
portFlag=0
pain=-1
firstLoc=1
threshOne=0.75
threshTwo=0.5
threshThree=0.25

nightmareZoneA=-1
nightmareZoneB=-1
nightmareZoneC=-1
nightmareZoneD=-1

deathAnim=0

jeremyText="This guy has a number of actions which all look to become harder as he's damaged. He has a move where he'll jump back and throw a super fast projectile toward you. If you don't have a dash ready when you're nearby, there's no chance of dodging it. There's also these nifty portal looking things that he'll use to shield himself. They will also heal him, so make sure to take them out quickly."
chaoText="Elpizo is the antagonist of Mega Man Zero 2. Though in the end he wasn't really a villain. I guess I can see why the program read him in as hostile. That or the Virus is messing with things. At times, Elpizo will summon up those nightmare zones that slow down projectiles. Damaging his shielding portals charges his special gauge, but destroying them reduces it."
devText="I don't think this was a well-liked boss in vanilla (Personally I didn't like it at all), so I put a good amount of effort into changing his AI to hopefully make for a more enjoyable fight."
extraInfo="Capable of shielding and being annoying."

myHS=instance_create(x,y,oElpizoHitSpot)
