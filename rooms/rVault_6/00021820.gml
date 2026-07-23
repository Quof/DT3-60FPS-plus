swAmount=2
switchID[0]=(249421)
switchID[1]=(249422)

if global.gameProgress>=2310
{
  for(i=0;i<swAmount;i+=1)
    switchID[i].activated=2
  instance_destroy()
}
