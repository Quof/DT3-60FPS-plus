event_inherited()
makeActive()
setCollisionBounds(-13,-38,13,-1)
image_speed=0
visible=0
bCanTakeDamage=false

//Enemy base statistics
eName="Prototype Lava Beast"
eLevel=28
maxLife=300
life=maxLife
pointWorth=25
atkPower=7
damageType="ELEMENTAL"
resType[0]=2
resType[1]=4
baseItemChance=60
affiliation=6
dieSound=5
dieEffect=0
bCanBeBlocked=1
bParryOpp=0
blockCost=70
runAcc=2
atkTime=25
atkDelay=40
detectDistX=144
detectDistY=144
rising=0
aimAtk=1

_speed=0
_direction=0
deathAnim=0

jeremyText="As you've just seen, these hide in lava most of the time. When they sense you close by, they jump out and start throwing fireballs toward you. They cycle through a faster straight launch, then aim at you with a slower one on the next throw."
chaoText="This is from the SNES game 'Stone Protectors'."
devText="Originally the enemy levels were going to scale up with player level with a min/max for each specific area, but early testing showed that was unnecessary. While the leveling in Gate 6 is made to feel superficial, the scaling still felt awkward. Instead, most enemy spawns have a set level with a very slight variance."
alarm[0]=1
