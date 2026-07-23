image_yscale=2
swAmount=2
switchID[0]=(404616)
switchID[1]=(404617)

if global.newMapX>=512
{
  for(i=0;i<swAmount;i+=1)
  {
    switchID[i].image_speed=1
    switchID[i].activated=2
  }
  instance_destroy()
}
