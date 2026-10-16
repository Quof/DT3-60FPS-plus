event_inherited()
//Evil Boss Gallery: one of Evil Helmethead's helmets (his heads, come off: his Step makes them, with owner, type,
//polarity, sprite and Helmethead's helmet settings: moveThres, atkDelay, yGround). As a Helmethead helmet it rises to
//its height and drifts along a sine wave, moving toward the player now and then and shooting at them. Its polarity
//(0 red: iron, the sword does nothing; 1 blue: mirror, arrows come back off it) swaps every polDelay ticks, after it
//flashes white for 30. It only takes damage while Helmethead's barrier is up and it isn't broken yet (its polarity's
//weakness, double: breakNeed of it breaks it) or while it's dazed (everything double; that damage hurts Helmethead too,
//at 0.6). mode: 0 drifting, 1 diving at the player (his Step starts it: up above them, a warning line for 30 ticks,
//following them for the first 15, then straight down; anything hitting it then knocks it down dazed), 2 dazed (on
//the floor 75 ticks), 4 circling Helmethead (big, stopping arrows, hurting to touch). It never dies
bActive=true
bCanDealDamage=0
eName="Evil Helmet"
maxLife=99999
life=maxLife
atkPower=4
for(i=0;i<6;i+=1) {resType[i]=1}
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitZelda
image_speed=0

moveProg=0
xSpd=2
moveTime=0
moveThres=20
atkTime=0
atkDelay=85
yGround=160
type=1
owner=noone

polarity=0
polTime=0
polDelay=300
polFlash=0
mode=0
modeT=0
diveStage=0
broken=0
breakDmg=0
breakNeed=900
lifeBefore=maxLife
reflectNow=0
diveHit=0
orbitAng=0
waterFrm=0
