locationCheck(15)

if global.gameProgress=1310
  global.gameProgress=1320

var gameProgCheck;
gameProgCheck=string_char_at(global.gameGate3Prog,2)
if gameProgCheck="0" or gameProgCheck="1"
  tile_layer_hide(999999)

gameScene=instance_create(0,0,oEvCh6MainA)

var tempMplay;
tempMplay=findMusic(304)
playMusic(tempMplay,0,0)
