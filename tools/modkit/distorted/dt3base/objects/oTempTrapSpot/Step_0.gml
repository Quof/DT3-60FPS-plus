if global.gamePaused=false
{
  trapTime+=1*gDeltaTime
  if bTrapOut=0
  {
    if trapTime=trapDelay
    {
      var xAdj,yAdj;
      xAdj=0; yAdj=0

      if usePosAdj=1 //Adjust x/y position of trap emitted
      {
        if trapDir=0
        {
          xAdj=16
          yAdj=8
        }
        else if trapDir=90
        {
          xAdj=8
          yAdj=0
        }
        else if trapDir=180
        {
          xAdj=0
          yAdj=8
        }
        else if trapDir=270
        {
          xAdj=8
          yAdj=16
        }
      }

      localTrap=instance_create(x+xAdj,y+yAdj,oTempTrap)
      localTrap.sprite_index=trSprite; localTrap.image_speed=trImgSpeed
      localTrap.image_angle=trapDir; localTrap.atkPower=trPower
      localTrap.image_xscale=trXscl; localTrap.image_yscale=trYscl
      if trSprite=sTorchDirA {localTrap.damageType="ELEMENTAL"}
      trapTime=0
      bTrapOut=1
    }
  }
  else
  {
    if trapTime=trDuration
    {
      with localTrap {instance_destroy()}
      trapTime=0
      bTrapOut=0
    }
  }
}
