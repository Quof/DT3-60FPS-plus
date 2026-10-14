if variable_local_exists("objectUseN")
  objectUse=objectUseN
if variable_local_exists("spriteUseN")
  spriteUse=spriteUseN
if variable_local_exists("shootTimeN")
  shootTime=shootTimeN
if variable_local_exists("shootDelayN")
  shootDelay=shootDelayN
if variable_local_exists("atkPowerN")
  atkPower=atkPowerN
if variable_local_exists("dirN")
  dir=dirN
if variable_local_exists("bulletSpeedN")
  bulletSpeed=bulletSpeedN

if shootDelay<2
  shootDelay=2

if room=rWarshipZ_A or room=rWarshipZ_B or room=rWarshipZ_C or room=rWarshipZ_D or room=rWarshipZ_F
{
  atkPower=14
}
