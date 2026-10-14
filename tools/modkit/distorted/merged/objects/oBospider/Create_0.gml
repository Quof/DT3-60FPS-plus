event_inherited()
image_speed=0
image_xscale=2.4
image_yscale=2.72

//Enemy base statistics
//eName="Bospider"
eName="Arachnus"       //spsp
eLevel=18
maxLife=2500
life=maxLife
atkPower=7
resType[0]=2
resType[1]=2
resType[2]=4
resType[5]=2
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
imageEffect=0
eyeFrm=2 //0
legFrm=0
moveSpd=4
mvBudget=0 //60fps change (added): pixels still to move this tick while climbing down (see Step)

webUsed=0
dirMove=0
spiderThrow=0
numOfDescents=0

atkProg=-1
atkTime=0
atkDelay=15 //30 //spsp ns

//Misc Data
xCenter=240
yGround=256
roomSpan=112

deathAnim=0

body=instance_create(x,y,oBospiderBody)
