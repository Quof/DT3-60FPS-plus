if global.gamePaused=false
{
  //if atkProg>=1 and atkProg<=5
  if atkProg>=1 and atkProg<6 //60fps change: covers all of tick 5 (atkProg 5-5.75 at 120fps), so the shield grows to full size (it stopped at 0.925 instead of 1.0)
  {
    atkProg+=1*gDeltaTime
    image_xscale+=0.1*gDeltaTime
    image_yscale+=0.1*gDeltaTime
  }
  else if atkProg>=10
  {
    image_xscale-=0.19*gDeltaTime
    image_yscale-=0.19*gDeltaTime
    image_alpha-=0.1*gDeltaTime
    if image_alpha<=0.5 {instance_destroy()}
  }
}
