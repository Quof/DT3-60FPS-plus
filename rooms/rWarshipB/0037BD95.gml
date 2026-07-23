image_yscale=2.25
swAmount=3
switchID[0]=(GID(437776))
switchID[1]=(GID(437777))
switchID[2]=(GID(437779))

if global.gameProgress>=5100
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].activated=1
  }
}
