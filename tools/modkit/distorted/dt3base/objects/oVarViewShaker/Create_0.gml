// Requires: turbulance, shakeTime (-1 for infinite)
if instance_number(oVarViewShaker)>1 {instance_destroy(); exit}
x=oPlayer1.x
y=oPlayer1.y
view_object[0]=oVarViewShaker
shakeAmt=0
