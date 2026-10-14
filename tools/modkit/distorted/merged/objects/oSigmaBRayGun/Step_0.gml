if global.gamePaused=false
{
  //x=oSigmaB.sigParts[2].x-148
  //y=oSigmaB.sigParts[2].y-34
  x=oSigmaB.sigParts[2].x-lengthdir_x(148,image_angle-180)
  y=oSigmaB.sigParts[2].y-34-lengthdir_y(148,image_angle-180)
  image_angle=oSigmaB.sigParts[2].image_angle-180
  if atkProg=0 //Grow x scale
  {
    image_xscale+=0.2*gDeltaTime
    if image_xscale>=2
    {
      image_xscale=2
      atkProg=1
    }
  }
  else if atkProg=1 //Grow y scale
  {
    image_yscale+=0.2*gDeltaTime
    if image_yscale>=2.5 //2 //spsp ns
    {
      image_yscale=2.5 //2 //spsp ns
      atkProg=2
    }
  }
  else if atkProg=3 //Shrink down
  {
    image_xscale-=0.2*gDeltaTime
    image_yscale-=0.2*gDeltaTime
    if image_xscale<=0.2 {instance_destroy()}
  }
}
