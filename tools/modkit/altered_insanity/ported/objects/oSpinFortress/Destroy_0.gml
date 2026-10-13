for(i=0;i<8;i+=1)
{
  if instance_exists(shieldPart[i])
  {
    with shieldPart[i] {instance_destroy()}
  }
}
