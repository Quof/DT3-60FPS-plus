event_inherited()
image_speed=0.15
bShowHealthBar=false
oHUD.dragoonBossCheck=1
oHUD.enemyCheckID=id
bActive=1

//Enemy base statistics
eName="Hex Worm"
eLevel=37
maxLife=700
life=maxLife
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0
weaponGive=300
bossProgress=0
activateBoss=0

moveBehavior=0
movePath=1
moveProg=0
moveSpd=4+1 //spsp
_speed=0
_direction=0


deathAnim=0

jeremyText="It looks like the head is invulnerable to damage while any of the body segments are around."
chaoText="Ah lame, this just restores all of your health when you eat it."
devText="N/A"

partCheck=0
partNum=24
for(i=0;i<partNum;i+=1)
{
  bodyPart[i]=instance_create(x,y,oHW_Body)
  bodyPart[i].bodySeg=i
  bodyPart[i].depth=depth+i+1
}
