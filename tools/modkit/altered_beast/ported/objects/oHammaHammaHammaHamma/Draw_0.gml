event_inherited()

for (j=0; j<ballsets; j+=1)
{
var tLeftDist,tLeftDir;
    tLeftDist=point_distance(x+offsetLeftX,y+offsetLeftY-j*yDiff,leftBall[j].x,leftBall[j].y)
    tLeftDir=point_direction(x+offsetLeftX,y+offsetLeftY-j*yDiff,leftBall[j].x,leftBall[j].y)
    draw_sprite(sHammaHammaRing,0,x+offsetLeftX,y+offsetLeftY-j*yDiff)
for(i=0;i<3;i+=1)
{
      draw_sprite_ext(sHammaHammaRing,0,x+offsetLeftX+lengthdir_x(tLeftDist*(0.25*(i+1)),tLeftDir),y+offsetLeftY-i*yDiff+lengthdir_y(tLeftDist*(0.25*(i+1)),tLeftDir),image_xscale,image_yscale,image_angle,c_ltgray,image_alpha)
}

var tRightDist,tRightDir;
    tRightDist=point_distance(x+offsetRightX,y+offsetRightY,rightBall[j].x,rightBall[j].y)
    tRightDir=point_direction(x+offsetRightX,y+offsetRightY,rightBall[j].x,rightBall[j].y)
    draw_sprite(sHammaHammaRing,0,x+offsetRightX,y+offsetRightY-j*yDiff)
for(i=0;i<3;i+=1)
{
      draw_sprite(sHammaHammaRing,0,x+offsetRightX+lengthdir_x(tRightDist*(0.25*(i+1)),tRightDir),y+offsetRightY-j*yDiff+lengthdir_y(tRightDist*(0.25*(i+1)),tRightDir))
}
}
