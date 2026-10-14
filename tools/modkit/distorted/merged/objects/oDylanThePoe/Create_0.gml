event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
image_speed=0.33
image_alpha=0
flameFrm=0
flameBlend=c_white

//Enemy base statistics
eName="Dylan the Poe"
eLevel=6
maxLife=1900 //1500
life=maxLife
atkPower=4
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
bossProgress=0
activateBoss=1
dieEffect=0
hitSound=global.snd_EnemyHitZelda

//spsp ns
resType[0]=1
resType[1]=3
resType[2]=1
resType[3]=1
resType[4]=5
resType[5]=4

atkSequence=0
atkTime=0
xSpd=1

bulletAtkTime=20
bulletAtkDelay=110
bulletType=0

leftSide=128
rightSide=352

deathAnim=0

if room=rDCS_N
{
    atkPower=12; maxLife=2500; life=maxLife
    leftSide=96; rightSide=480
} //spsp ns

jeremyText="Looks like this guy doesn't like you. His pattern is easy enough, it's just back and forth at the upper section of the room. When you see his flame flare up orange, he's going to fire a stream of bullets toward you. If it's green, get off the ground, he's about to fire a stream of bullets along the ground. It also seems he's invulnerable while his flame isn't lit."
chaoText="The shield hinders Dead Hand a bit. It slows down Dead Hand's generation of the Grabbing Hands and causes him to fire bullets at a much slower rate."
devText="I WOULD JUST LIKE TO SAY THAT ZEPHYR HID THE CANTAKEDAMAGE FLAG CHANGE FOR DYLAN IN THE FUCKING DRAW EVENT"
