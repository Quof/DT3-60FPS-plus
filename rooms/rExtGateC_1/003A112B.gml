bShowArrow=true
exitType=0
newMapX=64
newMapY=144
toRoom=rExtGateC_5
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,3)
if instrProg!="7" and instrProg!="9" {instance_destroy()}
