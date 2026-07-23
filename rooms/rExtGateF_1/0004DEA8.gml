bShowArrow=true
exitType=0
newMapX=112
newMapY=368
toRoom=rExtGateF_6
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,6)
if instrProg!="7" and instrProg!="9" {instance_destroy()}
