//if chao is in this section, activate the corrosponding form

//first check mana
if oIdentifier.currentMana >= manaCost
{
    if place_meeting(x, y, oIdentifier)
    {
        oIdentifier.currentMana -= manaCost
        if transformStyle = 1
        {
            targetCircleID.transformStyle = transformStyle
            targetCircleID.transformColor = transformColor
            targetCircleID.alarm[0] = 1
        }
        else
        {
            defSpot = instance_create(targetCircleID.x, targetCircleID.y, oDefensiveChaoSpot)
            defSpot.transformColor = transformColor
            defSpot.alarm[0] = 1
            with targetCircleID
            {
                instance_destroy()
            }
            with oChaoChoiceQuadrent
            {
                instance_destroy()
            }
        }
    }

    
    
}

instance_destroy()
targetCircleID.halted = false
