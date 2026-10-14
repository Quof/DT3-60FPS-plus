event_inherited()
image_speed=0
image_xscale=-1

//Enemy base statistics
eName="Sera"
eLevel=32
atkPower=8      //spsp moved for Fun Palace purposes, from below life=maxLife
maxLife=8500
if room=rSerasFunhouse      //spspDDLC
{
    maxLife=12000
    atkPower=13
    eLevel=64
    if global.newMapX=366   //marriage
    {
        maxLife=7000
        atkPower=9
        eLevel=40
    }
}
life=maxLife
resType[2]=1
damageType="ELEMENTAL"
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
//-- Attack Data --
atkNum=0 //current attack in string
atkMax=2 //max attacks in a string
roundNum=0 //number of attack cycles
waitTime=55
waitDelay=85-5 //spsp //idle time between attack strings
actTime=0 //progress in an action
actCheck=0 //choosing an action
bigBlockChk=0

moveType=-1
xVel=0; yVel=0
imageEffect=0

specialAttack=0
specProg=0
specTime=0
//--------------------

//Misc Data
xCenter=368
roomSpan=272
yGround=288

deathAnim=0
