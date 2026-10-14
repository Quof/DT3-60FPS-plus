event_inherited()
image_speed=0
image_angle=270
_direction=270

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2

atkProg=0
atkTime=15
atkDelay=170
turnSpd=1.5

bDestroyMe=0

for(i=0;i<8;i+=1)
{
  connectorUp[i]=1
  connectorSize[i]=0.2+(i*0.15)
}

_direction=0
