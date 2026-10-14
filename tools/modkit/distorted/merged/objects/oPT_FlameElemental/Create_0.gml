event_inherited()
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

//Enemy base statistics
eName="Lv.?? The Flame Elemental"
eLevel=28
maxLife=3500
if room=rMain_45 {maxLife=35000}        //spsp
life=maxLife
atkPower=10
damageType="ELEMENTAL"
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=6
dieEffect=0
bossProgress=0
activateBoss=0

if room=rMain_45 {bActive=1}        //spsp

bCanBeBlocked=1
bParryOpp=0
blockCost=100

firstSpawn=0
waitTime=0
atkAmt=8
atkCycle=0
atkChange=0
myDir=0

//--------------------

//Misc Data
xCenter=712
yGround=304
roomSpan=136
if room=rMain_45 {xCenter=416; yGround=352; roomSpan=152}        //spsp

deathAnim=0
