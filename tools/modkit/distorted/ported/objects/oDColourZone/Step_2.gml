if global.gamePaused=false and room!=rHexPlat54
{
  if bFollow=1
  {
    if instance_exists(idFollow)
    {
      x=idFollow.x
      y=idFollow.y
    }
    //else {instance_destroy()} //spsp ns, maybe?
  }
}
