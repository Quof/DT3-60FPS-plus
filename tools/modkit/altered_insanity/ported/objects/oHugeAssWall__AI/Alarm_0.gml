if x<oPlayer1.x {instance_destroy()}
else
{
  myTurretA=instance_create(x+9,y+52,oHAW_Gun); myTurretA.gunShot=0
  myTurretB=instance_create(x+41,y+52,oHAW_Gun); myTurretB.gunShot=27
  mySolid=instance_create(x+48,y,oSolid); mySolid.sprite_index=sInvisibleSolidMask; mySolid.visible=0
  mySolid.image_xscale=2; mySolid.image_yscale=10
}
