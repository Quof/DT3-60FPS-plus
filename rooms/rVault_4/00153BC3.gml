swAmount=3
switchID[0]=(GID(247592))
switchID[1]=(GID(247593))
switchID[2]=(GID(247594))

if global.gameProgress>=2280
{
  for(i=0;i<swAmount;i+=1)
    switchID[i].activated=2
  instance_destroy()
}
