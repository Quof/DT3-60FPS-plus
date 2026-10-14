//Requires: bSway
event_inherited()
bActive=true
image_xscale=0.1; image_yscale=0.1
visible=0
bCanDealDamage=0; bCanTakeDamage=0

//Enemy base statistics
eName="Abomination"
if global.modeWahfuu=1 {eName="Wahfuu"}
eLevel=39
maxLife=1000000
life=maxLife
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true

fireTime=0
fireDelay=170
if room=rDistortedAbom //spsp ns
{
  fireDelay-=30
  if oDAbomMain.spinPhase=2 {fireDelay=175}
}
myProg=0
myTime=0

moveWave=pi/2
