tAngle = 0

if shootSet = 1
{
    shootSet = 2
}
else
{
    shootSet = 1
    tAngle = 45
}

for (i=0; i<4; i+=1)
{
    var tAtk;
    tAtk=instance_create(x,y,oPassBullet)
    tAtk.sprite_index=sWarmasterD_EX_Ball; tAtk.atkPower=global.pMaxLife/4; tAtk.bulletSpeed=6
    //tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.image_speed=0.33; tAtk.direction=tAngle; tAtk.image_angle = tAngle
    tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.image_speed=0.33; tAtk._direction=tAngle; tAtk.image_angle = tAngle //60fps change: oPassBullet moves by _direction

    tAngle+=90
    //alarm[0] = shootMaxInterval
    alarm[0] = shootMaxInterval/gDeltaTime //60fps change: alarms count frames
}
