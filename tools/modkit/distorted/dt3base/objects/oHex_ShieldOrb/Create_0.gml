//Requires: myDir,atkTime
event_inherited()
bActive=true
bCanDealDamage=false

//Enemy base statistics
eName="Hex Shield Orb"
eLevel=40
maxLife=750
life=maxLife
resType[1]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0

chainFrm=0
myDist=0
shieldProg=0
extendOut=1

atkTime=85
atkDelay=185

jeremyText="These provide Hex with complete invulnerability while they exist. I don't even need to look into their data to get that. Aside from that, they seem to sap energy from Hex, so leaving them around is beneficial... Wait a minute. How does this make any sense? What sort of thing is Hex doing here? Shields that sap his energy?"
chaoText="This guy has all sorts of surprises, I can tell.#There's something really big I found out just now too. All of Hex's attacks that are red outlined will go right through the idle shield, so you can't rely on that if you're trying to hide in the idle partner's shield."
devText="Hex blocks dev commentary."
