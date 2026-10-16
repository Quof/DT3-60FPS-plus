event_inherited()
//Evil Boss Gallery: a sickle of Evil Death's sickle storm (his user event 3). It circles above him (owner) till
//launchT, stops and aims at the player for 12 ticks (a line shows where it'll go), then flies that way at spd till it
//leaves the arena or hits the floor. One hit of anything breaks it (life 1; the whip's heart energy too), holy water's
//fire burns it; no drops, points or kill streaks (baseItemChance, bNoBonus)
eName="Sickle"
maxLife=1
life=1
atkPower=5
affiliation=3
bShowHealthBar=false
bIsBoss=false
bNoBonus=true
pointWorth=0
baseItemChance=-1000
moneyWorth=0
dieEffect=1
dieSound=1
bCanBeScanned=0
hoverAlpha=-1
bActive=true
image_speed=0
image_xscale=1.5
image_yscale=1.5
owner=noone
cx=x
cy=y
ang=0
orbitR=44
launchT=40
prog=0
t=0
aimDir=0
spd=6
