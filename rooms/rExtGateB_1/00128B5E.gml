bShowArrow=true
exitType=0
newMapX=168
newMapY=288
toRoom=rExtGateB_6
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,2)
if instrProg!="7" and instrProg!="9" {instance_destroy()}
