swAmount=3
switchID[0]=(GID(249425))
switchID[1]=(GID(249426))
switchID[2]=(GID(249427))

if global.gameProgress>=2310
{
  for(i=0;i<swAmount;i+=1)
    switchID[i].activated=2
  instance_destroy()
}
