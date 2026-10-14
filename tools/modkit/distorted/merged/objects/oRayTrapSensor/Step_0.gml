if global.gamePaused=false
{
  sensorTime+=1*gDeltaTime
  if bSensorActive=0
  {
    if sensorTime>=timeToON {sensorTime=0; bSensorActive=1}
  }
  else if bSensorActive=1
  {
    if sensorTime>=timeToOFF {sensorTime=0; bSensorActive=0}
  }

  if bSensorActive=1
  {
    if collision_line(x,y,x+xOffset,y+yOffset,oPlayer1,1,1) //----- Player touches laser -----
    {
      if room=rMega4_SigmaA4 //Achievement
      {
        oEvAchCheckG4_SA4.achProg=10
      }
      else if room=rBT_ZeroA or room=rBT_ZeroB or room=rBT_ZeroC or room=rBT_ZeroD //Zero's map
      {
        oPlayer1.dashEnergy=0
      }
      oRayTrap.checkArea=1
      if instance_exists(oDRayTrap) {oDRayTrap.checkArea=1} //spsp
    }
  }
}
