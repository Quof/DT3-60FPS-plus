sprite_index=sCV_Gems
image_speed=0
image_blend=make_color_rgb(100,100,100)
type=1

var gameProgCheck;
gameProgCheck=string_char_at(global.gameGate3Prog,1)
if gameProgCheck="3" or gameProgCheck="4"
  image_blend=c_white
