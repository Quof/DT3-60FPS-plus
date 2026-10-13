event_inherited()
bCanTakeDamage=false

//Enemy base statistics
eName="King Worm"
eLevel=23
maxLife=4000
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[5]=4
    if global.inBossChallenge
    {
    resType[5]=3
    }
affiliation=5
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=0

initVars=0
alarm[0]=1
