if atkProg=2
{
  with other
  {
    for(i=0;i<4;i+=1)
    {
      newEffect=instance_create(x+8,y+8,oEfMarioBlock)
      newEffect.type=i
    }
    instance_destroy()
  }
}
