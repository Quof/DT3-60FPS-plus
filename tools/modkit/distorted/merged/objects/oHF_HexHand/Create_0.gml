event_inherited()
bActive=1
image_speed=0

//Enemy base statistics
eName="Hex Hand"
eLevel=40
maxLife=760
life=maxLife
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=2
}
resType[4]=5
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0

atkProg=0
atkTime=0
atkDelay=30
atkCycle=0

jeremyText="Whatever you do, don't destroy these. When you do, they explode into a bullet storm that lasts a good 3 seconds. Destroying them also restores a bit of Hex's HP. Wow, so basically just refrain from using EXPLOSIVE type damage around these."
chaoText="This thing fires two types of attacks. One of them are the same as those shield orbs, but they're fired at you. The other is a red lightning attack. If you can hit this thing with Jerry's Fuse Bomb, you should be able to destroy it in one hit if you've powered up your bomb."
devText="Hex blocks dev commentary."
