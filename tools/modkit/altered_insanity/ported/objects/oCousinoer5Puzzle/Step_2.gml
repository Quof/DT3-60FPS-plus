if splitGoalCheck=0
{
  if room=rC5_NoWalk15
  {
    if (478464).isActive=1 and (478465).isActive=1
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      with oEventBarrier {instance_destroy()}
      splitGoalCheck=1
    }
  }
}
