image_yscale=7
swAmount=6
switchID[0]=(GID(438460)); switchCache[0]=438460
switchID[1]=(GID(438461)); switchCache[1]=438461
switchID[2]=(GID(438463)); switchCache[2]=438463
switchID[3]=(GID(438464)); switchCache[3]=438464
switchID[4]=(GID(438465)); switchCache[4]=438465
switchID[5]=(GID(438466)); switchCache[5]=438466

if global.gameProgress>=5120
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].activated=1
  }
}
