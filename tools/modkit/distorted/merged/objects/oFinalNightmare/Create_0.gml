event_inherited()
image_speed=0
//Enemy base statistics
eName="Final Nightmare"
eLevel=10
maxLife=10000
life=maxLife
atkPower=4
resType[1]=2
if true {resType[0]=1; resType[1]=4}         //spsp
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

xCenter=560
yGround=288
roomSpan=176
ySpawn=160 //spsp ns

//spsp ns --- spawn height is 160
p1minheight=80
p1maxheight=80+7*16
p1left=xCenter-7*16 //4 tiles away from wall
p1right=xCenter+7*16
p1xrange=64
p1move=0
p1pathtime=60
p1dropstart=0
Lscale=1
Rscale=1
t1x=0
t1y=0
p2sink=0 //3*16
p2border=55 //70
p2falling=65 //80
p2gravity=75 //90
p2dir=5

atkProg=0
//Attack Data
bombTime=0
bombDelay=180

spreadTime=0
spreadDelay=305
spreadCircle=0
atkCircSpd=1

//Arm Data
maxArms=7
armStart=0
dropAtk=370
dropMax=400

//Movement Data
moveSpd=1
moveTime=120
moveSeq=0
stopTime=120 //150

maxSpd=5
maxYDist=104
pDistX=0
pDistOrigX=0

//Face Data
faceTopImage=1
faceImage=0
faceRotate=0
faceSpinCycle=0

//Eye Data
eyeState=0
eyeTime=0
faceAtkTime=0
atkFollowSpc=25 //30
atkFallSpc=5
atkGravSpc=9 //10
atkSpiralAmt=4 //6

//Hand Data
handSpr=sShroudLArm
handLaserTime=0
handLaserDelay=150
laserXOffset=0
targetLaserTime=75
targetLaserDelay=90

//Misc Data
platformMove=0
transform=0
tranSeq=0
tranSize=0
bodySize=12
formSDir=0
formSDist=0
stepCount=0
colorPhase=35
colSeq=0
lifeRefill=0
sLordMoveTime=0
sLordMove=0

deathAnim=0

jeremyText="It's hard to tell what this guy can do. Most of his data is encrypted really well. One thing I do know is he will change his attack pattern often. As for what, I'm not sure, I just know it's not going to be like Link's Awakening."
chaoText="The Nightmare escaped from the Vault and was hiding out here. Maybe we should have talked to him first and used the cutscene pause to our advantage. Also, each phase can only be damaged by one of your weapons." //spsp ns
devText="I had a hard time choosing between this guy and Vaati. The compromise of using one of Vaati's themes is what I went with. Plus the opening to it as the arms are extending went very well together. He goes really well with what you get at the end of these Nightmare Gates as well. The hardest part of designing this was the second phase. Deciding how big to actually make the opening and how long to allow it."
if true {devText="Why did I do this? I don't know. I don't like this fight at all so making it worse is a strange move. If you don't know what to do, well, each phase (barring the 4th) can only be damaged by 1 weapon.#The arms in the first phase don't always go the right distance. I don't care enough to fix this."}
