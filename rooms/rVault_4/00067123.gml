swAmount=3
switchID[0]=(GID(247442))
switchID[1]=(GID(247443))
switchID[2]=(GID(247444))

if global.gameProgress>=2280
{
  for(i=0;i<swAmount;i+=1)
    switchID[i].activated=2
  instance_destroy()
}
