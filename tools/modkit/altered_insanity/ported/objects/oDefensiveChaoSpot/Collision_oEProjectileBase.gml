if global.gamePaused=0
{
    if transformColor = 1 //red delete bulelts
    {
        awardAwesome(100)
        with other 
        {
            instance_destroy()
        }
    }
    if transformColor = 2 //blue reflect bullet
    {
        //if other.speed != 0
        //{
        //    dir = other.image_angle
        //    spd = other.speed
        //(60fps change: the game's projectiles move by _speed; the built-in speed is 0 for them, so nothing was reflected)
        spd = other._speed
        if spd = 0 {spd = other.speed}
        if spd != 0
        {
            dir = other.image_angle
            newX = other.x
            newY = other.y
            atk = other.atkPower
            awardAwesome(100)
            with other 
            {
                instance_destroy()
            }
            
            inst = instance_create(newX, newY, oVP_ChaoBullet)
            
            inst.image_angle = dir + 180
            //inst.direction = dir + 180
            //inst.speed = spd
            inst._direction = dir + 180 //60fps change: the Chao bullet moves by _direction/_speed
            inst._speed = spd //60fps change
            inst.atkPower = 100
        }
    }
    if transformColor = 3 //green health bullet absorb
    {
        with other 
        {
            oPlayer1.life+=1
            playSound(global.snd_HealthPickup,0,1,1)
            awardAwesome(100)
            instance_destroy()
        }
    }
}
