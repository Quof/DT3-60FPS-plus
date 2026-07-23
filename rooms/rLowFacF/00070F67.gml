swAmount=3
switchID[0]=(GID(377505))
switchID[1]=(GID(377506))
switchID[2]=(GID(377507))

if global.gameProgress>=4390
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
