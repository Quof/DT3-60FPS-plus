event_inherited()
makeActive()
setCollisionBounds(1,1,1,1)
image_speed=0.6
image_xscale=1.25
image_yscale=1.25
/*if true              //spsp
{
    image_xscale=2
    image_yscale=2
}*/
visible=0
bCanDealDamage=false
bCanTakeDamage=false
bActive=1

//Enemy base statistics
eName="Sand Crawler"
if global.modeWahfuu=1 {eName="Wahfuu Jr."}
eLevel=26
maxLife=6000
life=maxLife
atkPower=20
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=5

if true          //spsp
{
    for(i=0;i<6;i+=1)
    {
        resType[i]=4
    }
    resType[4]=1
}

stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0

biteTime=-1
biteSpd=0.2
moveProg=0
xVel=0

deathAnim=0

jeremyText="Time to put this thing down. Bombs don't work on it for whatever reason, just beat it up with all the other things you have. I've removed its health regeneration as well as its annoying insta-death bite."
chaoText="This thing is from King of Monsters 2. It chased Claire through a desert when we were on that island. Looks like Jeremy has finally found a way to make this thing beatable."
devText="Beating this thing should be satisfying."
