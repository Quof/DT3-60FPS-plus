if global.gamePaused=false
{
  x+=moveSpd*image_xscale*gDeltaTime
  atkTime+=1*gDeltaTime
  if atkTime=3 {image_index=1}
  else if atkTime=6 {image_index=2}
  else if atkTime=9 {image_index=3}
  else if atkTime=12 {image_index=4}
  else if atkTime>=15 {instance_destroy()}
}
