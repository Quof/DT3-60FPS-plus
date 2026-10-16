event_inherited()
//Evil Boss Gallery: Evil Bowser (rEvgBowser). Bowser's fight (his Create, then this; Step, Draw and the bricks'
//collision are his own): he can't be hurt, and is beaten by falling through the floor he breaks with his stomps. The
//deeper he is (bossProgress: 0 the top row of bricks, 1 and 2 the rows under it, 3 the last, with the switches), the
//more moves he has, picked in the order of his pattern for the row (evgPat, a letter a move; the next after each stand,
//jumpDelay):
//  S stomp    Bowser's jump and butt stomp; landing sends a shockwave along the floor each way (oEvgShockwave)
//  H hammers  a hammer held up, then 6 thrown at the player in arcs of set lengths (evgHamX: short and long in turn).
//             They fly over someone standing close to him
//  M meteor   a leap up to the ceiling, where he follows the player along it (meteorSpd, for meteorHunt ticks), then
//             flashes (locked on) and drops straight down, fast: a shockwave each way, and a slow one after it
//  I inferno  a roar, embers rising from the floor, then every column's top brick on fire (oEvgFloorFlame) for
//             infernoLen ticks; Paratroopas fly in and keep coming (oEvgParatroopa), to be bounced on over the fire
//His hop fireballs come in bursts from the second row down (evgBowserFire: chest high, then foot high, in turn), and in
//the last phase Bullet Bills (oEvgBulletBill) cross the arena from each side, low and high in turn. The top row's
//bricks are reinforced (the room's code: evgHard): his first stomp on one only cracks it, and the stomp that cracked it
//(evgCrackId, stompId) can't also break it
sprite_index=sEvgBowserStand
eName="Evil Bowser"
jumpDelay=75
fireDelay=40
evgPat[0]="SSH"
evgPat[1]="SMHSM"
evgPat[2]="ISMHSM"
evgPat[3]="MSHMS"
evgPatPos=0
evgMove="S"
evgTime=0
forceStomp=0
stompId=0
meteorFall=0
meteorY=120
meteorSpd=3.5
meteorHunt=50
hammerNum=0
hammerMax=6
evgHamX[0]=2.2
evgHamX[1]=4.4
evgHamX[2]=3.2
evgHamX[3]=5.2
evgHamX[4]=2.7
evgHamX[5]=3.8
waveSpd=3.5
fireBurst=0
fireBurstT=0
fireBurstK=0
infernoLen=120
paraTime=0
paraSide=1
paraNum=0
evgParaY[0]=214
evgParaY[1]=182
evgParaY[2]=198
billTime=0
billNum=0
shakeTime=0
viewFix=noone
jeremyText="Bowser's back, and he's brought friends. He shakes the floor when he lands now, he throws hammers, and when he roars the whole floor goes up in flames. The Paratroopas he calls in are your way over it: land on them holding jump."
chaoText="He's so angry! I don't think he even cares about Peach anymore."
devText=""
extraInfo="Immune to everything. Same as before: make him dig."
