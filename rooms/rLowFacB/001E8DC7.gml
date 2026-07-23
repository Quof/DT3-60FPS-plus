image_yscale=1.5
swAmount=2
switchID[0]=(GID(375026))
switchID[1]=(GID(375027))

if global.gameProgress>=4350
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
