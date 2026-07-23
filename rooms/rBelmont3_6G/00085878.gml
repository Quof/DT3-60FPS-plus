//Death's Eye
sprite_index=sCV_DeathParts
image_speed=0
image_index=2
image_blend=make_color_rgb(100,100,100)
type=1

var gameProgCheck;
gameProgCheck=string_char_at(global.gameGate3Prog,2)
if gameProgCheck="4"
  image_blend=c_white
