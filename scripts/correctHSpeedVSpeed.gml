//gravity arc correction (see moveTo): objects that add gravity every frame set yGravBias on that line
var tVB; tVB=0
with argument0 {if variable_local_exists("yGravBias") {tVB=yGravBias*(1-gDeltaTime)*0.5; yGravBias=0}}
argument0.x += argument0._hspeed * gDeltaTime;
argument0.y += (argument0._vspeed + tVB) * gDeltaTime;
