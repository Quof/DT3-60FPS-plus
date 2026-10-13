event_inherited()
makeActive()
setCollisionBounds(-20,-48,20,-1)

//Enemy base statistics
eName="Hamma Hamma Hamma Hamma Hamma Hamma Hamma Hamma"
eLevel=20
maxLife=590
life=maxLife
pointWorth=29
atkPower=12
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
armSpd=10

jeremyText="These work pretty much exactly like the original except now it has 8 hammas. It will wait a moment and then send a spiked arm toward you, then follow up with the others. Its reach is pretty limited, but the arms do block projectiles."
chaoText="Jeremy forgot something again. These have very durable armor, but certain weapons can cut through it pretty quick. When you're dodging the arms, be sure you keep your surroundings in mind since you can't safely dash through them."
devText="This is the second enemy I decided to vary up on. So far I'm doing ones that have separate components and adding more, along with other twists."
offsetLeftX=19; offsetLeftY=-41
offsetRightX=-1; offsetRightY=-43
yDiff = 0
ballsets=4
currentBallset = 0
for (i = 0; i < ballsets; i+=1)
{
    leftBall[i]=instance_create(x+offsetLeftX,y+offsetLeftY-i*yDiff,oHammaHammaSpike)
    leftBall[i].ownerID=id; leftBall[i].atkPower=atkPower; leftBall[i].image_blend=c_ltgray
    rightBall[i]=instance_create(x+offsetRightX,y+offsetRightY-i*yDiff,oHammaHammaSpike)
    rightBall[i].ownerID=id; rightBall[i].atkPower=atkPower
}
