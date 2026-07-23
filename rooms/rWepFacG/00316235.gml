image_yscale=4
swAmount=3
switchID[0]=(GID(365766))
switchID[1]=(GID(365767))
switchID[2]=(GID(365768))

if global.gameProgress>=4310
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
