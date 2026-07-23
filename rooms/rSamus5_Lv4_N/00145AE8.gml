bShowArrow=false
exitType=1
if global.gameProgress<=3000
{
  newMapX=320
  newMapY=80
  toRoom=rSamus5_Lv4_FinalBoss
}
else if global.gameProgress>=3020 or global.gameProgress<=3030
{
  newMapX=240
  newMapY=208
  toRoom=rSamus5_Lv4_RidleyTunnel
}
else if global.gameProgress>=3040
{
  newMapX=160
  newMapY=64
  toRoom=rSamus5_EscapeA
}
image_xscale=4
