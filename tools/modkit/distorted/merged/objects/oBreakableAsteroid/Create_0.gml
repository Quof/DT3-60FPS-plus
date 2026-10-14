event_inherited()
bActive=1
baseColor=make_color_rgb(180,220,255)
image_blend=baseColor

//Enemy base statistics
eName="An Asteroid"
eLevel=37
maxLife=100
life=maxLife
pointWorth=10
atkPower=16
dieEffect=0
moveSpd=2
spinSpd=1
_direction=0
_speed=0
suck=0 //spsp ns
suckReady=0

jeremyText="These are like asteroids you may have seen in other video games."
chaoText="You can't eat asteroids. Unless they're red of course."
devText="Thanks Bea."

//alarm[0]=1
alarm[0]=round(1/gDeltaTime) //60fps change: the type's speed is set one 30fps tick after creation, as at 30fps (alarms count frames, so with 1 split pieces switched from speed 2 to 5/7 after half/a quarter of a tick and drifted a few px further)
