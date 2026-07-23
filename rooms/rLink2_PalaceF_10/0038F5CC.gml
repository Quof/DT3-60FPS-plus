type=4
moveStep=pi/2
sprite_index=sG2_ForestPoe
image_speed=0.33
image_xscale=-1

myState=string_char_at(global.gameGate2Prog,2)
if myState="2" or myState="3" or myState="4" or myState="5" or global.gameProgress>=830 {instance_destroy()}
