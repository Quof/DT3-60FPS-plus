GID_SET(344043, self.id)
bShowArrow=true
exitType=0
newMapX=144
newMapY=304
toRoom=rExtGateC_1
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,3)
if instrProg="8" {instance_destroy()}
