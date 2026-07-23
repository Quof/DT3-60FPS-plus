image_yscale=3
swAmount=2
switchID[0]=(GID(381929))
switchID[1]=(GID(381930))

if global.gameProgress>=4460
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
