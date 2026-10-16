event_inherited()
//Evil Boss Gallery: Evil Death, his first form (rEvgDeath). Death's duel (his Create, then this; his Step, Draw and
//swings, user events 0-2, are copies of Death's with his evil sprites), faster, with 8960 life on his hit spot
//(oEvgDeathHS: Death's 6400) and three evil moves besides (user event 3), one every evgSpecDelay ticks while he's free,
//in his phase's order (evgSpecPat, a digit a move):
//  1 sickle storm  sickles (oEvgSickle) circle above him, then one by one stop, aim at the player (a line shows where)
//                  and fly. Any hit breaks one (the whip's heart energy too); holy water's fire burns them
//  2 phantom rush  he fades out; phantoms of him (oEvgPhantom) tear across the arena from each side in turn, each after
//                  a red band shows its height: on the floor (jump it, a full jump) or above a standing player's head
//                  (stay on the ground). A dash goes through either
//  3 soul siphon   he plants his scythe in a vortex (oEvgSiphon) that pulls the player in for 90 ticks, then reaps all
//                  round him (Death's spin, huge: jump it). Holy water on him or into the vortex breaks it: he staggers
//Holy water also breaks his pentagram shield (oEvgPentagram, raised against daggers as Death's): he staggers. Staggered
//(user event 4) he's on his knees for 75 ticks (staggerTime), every hit doing double (oEvgDeathHS). Phases (bossProgress)
//at 85%, 72%, 65% (his Wrath), 50% and 25%
sprite_index=sEvgDeathWalk
eName="Evil Death"
with (myHS) {instance_destroy()}
myHS=instance_create(x,y,oEvgDeathHS)

//(Death's, faster)
moveSpd=0.75
jumpDelay=260
atkDelay=32
atkSwingScale=1.1
flyScyDelay=140
specFSaDelay=560

evgSpecTime=0
evgSpecDelay=420
evgSpecPat[0]="1"
evgSpecPat[1]="12"
evgSpecPat[2]="312"
evgSpecPat[3]="231"
evgSpecPat[4]="123"
evgSpecPat[5]="321"
evgSpecPos=0
evgMove=0
evgT=0
evgStage=0
evgNext=0
staggerTime=0
sickleNum=6
sickleGap=14
rushPat[0]="LLL"
rushPat[1]="LLL"
rushPat[2]="LHL"
rushPat[3]="LHL"
rushPat[4]="HLHL"
rushPat[5]="LHLH"
rushNum=0
rushSide=1
siphon=noone
fadeA=1
jeremyText="Death's not holding back anymore. Holy water is your best friend here: it breaks his pentagram (bait it out with a dagger first), burns his sickles, and breaks him out of his soul siphon. When he vanishes, watch the red band: on the floor, jump; up high, stay down. A dash gets you through either."
chaoText="I really don't like this one. He feels... hungry."
devText=""
extraInfo="An even bigger pain in the ass."
