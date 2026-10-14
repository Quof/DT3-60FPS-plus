///PHASE 1 - PDH
if bossProgress=0 and atkTime[0]>=17
{   
    atkTime[0]=0
    //red circle centre
    shootAppleCircle(x+irandom(95)-48,y+irandom(31),oApRed,23,5,irandom(359),0,0,-1)
}
else if bossProgress=1
{
    if atkTime[0]>=40
    {
        //red circle left
        cycleCounter+=1
        if cycleCounter>=7
        {
            cycleCounter=0
            cycleColour=oApBlue
        }
        shootAppleCircle(x-16-irandom(48),y+irandom(31)-16,cycleColour,28,3.5,irandom(359),0,0,-1)
        atkTime[0]=0
        if cycleCounter=0 {cycleColour=oApRed}
    }
    if atkTime[1]>=50
    {
        //red circle right
        cycleCounter+=1
        if cycleCounter>=7
        {
            cycleCounter=0
            cycleColour=oApBlue
        }
        shootAppleCircle(x+16+irandom(47),y+irandom(31)-16,cycleColour,28,3.5,irandom(359),0,0,-1)
        atkTime[1]=0
        if cycleCounter=0 {cycleColour=oApRed}
    }
}
else if bossProgress=2
{
    if atkTime[0]>=30
    {
        //green circles left and right
        cycleCounter+=1
        tempX=x-16-irandom(48)
        tempY=y+irandom(31)-16
        tempDir=irandom(359)
        if cycleCounter>=5
        {
            tempDir=point_direction(tempX,tempY,oPlayer1.x,returnPlayerYCenter())
            cycleCounter=0
        }
        shootAppleCircle(tempX,tempY,oApGreen,17,2.5,tempDir,0,0,-1)
        cycleCounter+=1
        tempX=x+16+irandom(47)
        tempY=y+irandom(31)-16
        tempDir=irandom(359)
        if cycleCounter>=5
        {
            tempDir=point_direction(tempX,tempY,oPlayer1.x,returnPlayerYCenter())
            cycleCounter=0
        }
        shootAppleCircle(tempX,tempY,oApGreen,17,2.5,tempDir,0,0,-1)
        atkTime[0]=0
    }
    if atkTime[1]=30
    {
        //red circle right
        shootAppleCircle(1040,y+48,oApRed,17,2,irandom(359),0,0,-1)
    }
    else if atkTime[1]>=60
    {
        //red circle left
        shootAppleCircle(688,y+48,oApRed,17,2,irandom(359),0,0,-1)
        atkTime[1]=0
    }
}
else if bossProgress=3
{
    if atkTime[0]>=60
    {
        //red circle left
        cycleCounter+=1
        if cycleCounter>=7
        {
            cycleCounter=0
            cycleColour=oApBlue
        }
        shootAppleCircle(x-16-irandom(48),y+irandom(31)-16,cycleColour,18,1.75,irandom(359),0,0,-1)
        atkTime[0]=0
        if cycleCounter=0 {cycleColour=oApRed}
    }
    if atkTime[1]>=60
    {
        //red circle right
        cycleCounter+=1
        if cycleCounter>=7
        {
            cycleCounter=0
            cycleColour=oApBlue
        }
        shootAppleCircle(x+16+irandom(47),y+irandom(31)-16,cycleColour,18,1.75,irandom(359),0,0,-1)
        atkTime[1]=0
        if cycleCounter=0 {cycleColour=oApRed}
    }
    if atkTime[2]>=60
    {
        //red circle right
        shootAppleCircle(1040,y+48,oApGreen,18,2.5,irandom(359),0,0,-1)
        atkTime[2]=0
    }
    else if atkTime[2]=30
    {
        //red circle left
        shootAppleCircle(688,y+48,oApGreen,18,2.5,irandom(359),0,0,-1)
    }
}
