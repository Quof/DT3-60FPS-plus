event_inherited()
bCanDealDamage=false
image_blend=make_color_rgb(100,100,100)

//Enemy base statistics
eName="Enmity"
eLevel=14
maxLife=7200
life=maxLife
atkPower=5
resType[0]=2 // spsp; also body (don't ask)
resType[2]=3
resType[1]=2
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bombSpamTime=200
bombSpamDelay=370

rightRegen=0
leftRegen=0

specialAttack=0
specProg=0
specTime=0
specDir=0

secondResistChange=0
//--------------------
moveSpd=0

//Misc Data
xCenter=288
yGround=320
roomSpan=256

deathAnim=0

body=instance_create(x,y,oEnmityBody)
rightBooster=instance_create(x+81,y-30,oEnmityBooster)
leftBooster=instance_create(x-81,y-30,oEnmityBooster); leftBooster.image_xscale=-1
