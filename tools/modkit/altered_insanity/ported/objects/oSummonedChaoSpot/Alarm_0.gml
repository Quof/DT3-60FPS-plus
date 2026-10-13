///Changing Color

//First transform (circle)

if transformStyle != 4
{
    if transformStyle = 1
    {
        if transformColor = 1
        {
            image_blend=c_red
        }
        if transformColor = 2
        {
            image_blend=c_blue
            autoFire = true
            atkPower-=50 //from -10
            maxShotDelay+=1 
        }
        if transformColor = 3
        {
            image_blend=c_green
            autoAim = true
            atkPower-=25 //from -10
        }
        if transformColor = 4
        {
            image_blend=c_yellow
            bulletSpread += 4 //5 spread
            atkPower -= 50
            maxShotDelay+=1
        }
    }
    
    if transformStyle = 3
    {
        //Second transform
        if transformAddColor = 1
        {
            second_blend=c_red
        }
        if transformAddColor = 2
        {
            second_blend=c_blue
            autoFire = true
            //atkPower-=10 maybe second levels should not have atk penalty
            if transformColor != 2
            {
                maxShotDelay+=2 //adding blue to a non blue will make the autofire slower
            }
            else
            {
                maxShotDelay-=2 //otherwise it gets real fast
            }
        }
        if transformAddColor = 3
        {
            second_blend=c_green
            autoAim = true
            if transformColor != 3
            {
                bulletSpeed -= 2 //makes bullets slightly slower if it wasn't green already
            }
            else
            {
                atkPower+= 25//otherwise it gets real powerful
                bulletSpeed += 6 //and bullets get faster too
            }
            
        }
        if transformAddColor = 4
        {
            second_blend=c_yellow
            bulletSpread += 2 //3 spread for dual color, 7 for pure
            //atkPower -= 10
            maxShotDelay+=1
        }
    }
}

decayTime=maxDecayTime
