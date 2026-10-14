event_inherited()
bActive=1

if !variable_local_exists("spinSpd")
    spinSpd=-4
if !variable_local_exists("changeDelay")
    changeDelay=0
if !variable_local_exists("moveSpd")
    moveSpd=0
//Enemy base statistics
atkPower=13

maxLife=10000
life=maxLife
bCanDealDamage=true
bShowHealthBar=false
bShowDamagePopout=false
stunResist=50
bIsBoss=true
bNoBonus=true
for(i=0;i<6;i+=1)
{
  resType[i]=2
}

bCanTakeDamage=true
bCauseKnockback=true
changeTime=0
