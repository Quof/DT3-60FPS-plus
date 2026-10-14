event_inherited()

image_speed=random(0.25)+0.25

//Enemy base statistics
atkPower=10
bCanTakeDamage=false
bShowHealthBar=false

x+=8
y+=8

if room=rTD_Lv4 //spsp ns
{
  image_yscale=0.625
  y+=3
}
//anger only
chase=0
atime=0
aspeed=9
