locationCheck(93)

gameScene=instance_create(0,0,oEvCh19MainA)

var tempMplay;
tempMplay=findMusic(30)
playMusic(tempMplay,0,0)

tile_layer_hide(999990)
if global.gameProgress<=5000
{
  view_object[0]=noone
}
