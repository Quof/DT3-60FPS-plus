#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Temp Trap Object
trapType - The type of trap to use (0 is all custom set, 1-x are prefabs)
trapTime - Starting time for the trap
trapDelay - End time for the trap
trapDir - Direction to use for the trap
*/

x+=8; y+=8
bTrapOut=0 //If the trap is currently out
localTrap=0 //Init trap instance var name

if trapType=1 //Lost Vikings torch
{
  trSprite=sTorchDirA
  trImgSpeed=1; trDuration=45
  trPower=6; usePosAdj=0
  trXscl=1; trYscl=1
}
else if trapType=2 //Gate F torch
{
  trSprite=sTorchDirA
  trImgSpeed=1; trDuration=30
  trPower=8; usePosAdj=0
  trXscl=1.5; trYscl=0.9
}
else if trapType=3 //Tower torch
{
  trSprite=sTorchDirA
  trImgSpeed=1;
  if room=rMain_44_Curse {trDuration=25}
  else {trDuration=40}
  trPower=8; usePosAdj=0
  if room=rDesertedTowerA {trXscl=1.5; trYscl=1}
  else if room=rDesertedTowerC_Secret {trXscl=1; trYscl=1}
  else {trXscl=2; trYscl=1}
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  trapTime+=1
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
