image_yscale=1.75
swAmount=2
switchID[0]=(GID(436920))
switchID[1]=(GID(436921))

if global.gameProgress>=5060
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].activated=1
  }
}
