event_inherited()
bActive=true
bCanDealDamage=false
bCanTakeDamage=false
image_blend=c_red

//Enemy base statistics
eName="Kamek's Wand"
/*if oKamek.life=3 {maxLife=3}
else {maxLife=2}*/
//spsp ns
maxLife=7
life=maxLife
atkPower=3
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0

atkTime=0
atkSequence=0
hitStateTime=0

//spsp ns
//tl note: MAN = Maximum Attack Number
MAN=7
for(i=0;i<MAN;i+=1)
{
  atkList[i]=false
}
//first pattern
atkList[0]=true
atkList[1]=false //always off
atkList[2]=true
atkList[3]=false
atkList[4]=false //always off
atkList[5]=true
atkList[6]=false

swooptime=300
fanTime=0
fanMax=90
wandProgress=0
Ltime=0
Ldelay=90
maxBalls=2
Btime=0
Bdelay=210
Mtime=0
Mdelay=120
Mmax=1
swoopSpd=4.5
Wleft=128
Wright=416
Bleft=128
Bright=416
Bground=288
wandHeight=158+24
meteorSeq=0

wandState=0
xVel=0
yVel=0
atkNum=0

jeremyText="This looks to be linked with Kamek's shield. But bleh, blocked from seeing much of anything."
chaoText="His wand has all sorts of attacks and moves on its own."
devText="Jumping on this thing while it was still up high was a bit too precise for my liking. Thankfully you no longer have to do that."
