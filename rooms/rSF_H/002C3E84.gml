swAmount=7
switchID[0]=(GID(417955))
switchID[1]=(GID(417956))
switchID[2]=(GID(417957))
switchID[3]=(GID(417958))
switchID[4]=(GID(417964))
switchID[5]=(GID(417965))
switchID[6]=(GID(417966))

if global.gameProgress>=4930
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].activated=1
  }
}
