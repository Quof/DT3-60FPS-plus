event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
bInfected=0

//Enemy base statistics
eName="Facility Drone"
eLevel=31
maxLife=480
life=maxLife
pointWorth=45
atkPower=10
resType[1]=2
resType[4]=4
stunResist=4
baseItemChance=65
baseDropIndex=90
moneyWorth=5

runAcc=2
turnTime=0
shotTime=20
shotDelay=75
lineW=1

bIsBoss=1
chaoText="Jeremy, you and Jerry don't like this thing much. Is there bad blood between you and this bot type?"
devText="I always wanted to bring this enemy back from the first game and this place seemed like the perfect spot to bring them back for."

myInfectSpot=instance_create(x,y,oInfectMe)
myInfectSpot.myOwner=id

if room=rC5_Arena6 and x = 400 //for challenge spawn
{
    image_xscale=-1
}
