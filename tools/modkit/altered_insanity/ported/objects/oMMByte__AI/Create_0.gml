event_inherited()
makeActive()
setCollisionBounds(-24,-78,24,-1)
image_speed=0

//Enemy base statistics
eName="X Hunter - Byte"
eLevel=18
maxLife=3000
    if global.inBossChallenge
    {
    maxLife = 3500
    }
life=maxLife
atkPower=7
resType[0]=2
resType[1]=2
resType[2]=2
resType[5]=4
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
actionState=0
atkProg=0
runAcc=8

//Misc Data
xCenter=240
yGround=288
roomSpan=176

deathAnim=0
