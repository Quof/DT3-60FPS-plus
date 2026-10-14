//global.gateHProg=100; global.eGateProg="99999999"
//viscidTop=1
//makeActive()
event_inherited()
bDamageFlash=0
setNewName=0
dieSound=0
dieEffect=0
bCanBeScanned=1 //0 //really?
bCanDealDamage=false
bCauseKnockback=false
bActive=true
inactiveDist=10000
//change some things!
image_xscale=2; image_yscale=2
bBattleStart=1
bActive=1

backBlend=255
backStep=60

global.currentBoss="Distorted Abomination"

//Enemy base statistics
//eName="Latch Crystal"
maxLife=99999
life=maxLife
bCanDealDamage=false
bShowHealthBar=false
bShowDamagePopout=false
stunResist=50
bIsBoss=true
bNoBonus=true

sequence=0
seqTime=0
damageTaken=0
backBlend=255

dialogueSeq=0
dialogueTime=0

//Hit spot HP counts
myHitCounter=0
myHitSpotHP[0]=2750
myHitSpotHP[1]=2750
myHitSpotHP[2]=2100
myHitSpotHP[3]=1800
myHitSpotHP[4]=2300
myHitSpotHP[5]=2900

//Spawn minions
bMinionSpawn=0
minionTime=550
minionDelay=580

//Attack from bottom
bContinuousAttackA=0
conAtkTimeA=0
conAtkDelayA=125
//Rain attack from top (First)
bContinuousAttackB=0
conAtkTimeB=240
conAtkDelayB=300//-90 //spsp ns
rainAInc=0
rainOffset=0
//Rain attack from top (Second) [Diagonal]
bContinuousAttackC=0
conAtkTimeC=280
conAtkDelayC=320
//Rain attack from top (Third) [Explode]
bContinuousAttackD=0
conAtkTimeD=0
conAtkDelayD=190

spikeScale=0

bkgPartSeq=0
bkgPartTime=0
bkgPartNum=0
bkgX=0
bkgY=0

formWeakSpotX=0; formWeakSpotY=0; formWeakSpotDir=0; formWeakSpotHeartOffsetX=0

warpBorderY=room_height+40
warpBorderYOffset=0
defaultWarpX=240
defaultWarpY=352+64
warpX=0
warpY=0
//myEffect=instance_create()

//camera creation
MyCamera=instance_create(240,528,oMisc)
MyCamera.type=0
MyCamera.sprite_index=sNull
view_object[0]=MyCamera
visaid=instance_create(0,0,oChaoWarpImage)
visaidsub=instance_create(0,0,oChaoWarpImageSub)
spinPhase=0 //spsp ns phase counter
lastCameraPhase=3 //spsp ns last phase that fixes the camera, needed for shaky cam effects

instrumentReq=8 //changed later //spsp ns orignially started at 6
musicPlaying=0
InitialiseInstruments(spinPhase)
InstMoveOn=1
babyVel=3.5 //default is 2
babyGrav=0 //0.1 is orig

yTop=368
//will need to be changed throughout the fight

PhaseOneInitialHeight=352+80
PhaseOneY=PhaseOneInitialHeight
PhaseOneYTime=0
PhaseOneYIncrement=2
PhaseOneWaveDuration=180

//
//instance_create(0,0,oEvAbom)

//other scan info?

jeremyText="I'm busy with the instruments and trying to slow it down. Figure it out yourself.#Oh, I found a way to make its giant hitbox not eat your projectiles. The way this thing messes with data let me do that easily, kinda weird but I'll take it."
chaoText="If you fall too far I set up an automatic warp, you can see where it leads. If you want to change where the warp takes you, mark that location with a right click. Cancel the reticle with another right click to go back to the default location."
devText="Enjoy. Or suffer, I'm happy either way :^)"
