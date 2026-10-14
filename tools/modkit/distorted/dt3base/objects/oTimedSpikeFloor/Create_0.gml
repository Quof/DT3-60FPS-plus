event_inherited()

image_angle=180
x+=15
y+=16

//Enemy base statistics
atkPower=8
bCanTakeDamage=false
bShowHealthBar=false
bOut=1
switchTime=0
switchDelay=60
if variable_local_exists("bReverse")
{
  sprite_index=sTimedSpikeIn
  bCanDealDamage=0
}
if variable_local_exists("newTime")
  switchDelay=newTime
