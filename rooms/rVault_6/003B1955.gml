swAmount=3
switchID[0]=(249425)
switchID[1]=(249426)
switchID[2]=(249427)

if global.gameProgress>=2310
{
  for(i=0;i<swAmount;i+=1)
    switchID[i].activated=2
  instance_destroy()
}
