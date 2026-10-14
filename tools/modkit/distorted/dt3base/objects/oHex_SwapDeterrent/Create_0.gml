//Requires: myDir,atkTime
event_inherited()
bActive=true
bCanDealDamage=false; bCanTakeDamage=false
image_alpha=0
image_xscale=3; image_yscale=3

//Enemy base statistics
eName="Hex Swap Deterrent"
eLevel=39
maxLife=1350
life=maxLife
atkPower=16
resType[5]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0

atkProg=0
lightningYscale=1
snapDelay=0

sappingDelay=0
sapProg=0

jeremyText="All I can see is that this deals a ton of damage to you. That said, you slowly recover HP the longer you leave this thing active. The hell? Why would Hex have an ability like this?"
chaoText="While this is latched onto your idle partner, you won't be able to swap to them. Well technically you can, but you'll take a lot of damage. Oh yeah! If you leave this thing active too long, it'll eventually break through that shield. When it does, it'll start to slowly sap away your life points. Also I think Jeremy is seeing false data."
devText="Hex blocks dev commentary."
