GID_SET(344047, self.id)
bShowArrow=true
exitType=0
newMapX=152
newMapY=288
toRoom=rExtGateE_1
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,5)
if instrProg="8" {instance_destroy()}
