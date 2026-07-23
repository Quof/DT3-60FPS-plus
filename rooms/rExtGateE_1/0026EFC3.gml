bShowArrow=true
exitType=0
newMapX=136
newMapY=304
toRoom=rExtGateE_5
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,5)
if instrProg!="7" and instrProg!="9" {instance_destroy()}
