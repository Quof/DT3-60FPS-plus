event_inherited()
bCanDealDamage=false
bActive=true

//Enemy base statistics
eName="Wall Block"
eLevel=10
maxLife=100
life=maxLife
pointWorth=10
atkPower=5
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=3
stunResist=50
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3
_speed=0
_direction=0

atkProg=0
atkTime=0
colorOther=255

jeremyText="Nothing really note worthy about these except that you can destroy them, which I'd recommend you do."
chaoText="You know what these are, just the floor tiles."
devText="These were considered traps right up until the very end of development, where I changed them into an enemy type so the player could destroy them with explosives."
