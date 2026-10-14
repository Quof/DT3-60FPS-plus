if global.gamePaused=false
{
  //rotation+=rotSpd
  rotation+=rotSpd*gDeltaTime //60fps change: per frame
  if abs(rotation)>360 {rotation=rotation mod 360}
  for(i=0;i<spokes;i+=1)
  {
    myPoints[i].x=x+lengthdir_x(radius,(i*omegaDist)+rotation)
    myPoints[i].y=y+lengthdir_y(radius,(i*omegaDist)+rotation)
    //dye changes?
  }
}
