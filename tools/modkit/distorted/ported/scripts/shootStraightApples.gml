//this is a script
/*
This script shoots apples from a line.
shootStraightApples(originX,originY,spawnDirection,spawnDistance,spawnAccel,number,colour,speed,direction,decay)

argument0: origin x
argument1: origin y
argument2: spawn direction
argument3: spawn distance
argument4: "acceleration"
argument5: number of apples to create
argument6: apple colour (string naming the apple to be created, e.g. oApGreen)
argument7: apple speed
argument8: apple direction
argument9: apple decay time (-1 for unlimited)
*/

var oriX,oriY,spawnDir,spawnDist,spawnAcc,Anumber,Acolour,Aspeed,Adir,Adecay;

oriX=argument0
oriY=argument1
spawnDir=argument2
spawnDist=argument3
spawnAcc=argument4
Anumber=argument5
Acolour=argument6
Aspeed=argument7
Adir=argument8
Adecay=argument9
newx=0
nexy=0

//sound here

var jjj;
for(jjj=0;jjj<Anumber;jjj+=1)
{
    newx=oriX+lengthdir_x(jjj*spawnDist,spawnDir)
    newy=oriY+lengthdir_y(jjj*spawnDist,spawnDir)
    var Apple;
    Apple=instance_create(newx,newy,Acolour)
    //Apple.bulSpd=Aspeed+jjj*spawnAcc; Apple.decay=Adecay; Apple.direction=Adir+jjj*spawnAcc; Apple.type=0
    Apple.bulSpd=Aspeed+jjj*spawnAcc; Apple.decay=Adecay; Apple._direction=Adir+jjj*spawnAcc; Apple.type=0 //60fps change: DT3+'s Executive bullets move by their own _direction
}
