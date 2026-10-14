//spsp
//Invincible in the actual fight, only lose HP from using MI. If all attacks are equally fast rng is not a problem.

event_inherited()
makeActive()
setCollisionBounds(-8,-40,8,-1)
image_speed=0.1
image_xscale=-1
baseColor=c_black
image_blend=baseColor

//Enemy base statistics
eName="Shadow Form"
eLevel=22
maxLife=5000 //spsp 4000
life=maxLife
atkPower=6
resType[0]=2 //spsp
resType[1]=2
resType[2]=1
resType[3]=2
resType[4]=1
resType[5]=1
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
if room=rBelmont3_6B {bActive=true; activateBoss=2} //spsp ns
//seed=2 //spsp
for(i=0;i<6;i+=1) {Dtrack[i]=0} //spsp ns for keeping track of different kinds of damage taken
Dnumber=0
playerTrack=0
if room=rExtGateE_5
{
  for(i=0;i<6;i+=1) {resType[i]=3}
  maxLife=14000
  life=maxLife
}

//-- Movement Data --
moveSpd=1.25
turnTime=0
turnDelay=40
onOtherSide=0

//-- Neutral Data --
charForm=0
changeTime=0
changeDelay=260

currentAction=0
lastAction=0
attackDelay=0
waitTime=45

//-- Attack Data --
atkSpdA=8
dashDir=0
bDive=0
spdChange=0
checkChange=0
bombFormation=0
holyWaterMax=3

//-- Misc Data --
xCenter=328
yGround=304
roomSpan=160
if room=rLink2_PalaceW_13
{
    xCenter=320
    yGround=288
    roomSpan=192
    //seed=2
}
else if room=rBelmont3_6B {xCenter=1456; yGround=288; roomSpan=1400}

deathAnim=0

jeremyText="I'm busy making myself a sweet cape just in case I ever lose my current position. Figure it out on your own."
chaoText="It has routines to adapt its attack and defensive options to what you're doing. Looks like the attack pattern is just RNG." //spsp ns
devText="Originally this fight was meant to be a duel on par with Death, but other ideas I had overtook that. I never wanted to take away the dueling aspect of the fight though, there's just an added layer to it. The result is fairly predictable, but it's kinda nifty."
extraInfo="Copies your attacks."
if room=rExtGateE_5 //spsp ns
{
  devText="At one point I had an idea that I never got to implement. I would have had the boss be completely invincible, make him unable to switch forms, and give him a moveset based on DT1 Jerry. His attacks would be based entirely on player behaviour, and importantly, whenever the player would get in range for MI, he would MI. The way to beat him would be to force him to spam MI, since that move would drain his health.#After all, the Shadow Form cannot wear a bird hat and is therefore objectively inferior to Jerry. It only makes sense that using an ability more awesome than yourself would come at a heavy price.#And no, I don't care that this text overflows."
}

if room=rBelmont3_6B
{
    jeremyText="Oh man, this thing is back and it has some insane regeneration. I don't think you can kill it here, just try to avoid its attacks and keep going."
    chaoText="It has routines to adapt its attack and defensive options to what you're doing. Right now it will only attack you with its own version of the Belmont set."
    devText="The second appearance of the not-really-a-boss shadow form. You know what they say, third time's the charm. Look forward to it."
}
