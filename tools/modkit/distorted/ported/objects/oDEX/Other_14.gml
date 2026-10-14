with (other)
{
///PHASE 4 - Mixed

//infinite double jumps
oPlayer1.doubleJumpCheck=1
//torus
if oPlayer1.y>368 {oPlayer1.y=0}
if oPlayer1.y<=-16 {oPlayer1.y=352}
if oPlayer1.x<=680 {oPlayer1.x=1047}
if oPlayer1.x>=1048 {oPlayer1.x=681}

//if cycleCounter>0 {cycleCounter-=1}
if cycleCounter>0 {cycleCounter-=1*gDeltaTime} //60fps change: per frame

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
    xvel=-2.9*0.9
    yvel=3.4*0.9
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
//if bossProgress=2 and atkTime[2]>4
if bossProgress=2 and atkTime[2]>=5 //60fps change: 5, where >4 first held at 30fps
{
    yDist=point_distance(0,0,xvel,yvel)
    //direction=(9*direction+point_direction(x,y,oPlayer1.x,returnPlayerYCenter()))/10
    //xvel=(29*xvel+hspeed)/30
    //yvel=(29*yvel+vspeed)/30
    //60fps change: as GameMaker's built-in direction/hspeed/vspeed did it (setting direction turns the motion), with
    //the boss's _hspeed/_vspeed
    var tTurnSpd,tTurnDir;
    tTurnSpd=point_distance(0,0,_hspeed,_vspeed)
    tTurnDir=(9*point_direction(0,0,_hspeed,_vspeed)+point_direction(x,y,oPlayer1.x,returnPlayerYCenter()))/10
    xvel=(29*xvel+lengthdir_x(tTurnSpd,tTurnDir))/30
    yvel=(29*yvel+lengthdir_y(tTurnSpd,tTurnDir))/30
    yDist/=point_distance(0,0,xvel,yvel)
    xvel*=yDist
    yvel*=yDist
    atkTime[2]=0
}

if atkTime[1]=applewait - 5*(bossProgress-1)
{
    //green - circle
    shootAppleCircle(x,y,oApGreen,20,3,irandom(359),0,0,-1)
}
else if atkTime[1]=2*applewait - 10*(bossProgress-1)
{
    if bossProgress=2
    {
        // omnislash
        for(i=0;i<4;i+=1)
        {
            tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=1; tNewAtk.myScl=1.5
            tNewAtk.image_angle=i*45
            tNewAtk=instance_create(x,y,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1.5
            tNewAtk.image_angle=i*45
        }
    }
    else
    {
        shootAppleCircle(x,y,oApGreen,20,3,irandom(359),0,0,-1)
    }
}
else if atkTime[1]>=3*applewait - 15*(bossProgress-1)
{
    shootAppleCircle(x,y,oApBlue,30,2-bossProgress,irandom(359),24,0,-1)
    if !instance_exists(oApRed)
    {
            var Apple;
            Apple=instance_create(x,y,oApRed)
            //Apple.bulSpd=4; Apple.decay=-1; Apple.direction=direction+180; Apple.type=0
            Apple.bulSpd=4; Apple.decay=-1; Apple._direction=point_direction(0,0,_hspeed,_vspeed)+180; Apple.type=0 //60fps change: _direction, and the boss's motion direction from _hspeed/_vspeed
            Apple.image_xscale=2; Apple.image_yscale=2
    }
    atkTime[1]=0
}

with oApRed
{
    //if x<672 and hspeed<0 {x=1056}
    //else if x>1056 and hspeed>0 {x=672}
    //if y<0 and vspeed<0 {y=352}
    //else if y>352 and vspeed>0 {y=0}
    //60fps change: the apples move by _speed/_direction
    if x<672 and lengthdir_x(_speed,_direction)<0 {x=1056}
    else if x>1056 and lengthdir_x(_speed,_direction)>0 {x=672}
    if y<0 and lengthdir_y(_speed,_direction)<0 {y=352}
    else if y>352 and lengthdir_y(_speed,_direction)>0 {y=0}
}

if chatcool=15
{
    //warp and leek hit
    if oPlayer1.image_xscale=1
    {
        x=oPlayer1.x - 71
    }
    else if oPlayer1.image_xscale=-1
    {
        x=oPlayer1.x + 71
    }
    //leek damage
    leekX=oPlayer1.x-x
    leekY=returnPlayerYCenter()-y
    leekAngle=-90*oPlayer1.image_xscale
    /*atkPower=1
    takeDamage(oDEX)
    // with oPlayer1 {takeDamage(oDEX)} ???
    atkPower=14*/
    var leek;
    leek=instance_create(oPlayer1.x,returnPlayerYCenter(),oApRed)
    //leek.bulSpd=0; leek.decay=1; leek.direction=0; leek.type=0
    leek.bulSpd=0; leek.decay=1; leek._direction=0; leek.type=0 //60fps change: DT3+'s Executive bullets move by their own _direction
    leek.visible=0; leek.atkPower=1
    var psh;
    psh=instance_create(x,y,oEnemyChat)
    psh.enemyMessage="nothin personnel...."
    chatcool=14
}
//if chatcool>0 and chatcool<15 {chatcool-=1}
if chatcool>0 and chatcool<15 {chatcool-=1*gDeltaTime} //60fps change: per frame

//hspeed=xvel
//vspeed=yvel
_hspeed=xvel //60fps change: moved by correctHSpeedVSpeed in Step, per frame
_vspeed=yvel //60fps change
}
