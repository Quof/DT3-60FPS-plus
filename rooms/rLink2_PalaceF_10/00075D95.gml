progCheck=9000000

gameProgCheck=string_char_at(global.gameGate2Prog,2)
if gameProgCheck="3" or gameProgCheck="4" or gameProgCheck="5" or global.gameProgress>=830 {instance_destroy()}
