event_inherited()
makeActive()
setCollisionBounds(-14,-14,14,14)
bCanTakeDamage=false
bCanDealDamage=false
image_alpha=0

//Enemy base statistics
eName="Advanced Spin Guard"
eLevel=22
maxLife=800
life=maxLife
pointWorth=16
atkPower=10
resType[1]=3
resType[2]=1
resType[4]=5
resType[5]=2
stunResist=2
baseItemChance=60
baseDropIndex=90
moneyWorth=5
dieSound=0
dieEffect=0
runAcc=1
inactiveDist*=1.25

initSeq=0
shotTime=30
shotDelay=110

deathAnim=0

jeremyText="A troublesome bot with a hex ring that spins around it. They wouldn't be much of an issue, but it's equipped with a hex ring, and it blocks your projectiles, what a monstrosity."
chaoText="Bombs do the most damage to these guys, but it'll be tough sneaking it inside the ring."
devText="Okay I'm making too many variants of this guy lol. It's just too obvious to equip em with this! Hope you're good at basketball!"

shieldDir=90
shieldDist=240
for(i=0;i<1;i+=1)
{
  shieldPart[i]=instance_create(x,y,oHexBlockCircle)
  shieldPart[i].x=x+lengthdir_x(shieldDist,shieldDir+(i*90))
  shieldPart[i].y=y+lengthdir_y(shieldDist,shieldDir+(i*90))
    shieldPart[i].spinSpd=-8
    shieldPart[i].changeDelay=0
    shieldPart[i].moveSpd=0
    shieldPart[i].image_xscale=0.75
    shieldPart[i].image_yscale=0.75
  shdVelX[i]=random_range(-2,2)
  shdVelY[i]=-3-random(2)
  shdVelTurn[i]=random_range(-5,5)
}
