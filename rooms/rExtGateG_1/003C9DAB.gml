enemySpawn=oPT_Slime
type=0
xSpawn=x+16
ySpawn=y-192
activate=1
lvlMin=50
lvlMax=50
if global.stJGame_C[1]>50
{
  lvlMax=global.stJGame_C[1]
  if lvlMax>60 {lvlMax=60}
}
