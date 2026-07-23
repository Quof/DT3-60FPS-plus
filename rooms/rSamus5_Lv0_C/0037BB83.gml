type=0
sprite_index=sEfEnergyRip
image_speed=0.33
image_xscale=0.25
image_yscale=0.25
image_blend=c_blue

bossCheck=string_char_at(global.gameGate5Prog,3)
if bossCheck="5" {instance_destroy()}
