bShowArrow=true
exitType=0
newMapX=16
newMapY=224
toRoom=rExtGateG_5
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,7)
if instrProg!="7" and instrProg!="9" {instance_destroy()}
