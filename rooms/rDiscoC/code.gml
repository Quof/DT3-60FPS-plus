locationCheck(88)

gameScene=instance_create(0,0,oEvCh19MainA)

if global.gameProgress<=4940 {tile_layer_hide(999999)}

var tempMplay;
if global.gameProgress<=4610 or global.gameProgress>=4630 {tempMplay=findMusic(28)}
else {tempMplay=findMusic(1001)}
playMusic(tempMplay,0,0)
