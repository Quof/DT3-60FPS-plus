image_speed=0.33
type=2
key=1

var dunState;
dunState=string_char_at(global.gameGate6Prog,key)
if dunState="1"
  instance_destroy()
