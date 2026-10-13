if transformColor = 1
{
    image_blend=c_red
}
if transformColor = 2
{
    image_blend=c_blue
}
if transformColor = 3
{
    image_blend=c_green
}
if transformColor = 4
{
    image_blend=c_yellow
}
if transformColor = 5
{
    image_blend=c_aqua
}
if transformColor = 6
{
    image_blend=c_orange
}
if transformColor = 7
{
    image_blend=c_black
}
if transformColor = 8
{
    image_blend=c_white
}


if transformStyle = 1 or transformStyle = 3
{
    if transformColor = 1
    {
        manaCost = oIdentifier.atkRedCost
    }
    else if transformColor = 2
    {
        manaCost = oIdentifier.atkBlueCost
    }
    else if transformColor = 3
    {
        manaCost = oIdentifier.atkGreenCost
    }
    else if transformColor = 4
    {
        manaCost = oIdentifier.atkYellowCost
    }   
}

else if transformStyle = 2
{
    if transformColor = 1
    {
        manaCost = oIdentifier.defRedCost
    }
    else if transformColor = 2
    {
        manaCost = oIdentifier.defBlueCost
    }
    else if transformColor = 3
    {
        manaCost = oIdentifier.defGreenCost
    }
    else if transformColor = 4
    {
        manaCost = oIdentifier.defYellowCost
    }
}

else if transformStyle = 4
{
    if transformColor = 1
    {
        manaCost = oIdentifier.bulRedCost
    }
    else if transformColor = 2
    {
        manaCost = oIdentifier.bulBlueCost
    }
    else if transformColor = 3
    {
        manaCost = oIdentifier.bulGreenCost
    }
    else if transformColor = 4
    {
        manaCost = oIdentifier.bulYellowCost
    }
    else if transformColor = 5
    {
        manaCost = oIdentifier.bulCyanCost
    }
    else if transformColor = 6
    {
        manaCost = oIdentifier.bulOrangeCost
    }
    else if transformColor = 7
    {
        manaCost = oIdentifier.bulBlackCost
    }
    else if transformColor = 8
    {
        manaCost = oIdentifier.bulWhiteCost
    }
}

targetCircleID.halted = true
