event_inherited()
makeActive()
setCollisionBounds(-11,-48,11,-1)
image_speed=0
image_xscale=-1
global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

if true and x=384        //spsp
{
    boss=instance_create(200,288,oPT_HighHeelsGirl)
    boss.activateBoss=1
}
spspcheck=0

//Enemy base statistics
eName="High Heels Girl"
eLevel=29
maxLife=8000
life=maxLife
atkPower=10
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
//resType[0]=3 //spsp ns
stunResist=50
affiliation=6
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
bCanBeBlocked=1
bParryOpp=0
blockCost=50

//-- Movement Data --
moveSpd=2.5

//-- Attack Data --
atkNum=0 //current attack in string
atkMax=2+1 //max attacks in a string        // spinach special
waitTime=5
waitDelay=30-5 //idle time between attack strings     // spinach special
actTime=0 //progress in an action
currentAtk=-1
actCheck=0 //choosing an action
atkSpd=0   //changes attack speed
altAtk=0
slowVel=0
xSpot=0

//-- Misc Data --
xCenter=320
yGround=288
roomSpan=160

deathAnim=0

jeremyText="She only has two attacks, but her actions before performing them are a bit more varied. Luckily her actions are very predictable if you know what to look for. One thing to note is her chosen action is mostly based on how close you are to her and whether or not you are attacking."
chaoText="Oh hey, she's from the same game you guys are using your looks from."
devText="I am a little sad about this nerf, but it had to happen. I used to claim that recovering from a desync is possible, and that is true, but it just isn't reasonable without movement in the second dimension. You still need to parry to win, of course."
extraInfo="Attacks very fast."
