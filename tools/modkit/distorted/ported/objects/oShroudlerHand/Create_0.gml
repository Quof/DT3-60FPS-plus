event_inherited()
bActive=true
bCanDealDamage=0
image_speed=0.4

RESPAWN=10+450
RESPAWN_diag=10+750

//Enemy base statistics
eName="Shroudler Hand"
maxLife=450
life=maxLife
for(i=0;i<6;i+=1)
{
  resType[i]=3
}
resType[1]=4
resType[2]=4
stunResist=50
affiliation=7
bIsBoss=true
bNoBonus=true
myType=0

bAimedShot=0
aimedShotTime=0
aimedShotAmt=0
aimedShotAngle=0
aimedShotX=0
aimedShotY=0

atkTime=0
bossProg=0

handLaserTime=0
handLaserDelay=50

jeremyText="HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA"
chaoText="Still think I could do this at 2x. If you felt the need to scan this maybe you just suck."
devText="At least he doesn't have his orb that restores him to full health... or does he?"
extraInfo="Takes 10x damage from birds"
alarm[0]=1
