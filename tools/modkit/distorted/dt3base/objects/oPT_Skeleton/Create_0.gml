event_inherited()
makeActive()
setCollisionBounds(-19,-45,19,-1)
sprite_index=sPT_Skeleton_Rise
image_speed=0
visible=0
bCanDealDamage=false
bCanTakeDamage=false

//Enemy base statistics
eName="Prototype Skeleton"
eLevel=28
maxLife=300
life=maxLife
pointWorth=35
atkPower=7
resType[3]=1
resType[5]=4
baseItemChance=65
affiliation=6
dieSound=5
dieEffect=0
bCanBeBlocked=1
bParryOpp=0
blockCost=50
detectDistX=176
detectDistY=144

bJumpReady=1
bBlocking=0
rising=0
runAcc=2.25
turnTime=20
atkTime=20
atkDelay=35

_speed=0
_direction=0
deathAnim=0

jeremyText="When you attack this from the front, if it's not attacking, it will guard. Best way to deal with this is to either sneak in an attack while it's attacking or parry. I suppose you could jump over it too."
chaoText="This comes from the game 'King of Dragons'. In that game, they could also throw spears, but it doesn't look like this has access to that."
devText="When designing the parry system, it went through quite a few iterations. The original idea is what the game has now, but I toyed with both characters having their own shield meter, as well as both having the same shielding mechanics. I wanted to further separate the playstyles and make them fit with their intended ranges, so a lot of them were thrown out pretty quick."
alarm[0]=1
//skeleton sparkle change (added): with the Skeleton Sparkle dipswitch (global.skeletonSparkle), the weapon sparkle
//(oG6_CounterSpark) comes later and follows the blade (Step); off, it's the original one at the start of the swing.
//sparkDone: the current swing's sparkle has been made; sparkID: that sparkle
sparkDone=1
sparkID=noone
