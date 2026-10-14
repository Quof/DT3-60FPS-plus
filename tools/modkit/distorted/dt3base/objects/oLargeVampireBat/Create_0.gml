event_inherited()
image_speed=0.15

//Enemy base statistics
eName="Large Vampire Bat"
eLevel=10
maxLife=2600
life=maxLife
atkPower=5
resType[1]=4
resType[4]=4
resType[5]=2
stunResist=50
affiliation=3
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
_direction=0
_speed=0

atkProg=0
atkTime=5
atkDelay=64
atkNum=0
atkFreq=19

movePlace=0
moveSpd=0
moveTk=0; tkSpd=0; tkDir=0 //60fps change (added): per-tick latch for the dive/return (see Step)

deathAnim=0

jeremyText="This large bat waits a moment while it gets a target on you, then after a moment, it will strike the spot you are in at that moment. It has a few more tricks up its... err, wing, but nothing you can't handle."
chaoText="It actually works a lot like the original Castlevania boss in the first level. There's a few differences obviously from the Virus take over."
devText="For the first boss of the Gate, I didn't want something too difficult as it's Claire's first few moments with melee combat. It couldn't be too easy either since this is a decent amount of hours into the game. The result is this guy, something that would possibly beat the player only a few times. Plus the giant bat was the first boss encounter of the Castlevania series..."
