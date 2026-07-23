locationCheck(40)
if global.gameProgress>=2550 {global.mapTeleport=15}
global.partySplit=0
global.bCanSave=1
global.vaultRooms=1

gameScene=instance_create(0,0,oEvCh10MainA)
instance_create(0,0,oVaultVisualControl)

if global.gameProgress=2470
{
  vaultMaze[0]=string_char_at(global.gameVaultProg,1)
  vaultMaze[1]=string_char_at(global.gameVaultProg,2)
  vaultMaze[2]=string_char_at(global.gameVaultProg,3)
  vaultMaze[3]=string_char_at(global.gameVaultProg,4)
  var tLockChk;
  tLockChk=0
  for(i=0;i<4;i+=1)
  {
    if vaultMaze[i]="9" {tLockChk+=1}
  }
  if tLockChk=4 {global.gameProgress=2480}
}

var tempMplay;
tempMplay=findMusic(11)
playMusic(tempMplay,0,0)
