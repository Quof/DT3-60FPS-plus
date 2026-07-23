bShowArrow=true
exitType=0
newMapX=104
newMapY=384
toRoom=rExtGateD_6
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,4)
if instrProg!="7" and instrProg!="9" {instance_destroy()}
