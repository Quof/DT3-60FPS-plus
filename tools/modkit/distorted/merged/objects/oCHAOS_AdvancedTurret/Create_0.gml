//Requires: bWall (myWallX,myWallY,myWallScale)
event_inherited()
y+=2

//Enemy base statistics
eName="CHAOS Advanced Turret"
eLevel=33
maxLife=680 //520
life=maxLife
pointWorth=72
atkPower=9
resType[1]=1
resType[3]=4
stunResist=5
baseItemChance=70
moneyWorth=5
affiliation=7
dieSound=0
dieEffect=0
inactiveDist*=2
_hspeed=0
_vspeed=0

attachState=0
attachTime=0
currHspd=0; currVspd=0
xPoint=0
yPoint=0
atkSide=0
maxSpeedX=3
maxSpeedY=4
wallSet=0

shotTime=15
shotDelay=35
bulletCycle=0
atkChange=0
bombTime=25
bombDelay=70
bombType=0
hideDelay=0

halfangle=45 //spsp ns

deathAnim=0

jeremyText="At first glance, this is simply a turret that can fire rapidly. It will also drop bombs when you're under it. However, after some time or taking damage, it will detach itself from its mount. From there, it will keep its distance and periodically pass by you, dropping lots of bombs. There is an assist function for something called the 'CHAOS Sabotage.'"
chaoText="That line you see sometimes is when its assist function is active. I think that is distance based; I'm pretty sure it is buffing its ally's resistances while it's on."
devText="Major changes in behavior for standard enemies (while certain events are occurring) is a rare thing in DT. I aimed to change that as it seems to create more engaging and differing encounters. In this case, an ally that's close by with a shield can cause this one to hide behind it."
