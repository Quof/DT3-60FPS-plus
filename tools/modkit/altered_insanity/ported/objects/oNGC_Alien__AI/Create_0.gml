//Requires: patrolProg,maxRange,lastAction
event_inherited()
makeActive()
setCollisionBounds(-24,-24,24,-1)
baseColor=c_black
image_blend=baseColor
image_speed=0
hoverAlpha=-1
bActive=true

//Enemy base statistics
eName="Stalker"
maxLife=10000
life=maxLife
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=100
affiliation=7

patrolSpd=2
chaseSpd=11
xCenter=x
patrolTime=0
lineOfSight=0

jeremyText="N/A"
chaoText="N/A"
devText="N/A"
