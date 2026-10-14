//(not used: nothing calls user event 13; the phases are user events 1-5, see Step)
///PHASE 5 - Washing Machine (orig)
// 0 - time
// 1&2 - red spirals
// 3&4 - blue/green spam

//two red spirals, second starting after half rot of first
if atkTime[0]>0 and atkTime[1]>=10
{
    shootAppleCircle(x,y,oApRed,2,redspeed,angleOne,0,0,-1)
    angleOne-=3.3 //orig: 2.2
    atkTime[1]=0
}
if atkTime[0]>820 and atkTime[2]>=10
{
    shootAppleCircle(x,y,oApRed,2,redspeed,angleTwo,0,0,-1)
    angleTwo+=4.8 //orig: 3.2
    atkTime[2]=0
}

//rotation
tempDir=sin(pi*(atkTime[0]-400)/300) //before: /600
with oApGreen {direction-=tempDir}
with oApBlue {direction-=tempDir}

//blue/green spam
if atkTime[0]>400 and atkTime[0]<1001 and atkTime[3]>=10
{
    shootAppleCircle(x,y,oApGreen,12,otherspeed,angleThree,0,0,200)
    cycleCounter+=1
    if cycleCounter<5
    {
        shootAppleCircle(x,y,oApGreen,12,otherspeed,angleFour,0,0,200)
    }
    else
    {
        shootAppleCircle(x,y,oApBlue,12,otherspeed,angleFour,0,0,200)
        cycleCounter=0
    }
    angleThree+=1
    angleFour+=1.5
    atkTime[3]=0
}
else if atkTime[0]>1000 and atkTime[0]<1601 and atkTime[3]>=10
{
    shootAppleCircle(x,y,oApGreen,12,otherspeed,angleThree,0,0,200)
    cycleCounter+=1
    if cycleCounter<5
    {
        shootAppleCircle(x,y,oApGreen,12,otherspeed,angleFour,0,0,200)
    }
    else
    {
        shootAppleCircle(x,y,oApBlue,12,otherspeed,angleFour,0,0,200)
        cycleCounter=0
    }
    angleThree-=1
    angleFour-=1.5
    atkTime[3]=0
}
else if atkTime[0]>=1601
{
    atkTime[0]=401
}



/// orig 4   ===========================================================================================   orig 4
///PHASE 4 - Mixed

//infinite double jumps
oPlayer1.doubleJumpCheck=1
//torus
if oPlayer1.y>368 {oPlayer1.y=0}
if oPlayer1.y<=-16 {oPlayer1.y=352}

if cycleCounter>0 {cycleCounter-=1}
if chatcool>0 {chatcool-=1}

// parry checks
if global.stJGame_C[0]>4000
{
    parryTime+=1
    if parryTime=1
    {
        lastParryChar=global.activeCharacter
        cycleCounter=60
    }
}
else
{
    parryTime=0
}

if bossProgress=0   //initialize phase
{
    //remove walls
    with oInvisibleSolid {x+=10000}
    with oInvisibleSlimSolid {x+=10000}
    //hide tile layer
    tile_layer_hide(1000000)
    //create oExe_Fire walls
    var enemyBarrier; //other object so it's easier to destroy
    enemyBarrier=instance_create(656,0,oEnemyBarrier); enemyBarrier.image_yscale=50; enemyBarrier.visible=0
    enemyBarrier=instance_create(1056,0,oEnemyBarrier); enemyBarrier.image_yscale=50; enemyBarrier.visible=0
    for(i=0;i<4;i+=1)   //destroy criterium: y>270, y<120
    {
        instance_create(664,16+(i*32),oExe_SideFire)
        instance_create(1064,16+(i*32),oExe_SideFire)
        instance_create(664,272+(i*32),oExe_SideFire)
        instance_create(1064,272+(i*32),oExe_SideFire)
    }
    bossProgress=1
    xvel=-2.9
    yvel=3.4
}

//torus code
if xvel>0 and x>Tright
{
    x=Tleft
    playSound(global.snd_Teleport,0,0.92,44100)
    instance_create(x,y,oExe_Ef_Outline)
}
else if xvel<0 and x<Tleft
{
    x=Tright
    playSound(global.snd_Teleport,0,0.92,44100)
    instance_create(x,y,oExe_Ef_Outline)
}
if yvel>0 and y>Tlow
{
    y=Thigh
    playSound(global.snd_Teleport,0,0.92,44100)
    instance_create(x,y,oExe_Ef_Outline)
}
else if yvel<0 and y<Thigh
{
    y=Tlow
    playSound(global.snd_Teleport,0,0.92,44100)
    instance_create(x,y,oExe_Ef_Outline)
}
//some curving at lower health
if life<23000 and atkTime[2]>4
{
    yDist=point_distance(0,0,xvel,yvel)
    direction=(9*direction+point_direction(x,y,oPlayer1.x,returnPlayerYCenter()))/10
    xvel=(29*xvel+hspeed)/30
    yvel=(29*yvel+vspeed)/30
    yDist/=point_distance(0,0,xvel,yvel)
    xvel*=yDist
    yvel*=yDist
}
if life<20000 and atkTime[2]=3 {atkTime[2]=0}


if lastParryChar=1
{
    atkTime[0]=0
    if atkTime[1]=30 and life<16000
    {
        //green - circle
        shootAppleCircle(x,y,oApGreen,24,2,irandom(359),0,0,-1)
    }
    else if atkTime[1]>=60
    {
        //blue - straight shots
        /*tempDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        shootStraightApples(x,y,tempDir+10,4,0.25,4,oApBlue,4,tempDir+10,-1)
        shootStraightApples(x,y,tempDir,4,0.25,4,oApBlue,4,tempDir,-1)
        shootStraightApples(x,y,tempDir-10,4,0.25,4,oApBlue,4,tempDir-10,-1)*/
        shootAppleCircle(x,y,oApBlue,30,0,irandom(359),24,0,-1)
        atkTime[1]=0
    }
    // nothin personnel
    if cycleCounter>0 and global.activeCharacter=0
    {
        warpDist=oPlayer1.x-x
        if warpDist>32 and warpDist<160 and oPlayer1.image_xscale=-1 and oPlayer1.attackState=32
        {
            x=oPlayer1.x+120
            if chatcool=0
            {
                var psh;
                psh=instance_create(x,y,oEnemyChat)
                psh.enemyMessage="nothin personnel...."
                chatcool=30
                tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=1; tNewAtk.myScl=2.4
                tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-2.4
            }
        }
        else if warpDist<-32 and warpDist>-160 and oPlayer1.image_xscale=1 and oPlayer1.attackState=32
        {
            x=oPlayer1.x-120
            if chatcool=0
            {
                var psh;
                psh=instance_create(x,y,oEnemyChat)
                psh.enemyMessage="nothin personnel...."
                chatcool=30
                tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=1; tNewAtk.myScl=2.4
                tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-2.4
            }
        }
    }
}
else if lastParryChar=0
{
    atkTime[1]=0
    //slash behaviour
    if atkTime[0]>=55
    {
        //slash -> myScl=2 (greater than 1)
        tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=1; tNewAtk.myScl=2
        tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-2
        atkTime[0]=0
    }
}
    
hspeed=xvel
vspeed=yvel
