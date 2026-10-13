event_inherited()
image_speed=0
bCanTakeDamage=0

//Enemy base statistics
eName="Barba"
eLevel=6
maxLife=2800
if global.inBossChallenge
{
    maxLife = 3500
}
life=maxLife
atkPower=6
resType[1]=2
resType[4]=4
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
hitSound=global.snd_EnemyHitZelda

atkSpot[0]=288
atkSpot[1]=392
atkSpot[2]=512

for(i=0;i<11;i+=1)
{
  bossBody[i]=instance_create(x,y+16+(i*16),oBarbaBody)
  bossBody[i].waveOffset=i*0.3
}
animDelay=0

atkNum=0
atkCycle=5
atkTime=-20
atkDelay=55
atkType=0
riseHeight=16
sprayDir=0
fireballStorm=0

currentSeq=0
appearSequence[0]=2
appearSequence[1]=0
appearSequence[2]=1
appearSequence[3]=0
appearSequence[4]=2
appearSequence[5]=1
appearSequence[6]=0

deathAnim=0

jeremyText="This thing works fairly close to the original Barba. He sometimes pops in low to blow some fire at ground level across the room. You'll need to react quick to that since he fires almost immediately after popping up."
chaoText="At lower HP, it'll start pulling fire out of the lava as it rises. Try not to be too close to the sides or you'll be hit by the oncoming fireballs."
devText="Originally this was going to be exactly the fight it was in Zelda 2, but that's not very good for DT. In the demo version, he was closer to the original than it is now."

if global.inBossChallenge
{
    devText="I was tempted by the Helmet Head meme for the gate 2 representatives, but these 2 seemed like an interesting combination. I thought it'd be cool to allow players to use all their offensive abilities on the non mario fights here. I decided against giving dash here because it isn't too unmanageable without it. I also boosted their health so they don't crumple before your power."
}
