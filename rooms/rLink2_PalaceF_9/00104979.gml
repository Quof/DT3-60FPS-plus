type=4
moveStep=pi/2
sprite_index=sG2_ForestPoe
image_speed=0.33

myState=string_char_at(global.gameGate2Prog,2)
if myState!="2" {instance_destroy()}
