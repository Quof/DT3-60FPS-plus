if global.gamePaused=false
{
  if bRunThrough=0
  {
    spinFrm+=1*gDeltaTime
    if spinFrm=3 {image_index=1}
    else if spinFrm=6 {image_index=2}
    else if spinFrm=9 {image_index=3}
    else if spinFrm=12 {image_index=4}
    else if spinFrm=15 {image_index=3}
    else if spinFrm=18 {image_index=2}
    else if spinFrm=21 {image_index=1}
    else if spinFrm=24 {image_index=0; spinFrm=0}
  }
}
