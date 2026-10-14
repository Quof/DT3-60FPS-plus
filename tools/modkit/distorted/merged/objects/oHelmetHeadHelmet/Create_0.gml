event_inherited()
bActive=true
bCanDealDamage=0

//Enemy base statistics
eName="Helmet Head Helmet"
maxLife=2000
life=maxLife
atkPower=4
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitZelda

moveProg=0
xSpd=2

moveTime=0
atkTime=0
bossProg=0
extraBullet=0

myBarrier=0
alphaUp=1
lineAlpha=0.4
waterFrm=0

jeremyText="Helmethead's Helmet... Well that's what it is. It stays in the air while firing periodic bullets at you, and it will also fire revenge bullets when you hit it."
chaoText="So it's an empty suit of armor controlled by a ghost?"
devText="I was going to make these move during the last phase, but that turned out to be incompatible with the 'bullet cage' and having to jump over Helmethead."
extraInfo="Completely immune to damage while shield is active."
