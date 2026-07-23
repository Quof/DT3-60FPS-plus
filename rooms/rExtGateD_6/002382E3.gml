GID_SET(344046, self.id)
bShowArrow=true
exitType=0
newMapX=168
newMapY=304
toRoom=rExtGateD_1
newDraw=1
image_blend=c_maroon

var instrProg;
instrProg=string_char_at(global.eGateProg,4)
if instrProg="8" {instance_destroy()}
