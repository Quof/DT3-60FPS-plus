bShowArrow=true
exitType=0
if global.gameProgress>=4330
{
  newMapX=144
  newMapY=352
  toRoom=rLowFacA
}
else
{
  newMapX=240
  newMapY=192
  toRoom=rWepFacL
}

if global.gameProgress<=4310 {instance_destroy()}
