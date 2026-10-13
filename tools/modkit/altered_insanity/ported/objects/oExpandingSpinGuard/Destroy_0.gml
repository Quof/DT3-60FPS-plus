for(i=0;i<4;i+=1)
{
  if instance_exists(shieldPart[i])
  {
    with shieldPart[i] {instance_destroy()}
  }
}
