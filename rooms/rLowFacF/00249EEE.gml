swAmount=4
switchID[0]=(GID(377509)); switchCache[0]=377509
switchID[1]=(GID(377510)); switchCache[1]=377510
switchID[2]=(GID(377511)); switchCache[2]=377511
switchID[3]=(GID(377512)); switchCache[3]=377512

if global.gameProgress>=4390
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
