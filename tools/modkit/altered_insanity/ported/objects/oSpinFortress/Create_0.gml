event_inherited()
makeActive()
setCollisionBounds(-14,-14,14,14)
bCanTakeDamage=false
bCanDealDamage=false
image_alpha=0

//Enemy base statistics
eName="Advanced Spin Guard"
eLevel=22
maxLife=1500
life=maxLife
pointWorth=16
atkPower=12
resType[1]=3
resType[2]=1
resType[4]=3
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

jeremyText="A troublesome bot with EIGHT shields that spin around it. They wouldn't be much of an issue, but making contact with them will hurt you. If you do decide to go close, be quick with it."
chaoText="I think Jeremy is tired or... wait, we can't get tired in this world. Anyway, these will sometimes spin fast, which indicates they are about to fire. Something in the behavior indicates that their shot will bounce, and that's exactly what it will do."
devText="Another variation! Added 4 more shields in an outer layer, and taking inspiriation from Chao's original comment decided to implement the commented out bouncey bullet feature :) Also each shield shoots a bullet :) :)"

shieldDir=90
shieldDist=240
for(i=0;i<8;i+=1)
{
  shieldPart[i]=instance_create(x,y,oSpinGuardShield)
  if (i < 4)
  {
      shieldPart[i].x=x+lengthdir_x(shieldDist,shieldDir+(i*90))
      shieldPart[i].y=y+lengthdir_y(shieldDist,shieldDir+(i*90))
  }
  else
  {
      shieldPart[i].x=x+lengthdir_x(shieldDist*2,shieldDir+(i*90+45))
      shieldPart[i].y=y+lengthdir_y(shieldDist*2,shieldDir+(i*90+45))
  }
  shdVelX[i]=random_range(-2,2)
  shdVelY[i]=-3-random(2)
  shdVelTurn[i]=random_range(-5,5)
}
