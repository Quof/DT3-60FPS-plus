///Split bullet
//(60fps change: _direction for direction: the bullets move by _direction/_speed)

if maxSplits = 2
{
    //dirStart = direction - 15
    dirStart = _direction - 15
    dirIncrement = 30

}
else if maxSplits = 3
{
        //dirStart = direction - 30
        dirStart = _direction - 30
    dirIncrement = 30
}
else if maxSplits = 4
{
    //dirStart = direction - 45
    dirStart = _direction - 45
    dirIncrement = 30
}

for (i=0; i<maxSplits; i+=1)
{
    tAtk = instance_create(x,y,oChaoBullet)
    //tAtk.direction = dirStart + (dirIncrement*i)
    //tAtk.image_angle = tAtk.direction
    tAtk._direction = dirStart + (dirIncrement*i)
    tAtk.image_angle = tAtk._direction

    tAtk.maxSpeed = maxSpeed
    tAtk.atkPower = atkPower
    tAtk.explodeLevel = explodeLevel
    tAtk.bounceLevel = bounceLevel
    tAtk.homeLevel = homeLevel
    tAtk.splitLevel = splitLevel
    tAtk.meleeLevel = meleeLevel
    tAtk.shieldLevel = shieldLevel

    tAtk.arcLevel = arcLevel

    tAtk.alarm[2] = 2
}

instance_destroy()
