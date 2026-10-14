if global.gamePaused=false
{
  image_angle+=spinSpd*gDeltaTime
  //image_xscale-=0.02//5
  //image_yscale-=0.02//5
  image_xscale-=0.02*gDeltaTime //5. 60fps change: per frame
  image_yscale-=0.02*gDeltaTime //5. 60fps change: per frame
  if image_xscale<=0
  {
    if bDestroyOnSize=1 {instance_destroy()}
    if image_xscale<=-startScale {instance_destroy()}
  }
}
