event_inherited()
image_xscale=-1

//Enemy base statistics
eName="Ridley"
eLevel=25
maxLife=6400
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bWave=1
moveWaveX=pi/2
moveWaveY=pi/2

atkProg=0
atkTime=0
atkFireAlter=0
fireballRate=0
fireCircleAmt=24+24       //spsp
groundMoveSpd=24
groundCycle=0
cycleMax=2
groundFireFreq=5
breakArmor=0

myDirType=0
moveSpd=4+1     //spsp

//Misc Data
xCenter=320
yGround=336
roomSpan=288

//Body Data
ridParts[0]=instance_create(x,y,oRidleyParts); ridParts[0].depth=4; ridParts[0].type=0
ridParts[1]=instance_create(x,y,oRidleyParts); ridParts[1].sprite_index=sRidleyWings; ridParts[1].depth=5; ridParts[1].type=1
ridParts[2]=instance_create(x,y,oRidleyParts); ridParts[2].sprite_index=sRidleyArms; ridParts[2].depth=6; ridParts[2].type=2
for(i=0;i<3;i+=1)
{
  ridParts[i].myOwner=id
}

for(i=0;i<7;i+=1)
{
  ridTail[i]=instance_create(x,y,oRidleyParts); ridTail[i].sprite_index=sRidleyTailSeg; ridTail[i].depth=8; ridTail[i].type=3
  ridTail[i].tailSeg=i
  ridTail[i].myOwner=id
  ridTail[i].bCanDealDamage=0
}
ridTail[6].sprite_index=sRidleyTailEnd; ridTail[6].depth=9
