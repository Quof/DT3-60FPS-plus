if global.gamePaused=false
{
  image_angle+=spinSpd*gDeltaTime

  image_xscale-=0.025*gDeltaTime
  image_yscale-=0.025*gDeltaTime
  if image_xscale<=0
  {
    if bDestroyOnSize=1 {instance_destroy()}
    if image_xscale<=-startScale {instance_destroy()}
  }
}
