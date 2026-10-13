event_inherited()
makeActive()
setCollisionBounds(-20,-48,20,-1)

//Enemy base statistics
eName="Hamma Jamma"
eLevel=20
maxLife=1200
life=maxLife
pointWorth=29
atkPower=7
resType[0]=2
resType[1]=2
resType[2]=4
resType[5]=2
stunResist=6
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
inactiveDist*=1.5

armSeq=30
armSpd=12

jeremyText="This guy is relentless! Once he starts his attack his arms never retract, they'll just keep chasing you incrementally one after another."
chaoText="Jeremy forgot something again. These have very durable armor, but certain weapons can cut through it pretty quick. When you're dodging the arms, be sure you keep your surroundings in mind since you can't safely dash through them."
devText="This variant came purely because of a bug that appeared from coding the 8 hamma variant."
offsetLeftX=19; offsetLeftY=-41
offsetRightX=-1; offsetRightY=-43

leftBall=instance_create(x+offsetLeftX,y+offsetLeftY,oHammaHammaSpike)
leftBall.ownerID=id; leftBall.atkPower=atkPower-1; leftBall.image_blend=c_ltgray
rightBall=instance_create(x+offsetRightX,y+offsetRightY,oHammaHammaSpike)
rightBall.ownerID=id; rightBall.atkPower=atkPower-1
