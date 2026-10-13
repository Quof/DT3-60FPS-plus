//requires set (what set of position objects apply to it)

event_inherited()
bActive=1
current=0
maxPosition=1
positionsX[0] = x
positionsY[0] = y
positionsX[1] = x-16
positionsY[1] = y
alarm[0] = 1
bDamageFlash=0
looping=true

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
