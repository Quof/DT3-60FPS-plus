event_inherited()
image_xscale=-1
image_speed=0.25

//Enemy base statistics
eName="Vault Demon"
eLevel=22
maxLife=11500
if room=rYellowRide {maxLife=9500}     //spsp
life=maxLife
atkPower=5
if room=rYellowRide {atkPower=12}
stunResist=50
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
resType[0]=2
affiliation=8
//--------------------
atkSequence=0
atkTime=0

xPrev=0; yPrev=0
moveType=0
moveTime=0
moveDelay=300
moveSpd=0

moveYcenter=288

trackFireTime=180
trackFireDelay=240
trackFireMax=3
trFiCur=0
fireOffset=30

shiftAtk=10000
shiftTempA=0
shiftTempB=0
shiftTempC=0

lavaballTime=0
lavaballDelay=600-300 //spsp
//--------------------

//Misc Data
xCenter=2208
yGround=352
roomSpan=176

if room=rYellowRide
{
    yGround=272
    moveYcenter=208
    xCenter=5616
    roomSpan=336
}

jeremyText="This will cycle through movement phases. Each one begins with a specific attack. His top corner lightning attack is the most deadly. When he moves to a corner, get under him and dash to the opposite end... just my suggestion. His standard attack are those meteors that follow you, nothing else to say there. What you really need to focus on, is the flame he creates. Be sure your water reserve is replenished when you see him summoning it."
chaoText="It's using the 'Flame of the Kalla' sprite from 'Dungeon Fighter Online'. From what I've gathered, it escaped from the Vault the same time Hex did. Looking deeper, it seems this thing was made by Hex while he was trapped in there... What else has he created? Wait a minute... bots can create other bots? I thought only the program itself could do that."
devText="This boss was originally going to be in the Vault chapter. But I wanted to combine some of this boss' elements together with the desert heat instead. The main thing that changed was instead of the flame changing the water, it would lock out a color zone. (The one furthest away from the current flashing color.)"
if room=rYellowRide {devText="This was just another Team Rocket encounter at first, but that was quite easy so i thought I should use a boss since that seems to be one of the things people liked about distorted mode. So here he is. I don't know about normal mode but on Nightmare he's quite tough. Remember not to kill your own hands with this.#For some reason, the lava collision is very lenient here. I decided not to fix this considering the difficulty."}

deathAnim=0
