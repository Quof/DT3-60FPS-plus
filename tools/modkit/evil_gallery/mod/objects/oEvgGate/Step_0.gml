//Evil Boss Gallery: the gate usable 20 ticks after the room starts (as a gallery door), and its swirl's clock
if activateTime>0 {activateTime-=1*gDeltaTime}
if activateTime<0 {activateTime=0}
glowT+=1*gDeltaTime
