event_inherited()
//Evil Boss Gallery: Evil Helmethead (rEvgHelmet). Helmethead's fight (oHelmetHead's, its variables set up here the same
//way), with 4200 life (Helmethead's 3000). He walks and shoots as Helmethead, and between his steps does
//one of his moves in turn (actK; one every actDelay ticks):
//  head toss     his head flies out in an arc and back (oEvgHeadToss); while it's out his neck is open: every hit on
//                him does double
//  shield charge he crouches behind his shield, then runs at the player till the arena's end: from in front nothing
//                hurts him, from behind everything does double (his hit events, Other_24/25); a short stagger after
//His heads come off as helmets (oEvgHelm) as before, three heads now: at 85% and 72% one each, then he wears his last.
//Each helmet has a polarity, swapped every polDelay ticks after flashing white: red (iron) shrugs off the sword, blue
//(mirror) throws arrows back. Phases (evgPhase): 0 alone, 1 one helmet, 2 two, 3 the barrier (60%: he can't be hurt
//till both helmets are broken, each by breakNeed damage of its polarity's weakness; meanwhile they take turns to dive at
//the player: a warning line, then straight down; anything hitting a diving helmet knocks it down, dazed, and a dazed
//helmet's damage hurts him too), 4 the orbit (40%: the helmets circle him, big, and stop arrows and hurt to touch; his
//shots come three at a time), 5 the end (20%: they dive in turn faster, and his moves come more often)
sprite_index=sEvgHelmetHeadBody
image_speed=0
waterFrm=0

//Enemy base statistics (Helmethead's)
eName="Evil Helmethead"
eLevel=5
maxLife=4200
life=maxLife
atkPower=4
resType[1]=2
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
hitSound=global.snd_EnemyHitZelda
moveTime=0
moveThres=40
atkTime=0
atkDelay=70
myBarrier=0
xCenter=448
yGround=304
roomSpan=192
deathAnim=0
actTime=0
actDelay=150
actProg=0
actT=0
actStage=0
actK=0
headOff=0
headNum=0
headShake=0
chargeDir=1
chargeSpd=4
evgPhase=0
myHelmetA=noone
myHelmetB=noone
diveTime=0
diveDelay=150
diveTurn=0
evgResSet=0
evgRes0=3
evgRes1=2
evgRes4=3
jeremyText="Helmethead got angry and it shows. He'll throw his own head at you, and while it's off, he's wide open. His shield charge can't be stopped head on, so get behind him. Watch the helmets' colors: red ones ignore your sword, blue ones throw your arrows back."
chaoText="He just keeps growing more heads. How many does he even have?"
devText=""
