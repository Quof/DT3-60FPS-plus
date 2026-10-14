///PHASE 5 - Mashing Wachine
// 0 - time
// 1&2 - red spirals
// 3&4 - blue/green spam

//two red spirals, second starting after half rot of first
if atkTime[4]>0 and atkTime[1]>=10
{
    shootAppleCircle(x,y,oApRed,2,redspeed,angleOne,0,0,-1)
    angleOne-=9.9 //orig: 2.2
    atkTime[1]=0
}
if atkTime[4]>820 and atkTime[2]>=10
{
    shootAppleCircle(x,y,oApRed,2,redspeed,angleTwo,0,0,-1)
    angleTwo+=14.4 //orig: 3.2
    atkTime[2]=0
}

//greens and lifeline

// alternatives: slanted walls from right (blue) and left (green)

if atkTime[4] mod 270 = 0
{
    //shootStraightApples(originX,originY,spawnDirection,spawnDistance,spawnAccel,number,colour,speed,direction,decay)
    var Apple;
    Apple=instance_create(608,272,oApBlue)
    //Apple.bulSpd=4; Apple.decay=-1; Apple.direction=0; Apple.type=0
    Apple.bulSpd=4; Apple.decay=-1; Apple._direction=0; Apple.type=0 //60fps change: DT3+'s Executive bullets move by their own _direction
    shootStraightApples(600,240,180,8,0,3,oApGreen,4,0,-1)
    shootStraightApples(600,256,180,8,0,3,oApGreen,4,0,-1)
    shootStraightApples(600,272,180,8,0,3,oApGreen,4,0,-1)
    shootStraightApples(600,288,180,8,0,3,oApGreen,4,0,-1)
    shootStraightApples(600,304,180,8,0,3,oApGreen,4,0,-1)
    Apple=instance_create(576,272,oApBlue)
    //Apple.bulSpd=4; Apple.decay=-1; Apple.direction=0; Apple.type=0
    Apple.bulSpd=4; Apple.decay=-1; Apple._direction=0; Apple.type=0 //60fps change: DT3+'s Executive bullets move by their own _direction
}
else if atkTime[4] mod 135 = 0
{
    var Apple;
    Apple=instance_create(1120,272,oApBlue)
    //Apple.bulSpd=4; Apple.decay=-1; Apple.direction=180; Apple.type=0
    Apple.bulSpd=4; Apple.decay=-1; Apple._direction=180; Apple.type=0 //60fps change: DT3+'s Executive bullets move by their own _direction
    shootStraightApples(1128,240,0,8,0,3,oApGreen,4,180,-1)
    shootStraightApples(1128,256,0,8,0,3,oApGreen,4,180,-1)
    shootStraightApples(1128,272,0,8,0,3,oApGreen,4,180,-1)
    shootStraightApples(1128,288,0,8,0,3,oApGreen,4,180,-1)
    shootStraightApples(1128,304,0,8,0,3,oApGreen,4,180,-1)
    Apple=instance_create(1152,272,oApBlue)
    //Apple.bulSpd=4; Apple.decay=-1; Apple.direction=180; Apple.type=0
    Apple.bulSpd=4; Apple.decay=-1; Apple._direction=180; Apple.type=0 //60fps change: DT3+'s Executive bullets move by their own _direction
}

//rotation
tempDir=sin(pi*(atkTime[0]-400)/300) //before: /600
with oApRed
{
    if decay=-2
    {
        //bulSpd+=abs(tempDir)/10 // :/
        //direction-=2*tempDir
        bulSpd+=abs(tempDir)/10*gDeltaTime // :/. 60fps change: per frame
        _direction-=2*tempDir*gDeltaTime //60fps change: per frame, DT3+'s _direction
    }
}
//with oApBlue {direction-=tempDir}

//blue/green spam
if atkTime[0]>400 and atkTime[0]<1001 and atkTime[3]>=20
{
    shootAppleCircle(x,y,oApRed,10,otherspeed,angleThree,0,0,-2)
    /*cycleCounter+=1
    if cycleCounter<5
    {*/
    shootAppleCircle(x,y,oApRed,10,otherspeed,angleFour,0,0,-2)
    /*}
    else
    {
        shootAppleCircle(x,y,oApBlue,12,otherspeed,angleFour,0,0,200)
        cycleCounter=0
    }*/
    angleThree+=1
    angleFour+=1.5
    atkTime[3]=0
}
else if atkTime[0]>1000 and atkTime[0]<1601 and atkTime[3]>=20
{
    shootAppleCircle(x,y,oApRed,10,otherspeed,angleThree,0,0,-2)
    /*cycleCounter+=1
    if cycleCounter<5
    {*/
    shootAppleCircle(x,y,oApRed,10,otherspeed,angleFour,0,0,-2)
    /*}
    else
    {
        shootAppleCircle(x,y,oApBlue,12,otherspeed,angleFour,0,0,200)
        cycleCounter=0
    }*/
    angleThree-=1
    angleFour-=1.5
    atkTime[3]=0
}
else if atkTime[0]>=1601
{
    atkTime[0]=401
}
