locationCheck(90)

gameScene=instance_create(0,0,oEvDCS)
mapScene=instance_create(0,0,oEvCh19SideA)

runeCheck=string_char_at(global.gameDCS_Prog,4)
if runeCheck!="5" and runeCheck!="9"
{
  with oEnemyBase {instance_destroy()}
}

var tempMplay;
tempMplay=findMusic(6)
playMusic(tempMplay,0,0)
