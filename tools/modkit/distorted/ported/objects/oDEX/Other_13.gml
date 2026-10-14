///PHASE 3 - Dance-off

x=912
y=96

//first call inits
if atkTime[0]=1
{
    //convenience
    NUMBER_OF_SECONDS=90
    NUMBER_OF_FRAMES=30*NUMBER_OF_SECONDS
    //spikes
    ssat=instance_create(1024,280,oStaticSpike)
    //ssat.image_xscale=2; ssat.image_yscale=2
    ssit=instance_create(1024,280,oStaticSpike)
    //ssit.image_xscale=2; ssit.image_yscale=2
    ssut=instance_create(1024,280,oStaticSpike)
    //ssut.image_xscale=2; ssut.image_yscale=2
    sset=instance_create(1024,280,oStaticSpike)
    //sset.image_xscale=2; sset.image_yscale=2
}
//life loss
//life-=20000/(30*NUMBER_OF_SECONDS+7*30)
life-=20000/(30*NUMBER_OF_SECONDS+7*30)*gDeltaTime //60fps change: per frame
//force position
oPlayer1.x=800
oPlayer1.y=313
oPlayer1.image_xscale=1
//no dash recovery
oPlayer1.dashRecovery=0
//correction for missing 1 energy
if oPlayer1.dashEnergy<9000 and tempFlag=0
{
    oPlayer1.dashEnergy+=1
    tempFlag=1
}

//fast parries and switches
oPlayer1.blockForceTime=0
oPlayer1.charSwapRecover=0

// ============================ FIX THIS ============================
//danceTime+=4
danceTime+=4*gDeltaTime //60fps change: per frame
if danceTime>360 {danceTime-=360}
/*if danceTime=25
{
    cycleCounter+=1
    if cycleCounter mod 2=0
    {
        image_angle-=30
    }
    else
    {
        image_angle+=cycleCounter
    }
    danceTime=0
}*/

//spike attacks
// while dash doesn't recover, we don't need this

if atkTime[0]>NUMBER_OF_FRAMES*0.8+110
{
    //sset.x+=5
    sset.x+=5*gDeltaTime //60fps change: per frame
}
else if atkTime[0]>NUMBER_OF_FRAMES*0.8 and atkTime[0]<NUMBER_OF_FRAMES*0.8+80
{
    //sset.x-=5
    sset.x-=5*gDeltaTime //60fps change: per frame
}
else if atkTime[0]>NUMBER_OF_FRAMES*0.6-15
{
    //ssut.x-=5
    ssut.x-=5*gDeltaTime //60fps change: per frame
}
else if atkTime[0]>NUMBER_OF_FRAMES*0.4
{
    //ssit.x-=5
    ssit.x-=5*gDeltaTime //60fps change: per frame
}
else if atkTime[0]>NUMBER_OF_FRAMES*0.2
{
    //ssat.x-=5
    ssat.x-=5*gDeltaTime //60fps change: per frame
}

//all other attacks
//idea: 45 / 35 / 25
if atkTime[0]<NUMBER_OF_FRAMES*0.3
{
    if atkTime[1]>=delayPhase1
    {
        if tempRand mod 2=0
        {
            shootStraightApples(x,y,0,0,0,1,oApBlue,5.5,point_direction(x,y,oPlayer1.x,returnPlayerYCenter()),-1)
        }
        else
        {
            tNewAtk=instance_create(oPlayer1.x+18,DOY,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
        }
        tempRand=(tempRand*17+41) mod 97
        atkTime[1]=0
    }
}
else if atkTime[0]<NUMBER_OF_FRAMES*0.6
{
    if atkTime[1]>=delayPhase2
    {
        if tempRand mod 2=0
        {
            shootAppleCircle(oPlayer1.x,DOY,oApBlue,7,5,irandom(359),160,180,-1)
        }
        else
        {
            tNewAtk=instance_create(oPlayer1.x+18,DOY,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
        }
        tempRand=(tempRand*17+41) mod 97
        atkTime[1]=0
    }
}
else
{
    if atkTime[1]>=delayPhase3
    {
        if tempRand mod 2=0
        {
            shootAppleCircle(oPlayer1.x,DOY,oApBlue,15,6,irandom(359),192,180,-1)
        }
        else
        {
            tNewAtk=instance_create(oPlayer1.x+18,DOY,oDEXslash); tNewAtk.image_xscale=-1; tNewAtk.myScl=-1
        }
        tempRand=(tempRand*17+41) mod 97
        atkTime[1]=0
    }
}

//Fakeout circles with lesser offset of red apples at some fixed times.
if atkTime[0] mod 450=0 and atkTime[0]>0
{
    shootAppleCircle(oPlayer1.x,DOY,oApRed,fakeNum,6,irandom(359),160,150,-1)
    fakeNum+=1
}

//draw our boy Seph
// tact is per half second, so 30 frames for one full cycle should be good
if tempSeph=-1 {tempSeph=0}
//sephSup+=1
sephSup+=1*gDeltaTime //60fps change: per frame
if sephSup>=0 and sephSup<=4
    tempSeph=1
else if (sephSup>=5 and sephSup<=7) or (sephSup>=27 and sephSup<=29)
    tempSeph=2
else if (sephSup>=8 and sephSup<=11) or (sephSup>=23 and sephSup<=26)
    tempSeph=3
else if (sephSup>=12 and sephSup<=14) or (sephSup>=20 and sephSup<=22)
    tempSeph=4
else if sephSup>=15 and sephSup<=19
    tempSeph=5
else if sephSup>=30
{
    tempSeph=1
    sephSup=0
}
