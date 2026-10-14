event_inherited()
bActive=1
image_speed=0.25

//Enemy base statistics
eName="Latch Crystal"
maxLife=10000
life=maxLife
bCanDealDamage=false
bShowHealthBar=false
bShowDamagePopout=false
stunResist=50
bIsBoss=true
bNoBonus=true
for(i=0;i<6;i+=1)
{
  resType[i]=2
}

hit=0
htime=-1
resetTime=60
rotSpd=-9
rotTime=10

maxTargets=3
targets[0]=oHexCircle
targets[1]=oDHexRing
targets[2]=oDHexTunnel
for(i=0;i<3;i+=1) {lockon[i]=true}

alarm[0]=1
