event_inherited()
image_speed=0

//Enemy base statistics
eName="Aqua(?) Serpent"
eLevel=8
maxLife=3500
life=maxLife
atkPower=5
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
moveBehavior=1
floorSeq=0

moveSpd=4
moveSide=1
movePath=1
moveProg=-10
moveDir=0
_hspeed=0
_vspeed=0

spdChg=4

bWaterRise=1
waterAltSpd=-2
doubleBack=0

bBombOnly=1

resType[0]=2 //spsp ns

deathAnim=0

jeremyText="This is all sorts of bad, but unfortunately I can't give you much info on it right now. What I can see is that its melee resist has been buffed. I'll get rid of that for you, but it'll take a moment."
chaoText="The serpent cycles through 3 attack patterns. The first, it goes overhead, no direct attack to you, get some hits in. The second, it does a wave pattern through the field. The third, it will stop and fire 5 energy shots out of its mouth. There's some obfuscated data, so I know there's more than just this."
devText="If you want to complain about seemingly undodgeable bullets during the wave pattern in the first phase, consider the following:#1) that's Zephyr's fault#2) you can use the fact that those bullets are aimed."

for(i=0;i<20;i+=1)
{
  bodyPart[i]=instance_create(x,y,oAquaSer_Body)
  bodyPart[i].bodySeg=i
  bodyPart[i].depth=depth+i+1
}
roomBorderTop=-416
roomBorderBottom=room_height+416
roomBorderLeft=-224
roomBorderRight=1088
