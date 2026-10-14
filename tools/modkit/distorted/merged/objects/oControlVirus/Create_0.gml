event_inherited()

//Enemy base statistics
eName="Control Virus"
eLevel=10
maxLife=1700
life=maxLife
atkPower=5
if true {resType[0]=2}   //spsp
resType[1]=2
resType[3]=2
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
xCenter=264
yGround=288
roomSpan=136

deathAnim=0

for(i=0;i<3;i+=1)
{
  turretSummon[i]=i*200
  atkTurret[i]=0
}
turretDelay=480

laserSummon=120
laserDelay=500
lineA_Length=0
lineB_Length=0

wrenchSummon=1020
wrenchDelay=510

jeremyText="It only has 2 attacks. The first are the turrets it summons on the walls. It will summon up 2 on the right side and 1 on the left. Take them out quickly, not for just your health, but the health of your Pincher Bot. The other attack is its Laser Bots. Take them out as quickly as possible."
chaoText="This is the Virus attempting to control the city's defense grid. Once it loads itself completely into that system, there will be no removing it, so you need to get rid of it before the upload is complete."
devText="Making timed scenarios, whether it be boss encounters or not, always seems like a risky thing to do. After deciding the boss HP and the timer, everything else was based on those two values. I knew I wanted a quick and intense encounter. There was no one thing that gave me the most trouble when designing this. Every change affected the outcome to a great degree."
if true {devText="This is pretty self-explanatory."}
