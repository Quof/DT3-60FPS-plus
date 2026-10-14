/// AVOIDANCE

/*
shootAppleCircle(originX,originY,colour,number,apspeed,circleDir,radius,setoffAngle,decaytime)
shootStraightApples(originX,originY,spawnDirection,spawnDistance,spawnAccel,number,colour,speed,direction,decay)
heartful(x,y,direction,speed,colour,decay)
*/
if global.gamePaused=false
{
    //for(i=0;i<5;i+=1) {atkTime[i]+=1}
    //t+=1
    for(i=0;i<5;i+=1) {atkTime[i]+=1*gDeltaTime} //60fps change: per frame
    t+=1*gDeltaTime //60fps change: per frame (the checks on t below are on whole ticks, so they still hit once each)
    
    
    if t=start[sp]
    {
        if sp<40 // ------------------------------------------------- start
        {
            if sp mod 10 = 0
            {
                
            }
            else if sp mod 10 = 1
            {
                
            }
            else if sp mod 10 = 2
            {
                
            }
            else if sp mod 10 = 3
            {
                
            }
            else if sp=4 or sp=14 or sp=24
            {
                
            }
            else if sp=34
            {
                //despawn
                
                sp=40-1
            }
            else if sp mod 10 = 5
            {
                
            }
            else if sp mod 10 = 6
            {
                
            }
            else if sp mod 10 = 7
            {
                
            }
            else if sp mod 10 = 8
            {
                
            }
            else if sp=9 or sp=29
            {
                
            }
            else if sp=19
            {
                
            }
        }
        else if sp>=40 and sp<=101 // --------------------------------- before BoWaP
        {
            if sp=51 // BAD
            {
            }
            else if sp=55 //again
            {
            }
            else if sp=65 //six
            {
            }
            else if sp=72 // KISS
            {
            }
            else if sp<=71 // first half
            {
            }
            else
            {
            }
        }
        else if sp=102 //BoWaP
        {
            bowap=1
        }
        else if sp=103
        {
            bowap_arc=1
        }
        else if sp=104
        {
            stutter=1
            bowap=0
        }
        else if sp=105
        {
            //despawn
            stutter=0
        }
        else if sp>=106 and sp<=137 // DANCE
        {
            if sp<=121
            {
            }
            else
            {
            }
        }
        sp+=1
    }
    if bowap_arc=1
    {
        //colours
    }
    if bowap=1 and t mod 5=0
    {
        shootAppleCircle(x,y,oApRed,5,bowap_speed,tempDir,0,0,-1)
        bcount+=1
        tempDir+=sin(bcount)*36
    }
    else if stutter=1 and t mod 5=0
    {
        if t mod 15=0 {shootAppleCircle(x,y,oApRed,5,bowap_speed,tempDir,0,0,-1)}
        bcount+=1
        tempDir+=sin(bcount)*6
    }
}
