event_inherited()
makeActive()
setCollisionBounds(-14,-14,14,14)
bCanTakeDamage=false
bCanDealDamage=false
image_alpha=0

//Enemy base statistics
eName="Advanced Spin Guard"
eLevel=22
maxLife=690
life=maxLife
pointWorth=16
atkPower=10
resType[1]=4
resType[2]=1
resType[4]=4
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

jeremyText="A troublesome bot with four shields that spin around it. They wouldn't be much of an issue, but making contact with them will hurt you. If you do decide to go close, be quick with it."
chaoText="I think Jeremy is tired or... wait, we can't get tired in this world. Anyway, these will sometimes spin fast, which indicates they are about to fire. Something in the behavior indicates that their shot will bounce, but it isn't in this version of them. Looks like it was commented out since it wasn't finished."
devText="My first enemy variant. Wondered what it'd be like with 2 more shields, making tighter gaps to shoot through (or you could use charge arrows I suppose, if you remember those exist...)"

shieldDir=90
shieldDist=240
for(i=0;i<4;i+=1)
{
  shieldPart[i]=instance_create(x,y,oSpinGuardShield)
  shieldPart[i].x=x+lengthdir_x(shieldDist,shieldDir+(i*90))
  shieldPart[i].y=y+lengthdir_y(shieldDist,shieldDir+(i*90))
  shdVelX[i]=random_range(-2,2)
  shdVelY[i]=-3-random(2)
  shdVelTurn[i]=random_range(-5,5)
}
