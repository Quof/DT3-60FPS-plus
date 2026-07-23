image_yscale=2.25
swAmount=2
switchID[0]=(GID(364249))
switchID[1]=(GID(364250))

if global.gameProgress>=4290
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
