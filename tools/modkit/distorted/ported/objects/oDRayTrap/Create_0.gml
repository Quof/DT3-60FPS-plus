event_inherited()
bShowHealthBar=false

//Enemy base statistics
eName="Ray Trap"
eLevel=15
maxLife=100
life=maxLife
atkPower=5
if global.location=90 {atkPower=12} //spsp ns, actual attack is this +3
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
affiliation=4
hitSound=global.snd_EnemyHitMM

checkArea=0
fireTime=0

jeremyText="This is always stationary, treat it like a trap. However, if you touch the lasers created by the sensors, all the Ray Traps close by will fire a very fast laser at you. Don't be fooled by the damage output above. That's simply contact damage, the laser has an output rating of 8."
chaoText="You could just dash your way through the problems these things give you.#... ... ...#What? I was trying to give useful advice!"
devText="Not to spoil anything, but this is an enemy type that will show up outside of this Gate. There's quite a few uses for such a thing."
extraInfo="Completely immune to damage."
