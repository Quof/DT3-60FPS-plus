event_inherited()
image_speed=0
bCanDealDamage=false

//Enemy base statistics
eName="Thunderbird"
eLevel=7
maxLife=2750
if global.inBossChallenge
{
    maxLife = 4500
}
life=maxLife
atkPower=5
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
hitSound=global.snd_EnemyHitZelda

rmBd_Left=368
rmBd_Right=720
if global.inBossChallenge = true
{
    rmBd_Left=256
    rmBd_Right=560
}
rmBd_Top=144
rmBd_Bottom=192

bFrameUp=0
animFrame=0

xSpd=-2.5
ySpd=1.2
spikeRise=0

atkTime=0
atkDelay=20
atkDir=1

fastMove=-1
spdMod=1

deathAnim=0

jeremyText="This has been changed quite a bit from its original source. If you're patient, it shouldn't be too bad though. Most of this is fireball spam."
chaoText="It sucked to always have to use half of your Magic to cast the Thunder spell just to be able to hit this thing in Zelda 2. Then cast the Jump, Shield, and Reflect spell, I'd have nothing left to cast Life. What? I always got hit so much on this thing!"
devText="Early on, these bosses were much closer to the originals with very few changes. Later in the project, all of the early bosses got quite a big revamp to set them apart."

if global.inBossChallenge
{
    devText="Thunderbird has more health than Barba since you can really juggle him if you're good, just be careful about those pits! I'm sure you're used to double jump and air dashes, you don't have those here, keep that in mind."
}
