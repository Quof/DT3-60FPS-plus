event_inherited()
makeActive()
setCollisionBounds(-7,-14,7,-1)
image_speed=0.3

//Enemy base statistics
eName="Goomba"
maxLife=70
life=maxLife
pointWorth=3
atkPower=2
resType[2]=4
resType[3]=2
baseItemChance=50
affiliation=1
dieEffect=0
initDir=0
runAcc=1

if global.location=40 {sprite_index=sDarkGoomba; atkPower=8} //spsp ns

deathAnim=0

//jeremyText="Theres not much I have to say about Goombas that you shouldnt already know. It walks straight and slowly at that. Why are you scanning this? Its not like there's anything I'd be able to tell you thats new or interesting. Okay look down, it's twice as vulnerable to Elemental type attacks."
jeremyText="There's not much I have to say about Goombas that you shouldn't already know. It walks straight and slowly at that. Why are you scanning this? Its not like there's anything I'd be able to tell you that's new or interesting. Okay look down, it's twice as vulnerable to Elemental type attacks." //typo fix
chaoText="Look at their little stubby legs, they're so cute! Can I pleeease have a house full of these?!"
devText="Spinach here. I will occasionally hijack scan texts to provide additional distorted-specific info. That doesn't mean you have to scan everything (again?), but if you're having trouble a scan could improve your life."
