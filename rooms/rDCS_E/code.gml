locationCheck(90)

gameScene=instance_create(0,0,oEvDCS)
mapScene=instance_create(0,0,oEvCh19SideA)

runeCheckA=string_char_at(global.gameDCS_Prog,1)
runeCheckB=string_char_at(global.gameDCS_Prog,2)
runeCheckC=string_char_at(global.gameDCS_Prog,3)
runeCheckD=string_char_at(global.gameDCS_Prog,4)
if runeCheckA!="9" or runeCheckC!="9"
{
  with (GID(407952)) {instance_destroy()}
  tile_layer_hide(999999)
}

if runeCheckA!="9" or runeCheckB!="9" or runeCheckC!="9" or runeCheckD!="9"
{
  with (GID(409400)) {instance_destroy()}
}

var tempMplay;
tempMplay=findMusic(6)
playMusic(tempMplay,0,0)
