image_yscale=1.25
swAmount=3
switchID[0]=(GID(375458))
switchID[1]=(GID(375459))
switchID[2]=(GID(375460))

if global.gameProgress>=4351
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
