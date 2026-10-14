event_inherited()
bActive=true
image_speed=0.3
animFrm=0

//Enemy base statistics
eName="Abomination Weak Spot"
if global.modeWahfuu=1 {eName="Wahfuu Weak Spot"}
eLevel=39
maxLife=2000
life=maxLife
atkPower=12
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
dieEffect=0
_direction=0

bombflag=0 //spsp ns
BSturn=0
BStimer=0
BSdelay=150
BStemp=0

scaleWave=pi/2

deathAnim=0

var tEffect;
for(i=0;i<20;i+=1)
{
  tEffect=instance_create(x+random_range(-12,12),y+random_range(-12,12),oEffect)
  tEffect.sprite_index=sWitchFire; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_speed=0.2+random(0.2)
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.05
  tEffect.image_xscale=1+(i*1.25); tEffect.image_yscale=1+(i*1.25); tEffect.image_angle=random(360)
}

jeremyText="This is one of the weak spots that formed when the melody started playing. Something is already working on some way to shield them even with the melody playing, prepare for the worst."
chaoText="These 'weak spots' are awfully odd, even for this thing. It's like something is trying to hide itself. Let's keep the music playing and maybe we can drive it out of the creature."
devText="spinach here. You'll always need all 8 instruments playing now. The room itself is smaller and the instruments are closer to the weak spots as well, a lower requirement felt too easy."

alarm[0]=1
