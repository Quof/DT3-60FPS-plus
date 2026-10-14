///PHASE 2 - Circus

if moveProg=0
{
    moveProg=1
    phaseTwoSpeed=5*0.8
    xvel=phaseTwoSpeed*cos(pi*5/3)
    yvel=-phaseTwoSpeed*sin(pi*5/3)
}
else
{
    if x>=bounceXright and xvel>0 {xvel*=-1; tempFlag=1}
    else if x<=bounceXleft and xvel<0 {xvel*=-1; tempFlag=1}

    if y>=bounceYbottomLow and yvel>0 {yvel*=-1; tempFlag=0}
    else if y<=bounceYtop and yvel<0
    {
        /*yvel*=-1
        if bossProgress=1 {xvel*=1.01; yvel*=1.01}
        //if bossProgress=1 {phaseTwoSpeed*=1.02}
        //direction = 210 + ((17*direction+49) mod 120)
        //xvel=phaseTwoSpeed*cos(direction*pi/180)
        //yvel=-phaseTwoSpeed*sin(direction*pi/180)
        tempFlag=2*/
        //if bossProgress=1 {phaseTwoSpeed*=1.01}
        phaseTwoSpeed*=1.01
        //anotherTemp=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        secondRand=(anotherTemp*227 + 71) mod 55
        anotherTemp=205+secondRand
        //if hspeed>0
        if _hspeed>0 //60fps change: the boss moves by _hspeed/_vspeed
        {
            anotherTemp=270+(270-anotherTemp)
        }
        xvel=phaseTwoSpeed*cos(pi*anotherTemp/180)
        yvel=-phaseTwoSpeed*sin(pi*anotherTemp/180)
        tempFlag=2
    }

    if atkTime[0]>=65
    {
        if bossProgress=0
        {
            tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=1; tNewAtk.myScl=1
            tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
        }
        else
        {
            for(i=0;i<4;i+=1)
            {
                tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=1; tNewAtk.myScl=1.5
                tNewAtk.image_angle=i*45
                tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1.5
                tNewAtk.image_angle=i*45
            }
        }
        atkTime[0]=0
    }

    if tempFlag=1
    {
        tempDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-10
        //shootAppleCircle(x,y,oApBlue,4,7+bossProgress,tempDir,0,0,-1)
        /*for(i=0;i<3;i+=1)
        {*/
        shootAppleCircle(x,y,oApGreen,24,5.5+bossProgress,90,400,180,60)
        //}
        tempFlag=0
    }
    else if tempFlag=2 //reds
    {
        tempDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-12
        //shootAppleCircle(x,y,oApGreen,4,5+bossProgress,tempDir,0,0,-1)
        for(i=1;i<4;i+=1)
        {
            shootAppleCircle(x,y,oApRed,4,3.5+bossProgress,tempDir+i*6,0,0,-1)
        }
        shootAppleCircle(x,y,oApBlue,4,3.5+bossProgress,tempDir,0,0,-1)
        shootAppleCircle(x,y,oApBlue,4,3.5+bossProgress,tempDir+4*6,0,0,-1)
        /*for(i=5;i<12;i+=1)
        {
            shootAppleCircle(x,y,oApBlue,4,6.5+bossProgress,tempDir+i*7.5,0,0,-1)
        }*/
        // slashes
        /*if bossProgress=0
        {
            tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=1; tNewAtk.myScl=1
            tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
        }
        else
        {
            for(i=0;i<4;i+=1)
            {
                tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=1; tNewAtk.myScl=1.5
                tNewAtk.image_angle=i*45
                tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1.5
                tNewAtk.image_angle=i*45
            }
        }*/
        tempFlag=0
    }
}
if bossProgress=1 and atkTime[1]>=200
{
    //for(i=5;i<7;i+=1) {var tAtk; tAtk=instance_create(1120,180+(i*20),oDEX_Fireball); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=180; tAtk.decay=-1}
    for(i=5;i<7;i+=1) {var tAtk; tAtk=instance_create(1120,180+(i*20),oDEX_Fireball); tAtk.type=0; tAtk.bulSpd=3; tAtk._direction=180; tAtk.decay=-1} //60fps change: DT3+'s Executive bullets move by their own _direction
    //for(i=5;i<7;i+=1) {var tAtk; tAtk=instance_create(608,180+(i*20),oDEX_Fireball); tAtk.type=0; tAtk.bulSpd=3; tAtk.direction=0; tAtk.decay=-1}
    for(i=5;i<7;i+=1) {var tAtk; tAtk=instance_create(608,180+(i*20),oDEX_Fireball); tAtk.type=0; tAtk.bulSpd=3; tAtk._direction=0; tAtk.decay=-1} //60fps change: DT3+'s Executive bullets move by their own _direction
    atkTime[1]=0
}
//hspeed=xvel
//vspeed=yvel
_hspeed=xvel //60fps change: moved by correctHSpeedVSpeed in Step, per frame
_vspeed=yvel //60fps change
