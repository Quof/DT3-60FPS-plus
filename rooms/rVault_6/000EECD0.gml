swAmount=2
switchID[0]=(249234)
switchID[1]=(249235)

if global.gameProgress>=2310
{
  for(i=0;i<swAmount;i+=1)
    switchID[i].activated=2
  instance_destroy()
}
