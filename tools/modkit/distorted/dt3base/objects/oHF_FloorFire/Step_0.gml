if global.gamePaused=false
{
  fireFrm+=0.33*gDeltaTime
  if fireProg=0
  {
    image_alpha+=0.04*gDeltaTime
    if image_alpha>=1 {fireProg+=1}
  }
  else if fireProg=1
  {
    y-=2*gDeltaTime
    if y<=272 {fireProg+=1}
  }
  else if fireProg=2
  {
    fireTime+=1*gDeltaTime
    if fireTime>=100
    {
      image_alpha-=0.05*gDeltaTime
      if image_alpha<=0.5 {instance_destroy()}
    }
  }
}
