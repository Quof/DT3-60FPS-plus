//End attack
sprite_index=sAntiAlpha_Idle
jumpNum=0
actTime=0
actCheck=0

atkNum+=1
if atkNum=1 {waitTime=round(waitDelay/2)+10}
else if atkNum=2 {waitTime=round(waitDelay/2)+25}

if atkNum>=atkMax {waitTime=0; atkNum=0}
