GID_SET(344042, self.id)
bShowArrow=true
exitType=0
newMapX=208
newMapY=416
toRoom=rExtGateB_1
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,2)
if instrProg="8" {instance_destroy()}
