event_inherited()
image_speed=0
bCanDealDamage=false

//Enemy base statistics
eName="Thunderbird EX"
eLevel=40
maxLife=7000
life=maxLife
atkPower=12
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
hitSound=global.snd_EnemyHitZelda

resType[0]=3
resType[1]=3
resType[2]=3
resType[3]=1
resType[4]=3
resType[5]=3

rmBd_Left=368
rmBd_Right=720
//rmBd_Top=144
rmBd_Top=112
//rmBd_Top=176
rmBd_Bottom=192

shieldUp=0      //to (or plus) 1 with res increases at points; breakable with bombs
weakcheck=0     //essentially another bossProgress variable, used for shield resistances (during and post)

bFrameUp=0
animFrame=0

xSpd=-3
ySpd=1.6
spikeRise=0

atkTime=0
atkDelay=25
atkDir=1

fastMove=-1
spdMod=1
cycle=0
boltCycle=3
boltSpeed=5.5

deathAnim=0

jeremyText="This isn't too bad really. His projectiles are scarier than before and he has a Ridley-like shield thing going on, but it's nothing you can't beat."
chaoText="But thunder is not the same thing as lightning, the name is still wrong!"
devText="One thing about distorted mode that was well-received was the Firebird miniboss in the water palace. The thing is, I never explicitly coded that to have fewer actions than the original, it just behaved that way when I tested it. I though that was nice and didn't investigate further or try to fix it, so it was funny when people talked about it as if it was a result of effort on my part."
