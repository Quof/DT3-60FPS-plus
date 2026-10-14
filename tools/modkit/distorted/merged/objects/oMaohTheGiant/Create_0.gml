event_inherited()
bCanDealDamage=false
image_yscale=1.5

//Enemy base statistics
eName="Maoh the Giant"
eLevel=16
maxLife=1400 //3200 //spsp ns
life=maxLife
atkPower=6
resType[0]=2
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bombSpamTime=170
bombSpamDelay=350

armSpd=6
spikeLeftSeq=0
spikeLeftTime=60
spikeRightSeq=0
spikeRightTime=120 //150
armSpikeDelay=180 //210

specialAttack=0
specProg=0
specTime=0
specDir=0
wallSpikes=0
//--------------------
moveSpd=0
stepCount=pi/2

//Misc Data
xCenter=336
yGround=240
roomSpan=240

deathAnim=0
spikeOffsetX=87
spikeOffsetY=3
chainFrm=0

body=instance_create(x,y,oMaohBody)
leftSpike=instance_create(x-spikeOffsetX,y+spikeOffsetY,oMaohSpike)
leftSpike.type=1; leftSpike.ownerID=id; leftSpike.atkPower=atkPower; leftSpike.depth=1000001
rightSpike=instance_create(x+spikeOffsetX,y+spikeOffsetY,oMaohSpike)
rightSpike.type=2; rightSpike.ownerID=id; rightSpike.atkPower=atkPower; rightSpike.depth=1000001
