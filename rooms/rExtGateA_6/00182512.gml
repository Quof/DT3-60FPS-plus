GID_SET(344039, self.id)
bShowArrow=true
exitType=0
newMapX=184
newMapY=288
toRoom=rExtGateA_1
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,1)
if instrProg="8" {instance_destroy()}
