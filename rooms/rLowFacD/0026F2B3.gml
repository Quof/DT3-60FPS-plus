swAmount=3
switchID[0]=(GID(376111)); switchCache[0]=376111
switchID[1]=(GID(376112)); switchCache[1]=376112
switchID[2]=(GID(376113)); switchCache[2]=376113

if global.gameProgress>=4361
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
