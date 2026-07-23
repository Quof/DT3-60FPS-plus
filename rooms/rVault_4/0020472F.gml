swAmount=2
switchID[0]=(GID(247301))
switchID[1]=(GID(247302))

if global.gameProgress>=2280
{
  for(i=0;i<swAmount;i+=1)
    switchID[i].activated=2
  instance_destroy()
}
