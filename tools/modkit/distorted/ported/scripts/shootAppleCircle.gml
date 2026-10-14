//this is a script
/*
This script creates an apple circle.
shootAppleCircle(originX,originY,colour,number,apspeed,circleDir,radius,setoffAngle,decaytime)

argument0: origin x
argument1: origin y
argument2: apple colour (string naming the apple to be created, e.g. oApGreen)
argument3: number of apples to create
argument4: apple speed
argument5: circle direction
argument6: radius (nonnegative)
argument7: setoff angle (also used for inverse circles, e.g. 180 for an exact inverse)
argument8: apple decay time (-1 for unlimited)
*/

var circleX,circleY,circleDir,circleRadius,circleSetoff,Acolour,Anumber,Aspeed,Adecay;

circleX=argument0
circleY=argument1
circleDir=argument5
circleRadius=argument6
circleSetoff=argument7
Acolour=argument2
Anumber=argument3
Aspeed=argument4
Adecay=argument8
angleInc=360/Anumber
newx=0
nexy=0

//sound here

var iii;
for(iii=0;iii<Anumber;iii+=1)
{
    newx=circleX+lengthdir_x(circleRadius,circleDir+iii*angleInc)
    newy=circleY+lengthdir_y(circleRadius,circleDir+iii*angleInc)
    var Apple;
    Apple=instance_create(newx,newy,Acolour)
    //Apple.bulSpd=Aspeed; Apple.decay=Adecay; Apple.direction=circleDir+iii*angleInc+circleSetoff; Apple.type=0
    Apple.bulSpd=Aspeed; Apple.decay=Adecay; Apple._direction=circleDir+iii*angleInc+circleSetoff; Apple.type=0 //60fps change: DT3+'s Executive bullets move by their own _direction
}
