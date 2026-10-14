event_inherited()
bShowHealthBar=false
bActive=1
image_speed=0.2

//Enemy base statistics
eName="Abomination Super Spawn"
eLevel=38
maxLife=1500
life=maxLife
pointWorth=10
atkPower=12
stunResist=30 //3
affiliation=9
bIsBoss=true
dieEffect=0
currHspd=0
currVspd=0
deathAnim=0

for(i=0;i<6;i+=1)
{
  resType[i]=1
}
currAcc=0.3 //orig 0.25
cancer=0
dDist=6
mDist=4
/* for oDAbomMain (maybe with effect? in that case make a variable to be changed in this object)
with oDAbomSFinal {for(i=0;i<6;i+=1){resType[i]=3};image_blend=c_white}
*/
