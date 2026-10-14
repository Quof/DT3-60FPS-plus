//Needs drillMax.
event_inherited()
image_speed=0
image_xscale=1.1

//Enemy base statistics
eName="Drill Waying"
eLevel=18
maxLife=350
life=maxLife
pointWorth=20
atkPower=5
resType[0]=2
resType[1]=2
resType[2]=4
stunResist=4
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
inactiveDist*=1.5

drillProg=0
waitTime=0

jeremyText="When it detects a hostile, that's you, to be in proximity, it will block off the pathway. The only way to get past it is to destroy the odd looking screw."
chaoText="I don't remember these being all that threatening in the original games, aside from that optional level with Vile, but even then, they weren't too much of a hindrance. I hope the Virus doesn't make better use of them."
devText="Since the Gate 4 intro stage and fortress stages would all be primarily interior levels, I wanted all the Maverick levels to feature mostly exterior environments. Like the Mavericks themselves, the tilesets used were one from each SNES game, which didn't necessarily have to match the Maverick itself."

if room!=rWarshipI or global.newMapX<500 //spsp ns new if to avoid problems in one room
{
colBase=instance_create(x,y+16,oSolid)
colBase.sprite_index=sDrillWayingBase; colBase.visible=1
colDrill=instance_create(x,y-16,oDrillWayingDrill)
}
