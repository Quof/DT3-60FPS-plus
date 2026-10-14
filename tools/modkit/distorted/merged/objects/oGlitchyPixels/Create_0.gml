event_inherited()
image_xscale=2
image_yscale=2
myColor=make_color_rgb(40,40,40)

//Enemy base statistics
eName="Glitchy Pixels"
eLevel=35
maxLife=140
life=maxLife
pointWorth=52
atkPower=9
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=1 //2 //spsp ns
stunResist=2
baseItemChance=60
baseDropIndex=90
moneyWorth=5

runAcc=3
shotTime=30
shotDelay=80

_direction=0
_speed=0

orbitPos=0
orbitSpd=1
myDir=0
circlePlayer=0
bArmorBreak=0

jeremyText="Its movement can be a bit odd to interpret. All it does is orbit a set distance from your location, but that orbit is constantly changing, so your movement can make its movement look erratic. Stop for a moment and observe it, things will make sense then. As for attacks, it has one. When you see those small circles orbiting its main part start to move faster, it's going to fire three shots toward you."
chaoText="These are pretty weird. It looks like its sprite is undefined. You'll come across two kinds of these, both with the same behavior, but a different vulnerability. The one that has very contrasting color to non-solids when not in an inverted color is weak to PIERCE, and the one that has very little contrast to that is weak to SPECIAL. If you can hit it with EXPLOSIVE, but I don't know how useful that will be."
devText="spinach here#I always thought that the rooms with these enemies were way more fun if you just didn't fight them at all, so I made them invulnerable. Enjoy :^)"

alarm[0]=1
