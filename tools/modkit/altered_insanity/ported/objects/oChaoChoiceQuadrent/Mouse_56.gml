//if chao is in this section, activate the corrosponding form

//first check mana
if oIdentifier.currentMana >= manaCost
{
    if place_meeting(x, y, oIdentifier)
    {
        oIdentifier.currentMana -= manaCost
        targetCircleID.transformStyle = transformStyle
        if transformStyle =1
        {
            targetCircleID.transformColor = transformColor
        }
        else if transformStyle = 3
        {
            targetCircleID.transformAddColor = transformColor
        }
        else if transformStyle = 4
        {
            if targetCircleID.bulletColor1 = 0
            {
                bulletColor1 = transformColor
            }
            else if targetCircleID.bulletColor2 = 0
            {
                bulletColor2 = transformColor
            }
            else if targetCircleID.bulletColor3 = 0
            {
                bulletColor3 = transformColor
            }
            
            //add to bullet paramters on the circle
            if transformColor = 1
            {
                targetCircleID.explodeLevel+=1
            }
            if transformColor = 2
            {
                targetCircleID.bounceLevel+=1
            }
            if transformColor = 3
            {
                targetCircleID.homeLevel+=1
            }
            if transformColor = 4
            {
                targetCircleID.splitLevel+=1
            }
            if transformColor = 5
            {
                targetCircleID.meleeLevel+=1
            }
            if transformColor = 6
            {
                targetCircleID.shieldLevel+=1
            }
            if transformColor = 7
            {
                
            }
            if transformColor = 8
            {
                targetCircleID.arcLevel+=1
            }
        }
        targetCircleID.alarm[0] = 1
    }

    
    
}

instance_destroy()
targetCircleID.halted = false
