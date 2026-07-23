locationCheck(58)
if global.gameProgress>=3870 {global.mapTeleport=23}
background_hspeed[0]=-1
background_vspeed[0]=0.5

gameScene=instance_create(0,0,oEvCh15MainA)
mapScene=instance_create(0,0,oEvCh15SideA)

if global.gameProgress<=3840
{
  var dunStateA,dunStateB,dunStateC;
  dunStateA=string_char_at(global.gameGate6Prog,1)
  dunStateB=string_char_at(global.gameGate6Prog,2)
  dunStateC=string_char_at(global.gameGate6Prog,3)
  if dunStateA="1" and dunStateB="1" and dunStateC="1" {global.gameProgress=3850}
}

if global.gameProgress>=3850
{
  tile_layer_hide(999990)
  with (GID(341972)) {instance_destroy()}
}

var tempMplay;
tempMplay=findMusic(604)
playMusic(tempMplay,0,0)
