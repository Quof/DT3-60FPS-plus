event_inherited()
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
grace=0
actualSpeed=0
parryTime=0
warpDist=0
anotherTemp=17
prevway=0
fakeNum=6
yDist=0
secondRand=0
chatcool=0
leekX=0
leekY=0
leekAngle=0
applewait=75

//Enemy base statistics
eName="The Executive"
global.currentBoss="Distorted Executive"
eLevel=40
maxLife=40000
life=maxLife
atkPower=14
damageType="ELEMENTAL"
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=6
dieEffect=0
bossProgress=0
activateBoss=0

bCanBeBlocked=1
bParryOpp=0
blockCost=100

phaseNum=6 //Total phases
atkPhase=1 //Current phase
cycleCounter=0
cycleColour=oApRed
tempFlag=0
tempX=0
tempY=0
tempDir=0
tempSeph=-1
sephSup=-4
danceTime=0
lastParryChar=0 //0 is Jerry, 1 is Claire
DOY=288
currHspd=0
currVspd=0
//normal spawn: 800,312

moveProg=0
moveTime=0
currHspd=0
currVspd=0
maxSpeed=4

atkProg=0
for(i=0;i<5;i+=1) {atkTime[i]=0}

newColorFinal=make_color_rgb(150,150,255)

//apple speeds
apsp1=3.5
apsp2=2
apsp3=3
apsp4=4
apsp5=5

//misc. for dance
tempRand=12345
xvel=0
yvel=0
delayPhase1=45
delayPhase2=35
delayPhase3=25

//washing machine trackers
angleOne=0
angleTwo=0
angleThree=0
angleFour=0
redspeed=7.5
otherspeed=5.5

//Misc Data
xCenter=864
yGround=312
roomSpan=192
//bounce phase
bounceXleft=704
bounceXright=1024
bounceYtop=64
bounceYbottomLow=272
bounceYbottomHigh=128 //second half of bounce phase
phaseTwoSpeed=0

Tright=1056
Tleft=672
Thigh=0
Tlow=352

for(i=0;i<3;i+=1) {exVal[i]=0}

deathAnim=0

alarm[0]=1
