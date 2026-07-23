bShowArrow=true
exitType=0
newMapX=800
newMapY=512
toRoom=rLink2_PalaceW_8

var dunStateA,dunStateB,dunStateC;
dunStateA=string_char_at(global.gameGate2Prog,1)
dunStateB=string_char_at(global.gameGate2Prog,2)
dunStateC=string_char_at(global.gameGate2Prog,3)
if dunStateA="6" or dunStateB="6" or dunStateC="6"
  instance_destroy()
