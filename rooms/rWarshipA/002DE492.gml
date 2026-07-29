image_yscale=6
swAmount=3
switchID[0]=(GID(436934)); switchCache[0]=436934
switchID[1]=(GID(436935)); switchCache[1]=436935
switchID[2]=(GID(436936)); switchCache[2]=436936

if global.gameProgress>=5060
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].activated=1
  }
}
