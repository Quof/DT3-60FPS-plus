event_inherited()

//Enemy base statistics
eName="Defective"
eLevel=35
maxLife=6100
life=maxLife
atkPower=15
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resistChange=0
resType[resistChange]=3
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
ringBulletTime=70
ringBulletDelay=210
ringBulletAmt=0
ringBulletMax=2
lightningTime=0
lightningDelay=250
lightningAmt=0
lightningMax=1

//spsp ns
hitcount=0 //used for forced switches
spikeProg=0
insultTime=490/(1+1)    //spsp
insultDelay=720/(1+1)   //spsp
streamTime=0
streamDelay=150 //spsp ns both this and ^
insultNum=0
newSoundVol=0
pastAbilityA=0
pastAbilityB=0
//--------------------
armRotA=0
armRotB=0
phase=0
goDown=1
xSpd=0
ySpd=0

//Misc Data
xCenter=864
yGround=256
roomSpan=288

jeremyText="There's not much I can look up about this... thing. It's all scrambled. Only thing I'm able to interpret is that its resists cycle, but I don't know when."
chaoText="Same with Jeremy, I can't pull up anything about it. I'm pretty sure this thing was created just now. Huh... looks like its resists cycles with a certain attack that it performs? Ugh, this is so weird."
devText=". . ."

deathAnim=0
